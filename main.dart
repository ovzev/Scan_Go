import 'package:flutter/material.dart';

// Enum for Product Categories
enum ProductCategory { Electronics, Groceries, Clothing }

// Product Class
class Product {
  String id;
  String name;
  ProductCategory category;
  double price;
  int quantity;

  Product(this.id, this.name, this.category, this.price, this.quantity);
}

