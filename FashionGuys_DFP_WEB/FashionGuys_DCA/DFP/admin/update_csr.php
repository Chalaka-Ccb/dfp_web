<?php
include '../components/connect.php'; // Adjust path if necessary

session_start();

$admin_id_session = $_SESSION['admin_id'] ?? null; // The ID of the logged-in admin

if(!isset($admin_id_session)){
    header('location:index.php'); // Redirect to login if not authenticated
    exit();
}

// Initialize $message as an empty array
$message = [];

// Get the CSR ID from the URL parameter
$csr_id_to_update = $_GET['id'] ?? null;

if(!$csr_id_to_update){
    // If no ID is provided, redirect back to view_csrs or show an error
    header('location:view_csrs.php');
    exit();
}

// Fetch current CSR details
$select_current_csr = $conn->prepare("SELECT csr_id, name, expertise, password FROM `customer_sales_representatives` WHERE csr_id = ?");
$select_current_csr->execute([$csr_id_to_update]);
$fetch_current_csr = $select_current_csr->fetch(PDO::FETCH_ASSOC);

if(!$fetch_current_csr){
    // CSR not found, redirect
    $message[] = 'Customer Sales Representative not found!';
    header('location:view_csrs.php');
    exit();
}


if(isset($_POST['update_csr'])){
    $id = $_POST['csr_id'];
    $id = filter_var($id, FILTER_SANITIZE_STRING);

    $name = $_POST['name'];
    $name = filter_var($name, FILTER_SANITIZE_STRING);

    $expertise = $_POST['expertise'];
    $expertise = filter_var($expertise, FILTER_SANITIZE_STRING);

    $old_pass = sha1($_POST['old_pass']);
    $old_pass = filter_var($old_pass, FILTER_SANITIZE_STRING);

    $new_pass = sha1($_POST['new_pass']);
    $new_pass = filter_var($new_pass, FILTER_SANITIZE_STRING);

    $cpass = sha1($_POST['cpass']);
    $cpass = filter_var($cpass, FILTER_SANITIZE_STRING);

    $prev_pass_check = $conn->prepare("SELECT password FROM `customer_sales_representatives` WHERE csr_id = ?");
    $prev_pass_check->execute([$id]);
    $prev_pass_row = $prev_pass_check->fetch(PDO::FETCH_ASSOC);
    $prev_password_db = $prev_pass_row['password'];


    // Check if username already exists for another CSR
    $select_existing_name = $conn->prepare("SELECT csr_id FROM `customer_sales_representatives` WHERE name = ? AND csr_id != ?");
    $select_existing_name->execute([$name, $id]);
    if($select_existing_name->rowCount() > 0){
        $message[] = 'Username already exists for another Customer Sales Representative!';
    } else {
        // Update name and expertise
        $update_csr_details = $conn->prepare("UPDATE `customer_sales_representatives` SET name = ?, expertise = ? WHERE csr_id = ?");
        $update_csr_details->execute([$name, $expertise, $id]);
        if($update_csr_details->rowCount() > 0) {
            $message[] = 'CSR details updated successfully!';
        }

        // Update password if new password fields are filled and match
        if(!empty($_POST['new_pass'])){ // Only update if new password is provided
            if($old_pass != $prev_password_db){
                $message[] = 'Old password does not match!';
            } elseif($new_pass != $cpass){
                $message[] = 'Confirm new password does not match!';
            } else {
                $update_password = $conn->prepare("UPDATE `customer_sales_representatives` SET password = ? WHERE csr_id = ?");
                $update_password->execute([$cpass, $id]); // $cpass holds the hashed new_pass
                if($update_password->rowCount() > 0) {
                    $message[] = 'Password updated successfully!';
                }
            }
        } else {
            // No new password provided, just check if name/expertise was updated
            if($update_csr_details->rowCount() == 0) { // If details update didn't change anything
                 $message[] = 'No changes made or other error occurred!';
            }
        }
    }

    // After update, re-fetch the CSR details to display latest
    $select_current_csr->execute([$csr_id_to_update]);
    $fetch_current_csr = $select_current_csr->fetch(PDO::FETCH_ASSOC);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionGuys | Update CSR</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #005F56;
            --secondary-color: #3f37c9;
            --accent-color: #C0C0C0;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
        }
        body {
            background-color: #f8f9fa;
        }
        .content-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            margin: 2rem auto;
            max-width: 500px;
        }
        .card-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .header-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            background: linear-gradient(135deg, rgba(67, 97, 238, 0.1), rgba(72, 149, 239, 0.1));
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin: 0 auto 1rem;
        }
        .header-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2b3452;
            margin-bottom: 0.5rem;
        }
        .custom-input {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem;
            transition: all 0.3s ease;
        }
        .custom-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
        }
        .custom-button {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .custom-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
        }
        .alert {
            border-radius: 12px;
            padding: 1rem;
            font-weight: 500;
        }
        .alert-success {
            background-color: rgba(46, 204, 113, 0.1);
            color: #2ecc71;
            border: 1px solid rgba(46, 204, 113, 0.2);
        }
        .alert-danger {
            background-color: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            border: 1px solid rgba(231, 76, 60, 0.2);
        }
        @media (max-width: 768px) {
            .content-card {
                padding: 1rem;
                margin: 1rem;
                width: 95%;
            }
        }
    </style>
</head>
<body>

<?php include '../components/admin_header_other.php'; ?>

<section class="update-csr mt-5">
    <div class="content-card">
        <div class="card-header">
            <div class="header-icon">
                <i class="fas fa-user-edit"></i>
            </div>
            <h2 class="header-title">Update CSR: <?= htmlspecialchars($fetch_current_csr['name']); ?></h2>
            <p class="text-muted">Modify CSR details or change password</p>
        </div>

        <?php

        // Ensure $message is an array, even if it was accidentally set as a string earlier
        if (isset($message) && !is_array($message)) {
            $message = [$message]; // Convert it into an array containing the single string
        }

        if (!empty($message)) {
            foreach ($message as $msg) {
                $alertClass = strpos($msg, 'successfully') !== false ? 'alert-success' : 'alert-danger';
                echo '<div class="alert ' . $alertClass . ' text-center mb-4">' . htmlspecialchars($msg) . '</div>';
            }
        }
        ?>

        <form action="" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="csr_id" value="<?= htmlspecialchars($fetch_current_csr['csr_id']); ?>">
            <!-- Name Input -->
            <div class="mb-4">
                <div class="form-floating">
                    <input type="text"
                           id="name"
                           name="name"
                           class="form-control custom-input"
                           placeholder="CSR name"
                           value="<?= htmlspecialchars($fetch_current_csr['name']); ?>"
                           required
                           maxlength="30">
                    <label for="name">CSR Name</label>
                    <div class="invalid-feedback">
                        Please enter a name (max 30 characters)
                    </div>
                </div>
            </div>

            <!-- Expertise Input -->
            <div class="mb-4">
                <div class="form-floating">
                    <input type="text"
                           id="expertise"
                           name="expertise"
                           class="form-control custom-input"
                           placeholder="CSR expertise"
                           value="<?= htmlspecialchars($fetch_current_csr['expertise']); ?>"
                           required
                           maxlength="50">
                    <label for="expertise">Expertise</label>
                    <div class="invalid-feedback">
                        Please enter expertise (max 50 characters)
                    </div>
                </div>
            </div>

            <!-- Old Password Input (for password change) -->
            <div class="mb-4">
                <div class="form-floating">
                    <input type="password"
                           id="old_pass"
                           name="old_pass"
                           class="form-control custom-input"
                           placeholder="Old password (if changing password)"
                           maxlength="20">
                    <label for="old_pass">Old Password (Leave blank to keep current)</label>
                </div>
            </div>

            <!-- New Password Input -->
            <div class="mb-4">
                <div class="form-floating">
                    <input type="password"
                           id="new_pass"
                           name="new_pass"
                           class="form-control custom-input"
                           placeholder="New password (if changing password)"
                           maxlength="20">
                    <label for="new_pass">New Password</label>
                    <div class="invalid-feedback">
                        Please enter a new password (max 20 characters)
                    </div>
                </div>
            </div>

            <!-- Confirm New Password Input -->
            <div class="mb-4">
                <div class="form-floating">
                    <input type="password"
                           id="cpass"
                           name="cpass"
                           class="form-control custom-input"
                           placeholder="Confirm new password"
                           maxlength="20">
                    <label for="cpass">Confirm New Password</label>
                    <div class="invalid-feedback">
                        Please confirm your new password
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit"
                    name="update_csr"
                    class="btn custom-button w-100">
                <i class="fas fa-check-circle me-2"></i>Update CSR
            </button>
            <div class="text-center mt-3">
                <a href="view_csrs.php" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to CSR List
                </a>
            </div>
        </form>
    </div>
</section>

<script>
// Bootstrap 5 form validation
(function () {
    'use strict'
    var forms = document.querySelectorAll('.needs-validation')
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                // Custom validation for passwords
                const newPass = form.querySelector('#new_pass');
                const cPass = form.querySelector('#cpass');
                const oldPass = form.querySelector('#old_pass');

                // If new password fields are filled, old password is required and new passwords must match
                if (newPass.value.length > 0 || cPass.value.length > 0) {
                    if (oldPass.value.length === 0) {
                        oldPass.setCustomValidity('Please enter your old password to change it.');
                    } else {
                        oldPass.setCustomValidity('');
                    }

                    if (newPass.value !== cPass.value) {
                        cPass.setCustomValidity('New password and confirm password do not match.');
                    } else {
                        cPass.setCustomValidity('');
                    }
                } else {
                    // If new password fields are empty, clear custom validities
                    oldPass.setCustomValidity('');
                    cPass.setCustomValidity('');
                }


                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
})()
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/admin_script.js"></script>

</body>
</html>