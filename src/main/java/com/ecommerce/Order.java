package com.ecommerce;

import java.sql.Timestamp;

public class Order {

    private int id;
    private double totalAmount;
    private String status;
    private Timestamp orderDate;


    public Order() {
    }


    public int getId() {
        return id;
    }


    public void setId(int id) {
        this.id = id;
    }


    public double getTotalAmount() {
        return totalAmount;
    }


    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }


    public String getStatus() {
        return status;
    }


    public void setStatus(String status) {
        this.status = status;
    }


    public Timestamp getOrderDate() {
        return orderDate;
    }


    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
}