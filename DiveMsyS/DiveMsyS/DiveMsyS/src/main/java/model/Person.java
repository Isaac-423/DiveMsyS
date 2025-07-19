package model;

public class Person {
    private String name;
    private String contact;
    private String email;
    private String username;

    public Person(String name, String contact, String email, String username) {
        this.name = name;
        this.contact = contact;
        this.email = email;
        this.username = username;
    }

    public String getName() { return name; }
    public String getContact() { return contact; }
    public String getEmail() { return email; }
    public String getUsername() { return username; }

    public void setName(String name) { this.name = name; }
    public void setContact(String contact) { this.contact = contact; }
    public void setEmail(String email) { this.email = email; }
    public void setUsername(String username) { this.username = username; }
}
