# FashionGuys_DFP_WEB

# 🧥 FashionGuys Order & Workflow Management System

This is the **final year school project** developed for an organization named **FashionGuys** to digitize and streamline their internal operations and order management system. The system enables multiple user roles to interact through dedicated portals, covering everything from order placement to delivery, warehouse operations, financial auditing, and customer support.



## 📌 Features by Role

### 👑 Owner
- Add internal staff accounts
- View all orders and payments
- View customer messages sent via system

### 🛍️ Customer
- Place and track orders
- Make online payments
- Communicate with customer support

### 🧑‍💼 Customer Support Unit
- View and respond to customer tickets
- Communicate with customers through the portal

### 📊 Financial Auditor
- View and assign warehouse tasks
- Manage payments and payment gateways

### 🏷️ Product Manager
- Manage inventory/stocks
- Place re-stock requests

### 📦 Warehouse Staff
- View customer orders
- Pack and assign items for delivery

### 🚚 Delivery Person
- View ready-to-deliver packages
- Confirm successful deliveries

---

## 🛠️ Tech Stack

 Layer          Technology                      

 Frontend       HTML, CSS, JavaScript, React     
 Backend        PHP                              
 Database       MySQL                            

---

## 🚀 How to Run the Project

1. **Download the project** and extract it into the `htdocs` folder in your **XAMPP** installation.
2. **Create a MySQL database** and import the provided `dfp.sql` file.
3. **Configure database connection:**
   - Open `/component/connection.php`
   - Change the database name, username, and password as needed

4. **Launch the system in your browser** using: http://localhost/FashionGuys_DCA/DFP/



---

## 🔐 Default Owner Credentials

- **Username:** `admin`
- **Password:** `111`

---

## 🗃️ Database Overview

- Contains **35 tables**
- admins
-cart
-category
-chat_messages
-chat_sessions
-customer_sales_representatives
-customer_support_tickets
-customers
-delivery_agents
-delivery_assignments
-financial_audit_logs
-financial_auditors
-financial_reports
-inventory
-inventory_log
-manager_settings
-messages
-order_items
-orders
-product_manager
-products
-restock_requests
-reviews
-risk_assessments
-shift_change_requests
-staff_tasks
-stock_alert
-suppliers
-supply_order_items
-supply_orders
-ticket_history
-ticket_responses
-users
-warehouse_staff
-wishlist

---

## 👨‍💼 Users & Roles Summary

| Role                | Access & Permissions                                  |
|---------------------|--------------------------------------------------------|
| Owner               | Full access, staff management, message center          |
| Customer            | Orders, payments, support                             |
| Customer Support    | View/respond to tickets                               |
| Financial Auditor   | Warehouse tasking, payment gateway management         |
| Product Manager     | Stock control, re-stocking                            |
| Warehouse Staff     | Package orders, update delivery queue                 |
| Delivery Person     | View and confirm deliveries                           |

---

## 📬 Contact & Feedback

For any queries or support, please open an issue or contact me directly.
(Contact details on the github)

---

## 📄 License

This project is for educational purposes only.



