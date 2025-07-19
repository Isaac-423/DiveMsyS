<%@ page import="model.Driver" %>
<%@ page import="java.util.List" %>
<%
    List<Driver> drivers = (List<Driver>) request.getAttribute("drivers");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Management Dashboard</title>
    <style>
        :root {
            --primary: #ff6b00;
            --primary-dark: #e05d00;
            --secondary: #2c3e50;
            --bg-light: #f8f9fa;
            --bg-white: #ffffff;
            --border-light: #e9ecef;
            --text-dark: #333;
            --status-active: #00cc44;
            --status-inactive: #f39c12;
            --status-suspended: #e74c3c;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
        }

        .header {
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--bg-white);
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .header h2 {
            margin: 0;
            font-weight: 600;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .logout-btn {
            background-color: var(--primary);
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: var(--primary-dark);
        }

        .table-section {
            margin: 40px;
            background-color: var(--bg-white);
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            padding: 30px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-box {
            display: flex;
            gap: 10px;
        }

        .search-box input[type="text"] {
            padding: 10px 20px;
            border: 1px solid var(--border-light);
            border-radius: 30px;
            width: 300px;
            background-color: var(--bg-light);
        }

        .search-box input[type="submit"] {
            padding: 10px 20px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .search-box input[type="submit"]:hover {
            background-color: var(--primary-dark);
        }

        .add-btn {
            background-color: var(--primary);
            color: white;
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .add-btn:hover {
            background-color: var(--primary-dark);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 8px;
        }

        th {
            background-color: var(--bg-light);
            padding: 15px 20px;
            text-align: left;
            font-weight: 600;
        }

        tr {
            background-color: var(--bg-white);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            border-radius: 8px;
        }

        td {
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-light);
        }

        .status {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            color: #fff;
            text-transform: capitalize;
        }

        .status.active {
            background-color: var(--status-active);
        }

        .status.inactive {
            background-color: var(--status-inactive);
        }

        .status.suspended {
            background-color: var(--status-suspended);
        }

        .actions a button {
            background-color: var(--primary);
            border: none;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 5px;
            transition: background-color 0.3s;
        }

        .actions a button:hover {
            background-color: var(--primary-dark);
        }

        @media (max-width: 768px) {
            .top-bar {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }

            .search-box {
                width: 100%;
            }

            .search-box input[type="text"] {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <h2>Driver Management Dashboard</h2>
    <div class="profile">
        Hello, Manager
        <img src="images/149071.png" alt="Avatar">
        <a href="driver_manager_login.jsp" class="logout-btn">Logout</a>
    </div>
</div>

<div class="table-section">
    <div class="top-bar">
        <form action="DriverCRUDServlet" method="get" class="search-box">
            <input type="hidden" name="action" value="view">
            <input type="text" name="search" placeholder="Search drivers..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <input type="submit" value="Search">
        </form>
        <a href="add_driver.jsp" class="add-btn">+ Add Driver</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Contact</th>
            <th>Email</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Driver d : drivers) { %>
        <tr>
            <td><%= d.getName() %></td>
            <td><%= d.getContact() %></td>
            <td><%= d.getEmail() %></td>
            <td>
                <span class="status <%= d.getStatus().toLowerCase() %>"><%= d.getStatus() %></span>
            </td>
            <td class="actions">
                <a href="DriverCRUDServlet?action=edit&username=<%= d.getUsername() %>"><button>Edit</button></a>
                <a href="DriverCRUDServlet?action=delete&username=<%= d.getUsername() %>" onclick="return confirm('Are you sure you want to delete this driver?');"><button>Delete</button></a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
