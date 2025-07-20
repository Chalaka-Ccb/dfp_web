<?php
include '../components/connect.php'; // Adjust path if necessary

session_start();

$admin_id = $_SESSION['admin_id'] ?? null; // Use null coalescing for safety

if(!isset($admin_id)){
    header('location:index.php'); // Redirect to login if not authenticated
    exit();
}

// Initialize $message as an empty array
$message = [];

// Handle delete action if submitted from this page
if(isset($_POST['delete_auditor'])){
    $delete_id = $_POST['auditor_id'];
    $delete_id = filter_var($delete_id, FILTER_SANITIZE_STRING);

    $delete_auditor = $conn->prepare("DELETE FROM `financial_auditors` WHERE auditor_id = ?");
    $delete_auditor->execute([$delete_id]);

    if($delete_auditor->rowCount() > 0){
        $message[] = 'Financial Auditor deleted successfully!';
    } else {
        $message[] = 'Failed to delete Financial Auditor or auditor not found!';
    }
}

// Fetch all financial auditors
$select_auditors = $conn->prepare("SELECT auditor_id, name, certification, phone FROM `financial_auditors`");
$select_auditors->execute();
$auditors = $select_auditors->fetchAll(PDO::FETCH_ASSOC);

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionGuys | View Financial Auditors</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #005F56;
            --secondary-color: #3f37c9; /* Adjusted to match your add page secondary color */
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
            max-width: 900px; /* Wider card for table */
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
        .table-responsive {
            margin-top: 1.5rem;
        }
        .table-custom thead th {
            background-color: var(--secondary-color);
            color: white;
            border-bottom: none;
        }
        .table-custom tbody tr {
            border-bottom: 1px solid #e9ecef;
        }
        .table-custom tbody tr:last-child {
            border-bottom: none;
        }
        .btn-action {
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .btn-edit {
            background-color: var(--primary-color);
            color: white;
            border: none;
        }
        .btn-edit:hover {
            background-color: darken(var(--primary-color), 10%);
            color: white;
        }
        .btn-delete {
            background-color: var(--danger-color);
            color: white;
            border: none;
        }
        .btn-delete:hover {
            background-color: darken(var(--danger-color), 10%);
            color: white;
        }
        .alert {
            border-radius: 12px;
            padding: 1rem;
            font-weight: 500;
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1050;
            width: 90%;
            max-width: 500px;
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
    </style>
</head>
<body>

<?php include '../components/admin_header_other.php'; ?>

<section class="view-financial-auditors mt-5">
    <div class="content-card">
        <div class="card-header">
            <div class="header-icon">
                <i class="fas fa-chart-line"></i> </div>
            <h2 class="header-title">Manage Financial Auditors</h2>
            <p class="text-muted">View, update, or remove existing Financial Auditor accounts</p>
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

        <div class="table-responsive">
            <table class="table table-hover align-middle table-custom">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Certification</th>
                        <th>Phone</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (count($auditors) > 0): ?>
                        <?php foreach ($auditors as $auditor): ?>
                            <tr>
                                <td><?= htmlspecialchars($auditor['auditor_id']); ?></td>
                                <td><?= htmlspecialchars($auditor['name']); ?></td>
                                <td><?= htmlspecialchars($auditor['certification']); ?></td>
                                <td><?= htmlspecialchars($auditor['phone']); ?></td>
                                <td class="text-center">
                                    <a href="update_financial_auditor.php?id=<?= $auditor['auditor_id']; ?>" class="btn btn-action btn-edit me-2">
                                        <i class="fas fa-edit"></i> Update
                                    </a>
                                    <form action="" method="post" style="display:inline-block;" onsubmit="return confirm('Are you sure you want to delete this Financial Auditor?');">
                                        <input type="hidden" name="auditor_id" value="<?= $auditor['auditor_id']; ?>">
                                        <button type="submit" name="delete_auditor" class="btn btn-action btn-delete">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr>
                            <td colspan="5" class="text-center py-4">No Financial Auditors found.</td>
                        </tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <div class="text-center mt-4">
            <a href="../admin/user_management.php" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Back to User Management
            </a>
        </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/admin_script.js"></script>

</body>
</html>