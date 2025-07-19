<!DOCTYPE html>
<html>
<head>
  <title>Driver Manager Login</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #f9f9f9, #f2f2f2);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .box-container {
      width: 900px;
      height: 500px;
      display: flex;
      border-radius: 20px;
      overflow: hidden;
      box-shadow: 0 20px 50px rgba(0,0,0,0.1);
      background-color: #fff;
    }
    .left {
      width: 50%;
      background-image: url('images/taxi-7298142_1280.jpg'); /* Use your image path */
      background-size: cover;
      background-position: center;
    }
    .right {
      width: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #fff;
    }
    .login-box {
      width: 400px;
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 8px 30px rgba(0,0,0,0.05);
      background-color: #ffffff;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #000;
      font-weight: 700;
      letter-spacing: 0.5px;
    }
    form {
      width: 100%;
    }
    input, button {
      width: 100%;
      padding: 14px;
      margin-bottom: 20px;
      border-radius: 8px;
      border: 1px solid #d1d5db;
      font-size: 15px;
      box-sizing: border-box;
    }
    input:focus {
      outline: none;
      border-color: #FF8A00;
    }
    button {
      background-color: #FF8A00;
      color: white;
      border: none;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #e27a00;
    }
  </style>
</head>
<body>

<div class="box-container">
  <div class="left"></div>

  <div class="right">
    <div class="login-box">
      <h2>Login</h2>
      <form action="DriverManagerLoginServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
      </form>
    </div>
  </div>
</div>

</body>
</html>
