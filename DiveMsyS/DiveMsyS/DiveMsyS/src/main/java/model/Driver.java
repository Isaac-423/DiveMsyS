package model;

public class Driver extends Person {
    private String vehicleNumber;
    private String vehicleModel;
    private String vehicleType;
    private String taxiID;
    private String status;  // ✅ NEW FIELD

    // Updated Constructor including status and using super()
    public Driver(String name, String contact, String email, String username, String vehicleNumber, String vehicleModel, String vehicleType, String taxiID, String status) {
        super(name, contact, email, username);
        this.vehicleNumber = vehicleNumber;
        this.vehicleModel = vehicleModel;
        this.vehicleType = vehicleType;
        this.taxiID = taxiID;
        this.status = status;
    }

    // Getters
    public String getVehicleNumber() { return vehicleNumber; }
    public String getVehicleModel() { return vehicleModel; }
    public String getVehicleType() { return vehicleType; }
    public String getTaxiID() { return taxiID; }
    public String getStatus() { return status; }  // ✅

    // Setters if needed
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return getName() + "," + getContact() + "," + getEmail() + "," + getUsername() + "," + vehicleNumber + "," + vehicleModel + "," + vehicleType + "," + taxiID + "," + status;
    }
}
