package com.example.thimodule3.model;

public class Product {
    private int id;
    private String name;
    private double price;
    private int quantity;
    private String color;
    private String description;
    private String category;

    // Constructor
    public Product(int id, String name, double price, int quantity, String color, String description, String category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.color = color;
        this.description = description;
        this.category = category;
    }
    public String getName(){
        return name;
    }
    public double getPrice(){
        return price;
    }
    public int getQuantity(){
        return quantity;
    }
    public String getColor(){
        return color;
    }
    public String getDescription(){
        return description;
    }
    public String getCategory(){
        return category;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setPrice(double price){
        this.price = price;
    }
    public void setQuantity(int quantity){
        this.quantity = quantity;
    }
    public void setColor(String color){
        this.color = color;
    }
    public void setDescription(String description){
        this.description = description;
    }
    public void setCategory(String category){
        this.category = category;
    }
    public int getId(){
        return id;
    }
    public void setId(int id){
        this.id = id;
    }

}
