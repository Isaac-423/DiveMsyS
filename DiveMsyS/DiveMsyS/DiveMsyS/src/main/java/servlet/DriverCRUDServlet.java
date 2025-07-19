package servlet;

import model.Driver;
import model.DriverDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DriverCRUDServlet")
public class DriverCRUDServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("manager") == null) {
            response.sendRedirect("driver_manager_login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "view":
                String search = request.getParameter("search");
                List<Driver> drivers;
                if (search != null && !search.trim().isEmpty()) {
                    drivers = DriverDAO.searchDrivers(search.trim());
                } else {
                    drivers = DriverDAO.getAllDrivers();
                }
                request.setAttribute("drivers", drivers);
                request.getRequestDispatcher("driver_management_dashboard.jsp").forward(request, response);
                break;

            case "delete":
                String usernameToDelete = request.getParameter("username");
                DriverDAO.deleteDriver(usernameToDelete);
                response.sendRedirect("DriverCRUDServlet?action=view");
                break;

            case "edit":
                String usernameToEdit = request.getParameter("username");
                Driver driver = DriverDAO.findDriver(usernameToEdit);
                if (driver != null) {
                    request.setAttribute("driver", driver);
                    request.getRequestDispatcher("edit_driver.jsp").forward(request, response);
                } else {
                    response.sendRedirect("DriverCRUDServlet?action=view");
                }
                break;

            default:
                response.sendRedirect("DriverCRUDServlet?action=view");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String vehicleNumber = request.getParameter("vehicleNumber");
        String vehicleModel = request.getParameter("vehicleModel");
        String vehicleType = request.getParameter("vehicleType");
        String status = request.getParameter("status");

        String taxiID;
        if ("add".equals(action)) {
            // Auto-generate taxi ID as TX-XXX
            int nextId = DriverDAO.getAllDrivers().size() + 1;
            taxiID = String.format("TX-%03d", nextId);

            Driver driver = new Driver(name, contact, email, username, vehicleNumber, vehicleModel, vehicleType, taxiID, status);
            DriverDAO.addDriver(driver);

        } else if ("edit".equals(action)) {
            taxiID = request.getParameter("taxiID"); // read existing (readonly in form)
            Driver driver = new Driver(name, contact, email, username, vehicleNumber, vehicleModel, vehicleType, taxiID, status);
            DriverDAO.updateDriver(driver);
        }

        response.sendRedirect("DriverCRUDServlet?action=view");
    }
}
