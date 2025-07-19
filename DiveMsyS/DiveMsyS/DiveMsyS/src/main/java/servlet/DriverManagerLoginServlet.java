package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DriverManagerLoginServlet")
public class DriverManagerLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("manager".equals(username) && "manager123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("manager", true);
            response.sendRedirect("DriverCRUDServlet?action=view");
        } else {
            response.getWriter().println("<h3 style='color:red;'>Invalid credentials!</h3><a href='driver_manager_login.jsp'>Try again</a>");
        }
    }
}
