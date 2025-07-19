<%@ page import="model.Driver" %>
<%
  Driver d = (Driver) request.getAttribute("driver");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Driver</title>
  <style>
    :root {
      --primary: #ff6b00;
      --primary-dark: #e05d00;
      --secondary: #2c3e50;
      --background: #f8f9fa;
      --card-bg: #ffffff;
      --field-bg: #f8f9fa;
      --field-border: #dee2e6;
      --field-focus: #ff6b00;
      --btn-dark: #343a40;
    }

    * { box-sizing: border-box; }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: var(--background);
      margin: 0;
      padding: 0;
      color: var(--secondary);
    }

    .container {
      max-width: 960px;
      margin: 3rem auto;
      background: var(--card-bg);
      border-radius: 12px;
      box-shadow: 0 4px 24px rgba(0, 0, 0, 0.05);
      overflow: hidden;
    }

    .header {
      background: linear-gradient(135deg, var(--primary), #ff8c00);
      color: white;
      padding: 2rem;
      text-align: center;
    }

    .header h2 { margin: 0; font-size: 2rem; font-weight: 600; }

    .form-content { padding: 2rem 3rem; }

    form {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 1.5rem;
    }

    .field { display: flex; flex-direction: column; }

    label {
      margin-bottom: 0.5rem;
      font-weight: 600;
      font-size: 0.95rem;
    }

    input, select {
      padding: 0.9rem 1rem;
      border: 1px solid var(--field-border);
      border-radius: 8px;
      font-size: 1rem;
      background-color: var(--field-bg);
      transition: border-color 0.3s, box-shadow 0.3s;
    }

    input:focus, select:focus {
      border-color: var(--field-focus);
      box-shadow: 0 0 0 3px rgba(255, 107, 0, 0.15);
      background-color: #fff;
      outline: none;
    }

    .button-group {
      display: flex;
      gap: 1rem;
      margin-top: 1rem;
      grid-column: 1 / -1;
    }

    button {
      flex: 1;
      padding: 1rem;
      border: none;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.3s, transform 0.2s;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    button[type="submit"] {
      background-color: var(--primary);
      color: white;
    }

    button[type="submit"]:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
    }

    .back-btn {
      background-color: var(--btn-dark);
      color: white;
    }

    .back-btn:hover {
      background-color: #23272b;
      transform: translateY(-2px);
    }

    @media (max-width: 600px) {
      .form-content { padding: 2rem 1.5rem; }
      .button-group { flex-direction: column; }
      button { width: 100%; }
    }
  </style>

  <script>
    function filterInput(selector, regex) {
      document.querySelectorAll(selector).forEach(input => {
        input.addEventListener('input', function () {
          let start = this.selectionStart;
          let end = this.selectionEnd;
          this.value = this.value.replace(regex, '');
          this.setSelectionRange(start, end);
        });
      });
    }

    window.onload = function () {
      filterInput('input[name="name"]', /[^A-Za-z ]/g);
      filterInput('input[name="contact"]', /[^0-9]/g);
      let vehicleNumberInput = document.querySelector('input[name="vehicleNumber"]');
      vehicleNumberInput.addEventListener('input', function() {
        this.value = this.value.toUpperCase().replace(/[^A-Z0-9-]/g, '');
        if (this.value.length === 2 && !this.value.includes('-')) {
          this.value = this.value + '-';
        }
        this.value = this.value.replace(/^([A-Z]{2})(-?)([0-9]*)$/, (_, letters, dash, digits) => {
          return letters + '-' + digits;
        });
        if (this.value.length > 7) {
          this.value = this.value.slice(0, 7);
        }
      });
    }
  </script>

</head>
<body>

<div class="container">
  <div class="header">
    <h2>Edit Driver: <%= d.getUsername() %></h2>
  </div>

  <div class="form-content">
    <form action="DriverCRUDServlet" method="post">
      <input type="hidden" name="action" value="edit">

      <div class="field">
        <label>Driver Name</label>
        <input type="text" name="name" value="<%= d.getName() %>" pattern="[A-Za-z ]+" title="Only alphabets and spaces" required>
      </div>

      <div class="field">
        <label>Contact Number</label>
        <input type="text" name="contact" value="<%= d.getContact() %>" pattern="0[0-9]{9}" title="Must start with 0 and be 10 digits" maxlength="10" required>
      </div>

      <div class="field">
        <label>Email Address</label>
        <input type="email" name="email" value="<%= d.getEmail() %>" required>
      </div>

      <div class="field">
        <label>Username</label>
        <input type="text" name="username" value="<%= d.getUsername() %>" readonly>
      </div>

      <div class="field">
        <label>Vehicle Number</label>
        <input type="text" name="vehicleNumber" value="<%= d.getVehicleNumber() %>" pattern="[A-Z]{2}-[0-9]{4}" title="Format must be AB-1234" maxlength="7" required>
      </div>

      <div class="field">
        <label>Vehicle Model</label>
        <input type="text" name="vehicleModel" value="<%= d.getVehicleModel() %>" required>
      </div>

      <div class="field">
        <label>Vehicle Type</label>
        <input type="text" name="vehicleType" value="<%= d.getVehicleType() %>" required>
      </div>

      <div class="field">
        <label>Taxi ID</label>
        <input type="text" name="taxiID" value="<%= d.getTaxiID() %>" readonly>
      </div>

      <div class="field">
        <label>Status</label>
        <select name="status" required>
          <option value="Active" <%= "Active".equals(d.getStatus()) ? "selected" : "" %>>Active</option>
          <option value="Inactive" <%= "Inactive".equals(d.getStatus()) ? "selected" : "" %>>Inactive</option>
          <option value="Suspended" <%= "Suspended".equals(d.getStatus()) ? "selected" : "" %>>Suspended</option>
        </select>
      </div>

      <div class="button-group">
        <button type="submit">Update Driver</button>
        <button type="button" class="back-btn" onclick="history.back()">Back</button>
      </div>
    </form>
  </div>
</div>

</body>
</html>
