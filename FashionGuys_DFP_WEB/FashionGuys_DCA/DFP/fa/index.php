<?php
include '../components/connect.php';

session_start();

if(isset($_POST['submit'])){
   $name = $_POST['name'];
   $name = filter_var($name, FILTER_SANITIZE_STRING);
   $pass = sha1($_POST['pass']);
   $pass = filter_var($pass, FILTER_SANITIZE_STRING);

   $select_auditor = $conn->prepare("SELECT * FROM `financial_auditors` WHERE name = ? AND password = ?");
   $select_auditor->execute([$name, $pass]);
   $row = $select_auditor->fetch(PDO::FETCH_ASSOC);

   if($select_auditor->rowCount() > 0){
      $_SESSION['auditor_id'] = $row['auditor_id'];
      header('location:dashboard.php');
   }else{
      $message[] = 'Incorrect username or password!';
   }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>FashionGuys | Financial Auditor Login</title>

   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>

<?php
   if(isset($message)){
      foreach($message as $message){
         echo '
         <div class="message">
            <span>'.$message.'</span>
            <i class="fas fa-times" onclick="this.parentElement.remove();"></i>
         </div>
         ';
      }
   }
?>

<section class="login-section min-vh-100 d-flex justify-content-center align-items-center py-4" 
         style="background-color: #ffffff;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 col-xl-5">
                <!-- Card with Glassmorphism -->
                <div class="card border-0 rounded-4 overflow-hidden" 
                     style="background: rgba(255, 255, 255, 0.95);
                            backdrop-filter: blur(10px);
                            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);">
                    
                    <div class="card-body p-4 p-md-5">
                        <!-- Header -->
                        <div class="text-center mb-4">
                            <div class="d-inline-block p-3 rounded-circle mb-3" 
                                 style="background: linear-gradient(135deg, rgba(67, 97, 238, 0.1) 0%, rgba(67, 97, 238, 0.05) 100%);">
                                <i class="fas fa-calculator text-primary fs-4"></i>
                            </div>
                            <h3 class="fw-bold mb-1" style="color: #2b3452;">FashionGuys Financial Auditor</h3>
                            <p class="text-muted small">Enter your username and password to login</p>
                        </div>

                        <!-- Form -->
                        <form action="" method="post">
                            <!-- Username -->
                            <div class="mb-3">
                                <div class="form-floating">
                                    <input type="text" 
                                           name="name" 
                                           class="form-control bg-light border-0" 
                                           id="username" 
                                           placeholder="Username"
                                           required 
                                           maxlength="100"
                                           style="border-radius: 12px;"
                                           oninput="this.value = this.value.replace(/\s/g, '')">
                                    <label class="text-muted">Username</label>
                                </div>
                            </div>

                            <!-- Password -->
                            <div class="mb-4">
                                <div class="form-floating">
                                    <input type="password" 
                                           name="pass" 
                                           class="form-control bg-light border-0" 
                                           id="pass" 
                                           placeholder="Password"
                                           required 
                                           maxlength="20"
                                           style="border-radius: 12px;"
                                           oninput="this.value = this.value.replace(/\s/g, '')">
                                    <label class="text-muted">Password</label>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-grid gap-2">
                                <button type="submit" 
                                        name="submit" 
                                        class="btn btn-primary py-3 rounded-3 fw-semibold"
                                        style="background: linear-gradient(135deg, #C0C0C0 0%, #005F56 100%);">
                                    Sign In
                                </button>
                            </div>
                            <div class="text-center mt-4">
                                <a href="../index.php" class="text-decoration-none text-muted">
                                    <i class="fas fa-arrow-left me-1"></i>
                                    Back to Home
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<style>
.message {
    position: fixed;
    top: 20px;
    left: 50%;
    transform: translateX(-50%);
    background: #dc3545;
    color: white;
    padding: 15px 30px;
    border-radius: 5px;
    display: flex;
    align-items: center;
    z-index: 1000;
}

.message i {
    margin-left: 10px;
    cursor: pointer;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>