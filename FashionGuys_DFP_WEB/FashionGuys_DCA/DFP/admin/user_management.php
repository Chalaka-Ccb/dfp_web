<?php
include '../components/connect.php'; // Adjust path if necessary

session_start();

$admin_id = $_SESSION['admin_id'] ?? null; // Use null coalescing for safety

if(!isset($admin_id)){
   header('location:index.php'); // Redirect to login if not authenticated
   exit();
}

// No specific message handling on this page, as actions are redirected
?>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>FashionGuys | User Management Dashboard</title>

   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

   <style>
      :root {
         --primary-color: #005F56;
         --secondary-color: #3f37c9;
         --accent-color: #C0C0C0;
         --success-color: #2ecc71;
         --danger-color: #dc3545;
         --warning-color: #f39c12;
      }

      body {
         font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
         background-color: #f0f2f5;
         color: #333;
      }

      /* Main Content Card */
      .content-card {
         background: white;
         border-radius: 20px;
         padding: 2.5rem;
         box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
         margin: 3rem auto;
         max-width: 1200px; /* Adjusted for more roles */
      }

      /* Card Header */
      .card-header {
         text-align: center;
         margin-bottom: 3rem;
      }

      .header-icon {
         width: 70px;
         height: 70px;
         border-radius: 20px;
         background: linear-gradient(135deg, rgba(67, 97, 238, 0.1), rgba(72, 149, 239, 0.1));
         color: var(--primary-color);
         display: flex;
         align-items: center;
         justify-content: center;
         font-size: 2rem;
         margin: 0 auto 1.5rem;
      }

      .header-title {
         font-size: 2rem;
         font-weight: 700;
         color: #2b3452;
         margin-bottom: 0.75rem;
      }

      .text-muted {
         color: #6c757d !important;
      }

      /* Role Section Grouping */
      .role-group {
          margin-bottom: 3rem;
          padding-bottom: 2rem;
          border-bottom: 1px solid #e9ecef;
      }
      .role-group:last-child {
          border-bottom: none;
          margin-bottom: 0;
          padding-bottom: 0;
      }

      .role-group h3 {
         font-size: 1.6rem;
         font-weight: 600;
         color: var(--secondary-color);
         margin-bottom: 2rem;
         text-align: center;
         position: relative;
      }
      .role-group h3::after {
          content: '';
          display: block;
          width: 60px;
          height: 3px;
          background-color: var(--primary-color);
          margin: 10px auto 0;
          border-radius: 5px;
      }

      /* Action Grid for each role */
      .action-grid {
         display: grid;
         grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
         gap: 1.5rem;
         justify-content: center;
      }

      .action-card {
         background-color: #fcfcfc;
         border-radius: 15px;
         padding: 1.5rem;
         display: flex;
         flex-direction: column;
         align-items: center;
         text-align: center;
         transition: all 0.3s ease;
         text-decoration: none;
         color: #2b3452;
         box-shadow: 0 5px 15px rgba(0, 0, 0, 0.03);
         border: 1px solid #e9ecef;
      }

      .action-card:hover {
         transform: translateY(-5px);
         box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
         background-color: #ffffff;
         border-color: var(--primary-color);
      }

      .action-card i {
         font-size: 2.8rem;
         color: var(--primary-color);
         margin-bottom: 1rem;
      }
      /* Specific icon colors (for consistency with previous styles) */
      .action-card.admin-icon i { color: #0d6efd; } /* Bootstrap primary */
      .action-card.csr-icon i { color: #198754; } /* Bootstrap success */
      .action-card.delivery-icon i { color: #0dcaf0; } /* Bootstrap info */
      .action-card.auditor-icon i { color: #8A2BE2; } /* BlueViolet */
      .action-card.product-manager-icon i { color: #ffc107; } /* Bootstrap warning */
      .action-card.warehouse-icon i { color: #dc3545; } /* Bootstrap danger */
      .action-card.supplier-icon i { color: #6c757d; } /* Bootstrap secondary */


      .action-card h4 {
         font-size: 1.2rem;
         font-weight: 700;
         margin-bottom: 0.5rem;
      }

      .action-card p {
         font-size: 0.95rem;
         color: #6c757d;
         line-height: 1.4;
      }

      /* Back button style */
      .back-btn-container {
         text-align: center;
         margin-top: 3rem;
      }

      .back-btn {
         padding: 0.8rem 2.5rem;
         background-color: #6c757d;
         color: white;
         border-radius: 10px;
         text-decoration: none;
         font-weight: 600;
         transition: background-color 0.2s ease, transform 0.2s ease;
         box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      }

      .back-btn:hover {
         background-color: #5a6268;
         color: white;
         transform: translateY(-2px);
      }

      @media (max-width: 992px) {
          .content-card {
              max-width: 90%;
          }
      }
      @media (max-width: 768px) {
         .content-card {
            padding: 1.5rem;
            margin: 1.5rem auto;
         }
         .header-title {
            font-size: 1.8rem;
         }
         .role-group h3 {
             font-size: 1.4rem;
             margin-bottom: 1.5rem;
         }
         .action-grid {
            grid-template-columns: 1fr; /* Stack columns on small screens */
         }
         .action-card {
             padding: 1.2rem;
         }
         .action-card h4 {
             font-size: 1.1rem;
         }
         .action-card p {
             font-size: 0.85rem;
         }
      }
   </style>
</head>
<body>

<?php include '../components/admin_header_other.php'; ?>

<section class="user-management mt-5">
   <div class="content-card">
      <div class="card-header">
         <div class="header-icon">
            <i class="fas fa-users-cog"></i>
         </div>
         <h2 class="header-title">User Management Dashboard</h2>
         <p class="text-muted">Centralized portal to manage all staff accounts.</p>
      </div>

      <!-- Administrator Section -->
      <div class="role-group">
         <h3>Administrators</h3>
         <div class="action-grid">
            <a href="add-admin.php" class="action-card admin-icon">
               <i class="fas fa-user-plus"></i>
               <h4>Add New Owner</h4>
               <p>Register a new Owner account with full system access.</p>
            </a>
            <a href="view-admin.php" class="action-card admin-icon">
               <i class="fas fa-users-cog"></i>
               <h4>Manage Owner</h4>
               <p>View, update details, or remove existing Owner accounts.</p>
            </a>
         </div>
      </div>

      <!-- Customer Sales Representatives Section -->
      <div class="role-group">
         <h3>Customer Sales Representatives</h3>
         <div class="action-grid">
            <a href="add-customer-sales-representative.php" class="action-card csr-icon">
               <i class="fas fa-headset"></i>
               <h4>Add New CSR</h4>
               <p>Create an account for customer service and sales support staff.</p>
            </a>
            <a href="view_csrs.php" class="action-card csr-icon">
               <i class="fas fa-user-friends"></i>
               <h4>Manage CSRs</h4>
               <p>View, update details, or remove customer service representatives.</p>
            </a>
         </div>
      </div>

      <!-- Delivery Agents Section -->
      <div class="role-group">
         <h3>Delivery Agents</h3>
         <div class="action-grid">
            <a href="add-delivery-agent.php" class="action-card delivery-icon">
               <i class="fas fa-truck-loading"></i>
               <h4>Add New Delivery Agent</h4>
               <p>Register new personnel responsible for product deliveries.</p>
            </a>
            <a href="view_delivery_agents.php" class="action-card delivery-icon">
               <i class="fas fa-truck-ramp-box"></i>
               <h4>Manage Delivery Agents</h4>
               <p>View, update details, or remove delivery agent accounts.</p>
            </a>
         </div>
      </div>

      <!-- Financial Auditors Section -->
      <div class="role-group">
         <h3>Financial Auditors</h3>
         <div class="action-grid">
            <a href="add-financial-auditor.php" class="action-card auditor-icon">
               <i class="fas fa-calculator"></i>
               <h4>Add New Auditor</h4>
               <p>Onboard new staff for financial analysis and auditing tasks.</p>
            </a>
            <a href="view_financial_auditors.php" class="action-card auditor-icon">
               <i class="fas fa-chart-line"></i>
               <h4>Manage Auditors</h4>
               <p>View, update details, or remove financial auditor accounts.</p>
            </a>
         </div>
      </div>

      <!-- Product Managers Section -->
      <div class="role-group">
         <h3>Product Managers</h3>
         <div class="action-grid">
            <a href="add-product-manager.php" class="action-card product-manager-icon">
               <i class="fas fa-box-open"></i>
               <h4>Add New Product Manager</h4>
               <p>Register staff responsible for product catalog and inventory.</p>
            </a>
            <a href="view_product_managers.php" class="action-card product-manager-icon">
               <i class="fas fa-sitemap"></i>
               <h4>Manage Product Managers</h4>
               <p>View, update details, or remove product manager accounts.</p>
            </a>
         </div>
      </div>

      <!-- Suppliers Section -->
      <div class="role-group">
         <h3>Suppliers</h3>
         <div class="action-grid">
            <a href="add-supplier.php" class="action-card supplier-icon">
               <i class="fas fa-dolly"></i>
               <h4>Add New Supplier</h4>
               <p>Onboard new external partners for supply chain management.</p>
            </a>
            <a href="view_suppliers.php" class="action-card supplier-icon">
               <i class="fas fa-industry"></i>
               <h4>Manage Suppliers</h4>
               <p>View, update details, or remove supplier accounts.</p>
            </a>
         </div>
      </div>

      <!-- Warehouse Staff Section -->
      <div class="role-group">
         <h3>Warehouse Staff</h3>
         <div class="action-grid">
            <a href="add-warehouse-staff.php" class="action-card warehouse-icon">
               <i class="fas fa-warehouse"></i>
               <h4>Add New Staff</h4>
               <p>Register personnel for inventory and order processing in the warehouse.</p>
            </a>
            <a href="view_warehouse_staff.php" class="action-card warehouse-icon">
               <i class="fas fa-people-carry-box"></i>
               <h4>Manage Staff</h4>
               <p>View, update details, or remove warehouse staff accounts.</p>
            </a>
         </div>
      </div>

      <div class="back-btn-container">
         <a href="../admin/dashboard.php" class="back-btn">
            <i class="fas fa-arrow-left me-2"></i>Back to Owner's Dashboard
         </a>
      </div>

   </div>
</section>

</body>
</html>