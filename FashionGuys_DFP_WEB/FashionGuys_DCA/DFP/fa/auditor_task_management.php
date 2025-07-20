<?php
include '../components/connect.php';

session_start();

$auditor_id = $_SESSION['auditor_id'];

if(!isset($auditor_id)){
   header('location:index.php');
   exit();
}

// Handle adding a new task
if(isset($_POST['add_task'])){

   $staff_id = $_POST['staff_id'];
   $staff_id = filter_var($staff_id, FILTER_SANITIZE_STRING);

   $task_name = $_POST['task_name'];
   $task_name = filter_var($task_name, FILTER_SANITIZE_STRING);
   
   $description = $_POST['description'];
   $description = filter_var($description, FILTER_SANITIZE_STRING);
   
   $priority = $_POST['priority'];
   $priority = filter_var($priority, FILTER_SANITIZE_STRING);
   
   $due_date = $_POST['due_date'];
   $due_date = filter_var($due_date, FILTER_SANITIZE_STRING);
   
   $status = 'pending'; // New tasks always start as pending

   $insert_task = $conn->prepare("INSERT INTO `staff_tasks`(staff_id, task_name, description, priority, due_date, status) VALUES(?,?,?,?,?,?)");
   $insert_task->execute([$staff_id, $task_name, $description, $priority, $due_date, $status]);

   $message[] = 'New task assigned successfully!';
}

// Handle deleting a task
if(isset($_POST['delete_task'])){
   $task_id_to_delete = $_POST['task_id'];
   $task_id_to_delete = filter_var($task_id_to_delete, FILTER_SANITIZE_STRING);
   
   $delete_task = $conn->prepare("DELETE FROM `staff_tasks` WHERE task_id = ?");
   $delete_task->execute([$task_id_to_delete]);

   $message[] = 'Task deleted successfully!';
}

// Fetch all tasks for the auditor's view
$select_tasks = $conn->prepare("SELECT st.*, ws.name AS staff_name FROM `staff_tasks` AS st JOIN `warehouse_staff` AS ws ON st.staff_id = ws.staff_id ORDER BY st.due_date ASC");
$select_tasks->execute();

// Fetch staff list for the dropdown
$select_staff = $conn->prepare("SELECT staff_id AS id, name FROM `warehouse_staff`");
$select_staff->execute();
$staff_list = $select_staff->fetchAll(PDO::FETCH_ASSOC);

function getPriorityColor($priority) {
    switch($priority) {
        case 'high': return 'danger';
        case 'medium': return 'warning';
        case 'low': return 'info';
        default: return 'secondary';
    }
}

function getStatusColor($status) {
    switch($status) {
        case 'pending': return 'secondary';
        case 'in_progress': return 'primary';
        case 'completed': return 'success';
        default: return 'secondary';
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionGuys | Task Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .task-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .task-card:hover {
            transform: translateY(-2px);
        }
        .high-priority { border-left: 4px solid #dc3545; }
        .medium-priority { border-left: 4px solid #ffc107; }
        .low-priority { border-left: 4px solid #0dcaf0; }
        .status-badge {
            font-size: 0.8rem;
            padding: 0.4em 0.8em;
            border-radius: 50px;
        }
    </style>
</head>
<body>

<?php include '../components/financial_auditor_header.php'; ?>

<section class="task-management">
    <div class="container py-5">
        <h2 class="text-center mb-5">Financial Auditor Task Management</h2>

        <?php
        if(isset($message)){
           foreach($message as $msg){
              echo '<div class="alert alert-info alert-dismissible fade show text-center" role="alert">
                       <i class="fas fa-info-circle me-2"></i>'. $msg .'
                       <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>';
           }
        }
        ?>

        <div class="card mb-5 shadow-sm">
            <div class="card-body">
                <h4 class="card-title mb-4">Assign a New Task</h4>
                <form action="" method="POST">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="task_name" class="form-label">Task Name</label>
                            <input type="text" name="task_name" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label for="staff_id" class="form-label">Assign to Staff</label>
                            <select name="staff_id" class="form-select" required>
                                <option value="">-- Select Staff --</option>
                                <?php foreach($staff_list as $staff): ?>
                                    <option value="<?= $staff['id']; ?>"><?= htmlspecialchars($staff['name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="description" class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3" required></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="priority" class="form-label">Priority</label>
                            <select name="priority" class="form-select" required>
                                <option value="low">Low</option>
                                <option value="medium">Medium</option>
                                <option value="high">High</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="due_date" class="form-label">Due Date</label>
                            <input type="date" name="due_date" class="form-control">
                        </div>
                        <div class="col-12 text-end">
                            <button type="submit" name="add_task" class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i>Assign Task
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <h4 class="card-title mb-4">All Assigned Tasks</h4>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Task Name</th>
                                <th>Assigned To</th>
                                <th>Priority</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            if($select_tasks->rowCount() > 0){
                                while($task = $select_tasks->fetch(PDO::FETCH_ASSOC)){
                            ?>
                            <tr>
                                <td><?= htmlspecialchars($task['task_name']); ?></td>
                                <td><?= htmlspecialchars($task['staff_name']); ?></td>
                                <td><span class="badge bg-<?= getPriorityColor($task['priority']); ?> status-badge"><?= ucfirst($task['priority']); ?></span></td>
                                <td><?= $task['due_date'] ? date('M d, Y', strtotime($task['due_date'])) : 'N/A'; ?></td>
                                <td><span class="badge bg-<?= getStatusColor($task['status']); ?> status-badge"><?= ucfirst(str_replace('_', ' ', $task['status'])); ?></span></td>
                                <td>
                                    <form action="" method="POST" onsubmit="return confirm('Are you sure you want to delete this task?');">
                                        <input type="hidden" name="task_id" value="<?= $task['task_id']; ?>">
                                        <button type="submit" name="delete_task" class="btn btn-sm btn-danger">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <?php
                                }
                            } else {
                                echo '<tr><td colspan="6" class="text-center text-muted">No tasks have been assigned yet.</td></tr>';
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</section>

</body>
</html>