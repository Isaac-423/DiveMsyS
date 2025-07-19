package model;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {
    private static final String DRIVER_FILE_PATH = "F:\\sliit\\1st year\\2 sem\\Object Oriented Programming - SE1020\\project\\Driver Management\\Driver Management\\DriverManagement\\src\\main\\resources\\Driver.txt";

    public static List<Driver> getAllDrivers() throws IOException {
        List<Driver> drivers = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(DRIVER_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 9) {  // Expecting 9 fields
                    Driver driver = new Driver(
                            data[0], data[1], data[2], data[3], // Person fields
                            data[4], data[5], data[6], data[7], data[8] // Driver-specific fields
                    );
                    drivers.add(driver);
                }
            }
        }
        return drivers;
    }

    public static void addDriver(Driver driver) throws IOException {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DRIVER_FILE_PATH, true))) {
            bw.write(driver.toString());
            bw.newLine();
        }
    }

    public static Driver findDriver(String username) throws IOException {
        for (Driver d : getAllDrivers()) {
            if (d.getUsername().equalsIgnoreCase(username)) {
                return d;
            }
        }
        return null;
    }

    public static void updateDriver(Driver updatedDriver) throws IOException {
        List<Driver> drivers = getAllDrivers();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DRIVER_FILE_PATH))) {
            for (Driver d : drivers) {
                if (d.getUsername().equalsIgnoreCase(updatedDriver.getUsername())) {
                    bw.write(updatedDriver.toString());
                } else {
                    bw.write(d.toString());
                }
                bw.newLine();
            }
        }
    }

    public static void deleteDriver(String username) throws IOException {
        List<Driver> drivers = getAllDrivers();
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DRIVER_FILE_PATH))) {
            for (Driver d : drivers) {
                if (!d.getUsername().equalsIgnoreCase(username)) {
                    bw.write(d.toString());
                    bw.newLine();
                }
            }
        }
    }

    public static List<Driver> searchDrivers(String keyword) throws IOException {
        List<Driver> filtered = new ArrayList<>();
        for (Driver d : getAllDrivers()) {
            if (d.getName().toLowerCase().contains(keyword.toLowerCase()) ||
                    d.getContact().toLowerCase().contains(keyword.toLowerCase()) ||
                    d.getEmail().toLowerCase().contains(keyword.toLowerCase()) ||
                    d.getUsername().toLowerCase().contains(keyword.toLowerCase())) {
                filtered.add(d);
            }
        }
        return filtered;
    }
}
