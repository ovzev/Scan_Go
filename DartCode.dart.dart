import 'dart:io';

// Enum for Product Categories
enum ProductCategory {
  Electronics,
  Groceries,
  Clothing,
}

// Product Class
class Product {
  String id;
  String name;
  ProductCategory category;
  double price;
  int quantity;

  Product(this.id, this.name, this.category, this.price, this.quantity);

  void displayProduct() {
    print(
        "ID: $id, Name: $name, Category: $category, Price: \$${price}, Quantity: $quantity");
  }
}

// User Class
class User {
  String id;
  String name;
  String email;

  User(this.id, this.name, this.email);

  void displayUser() {
    print("ID: $id, Name: $name, Email: $email");
  }
}

// Transaction Class
class Transaction {
  String id;
  String productId;
  String userId;
  double totalAmount;

  Transaction(this.id, this.productId, this.userId, this.totalAmount);

  void displayTransaction() {
    print(
        "ID: $id, Product ID: $productId, User ID: $userId, Total Amount: \$${totalAmount}");
  }
}

// Lists for Data Storage
List<Product> products = [];
List<User> users = [];
List<Transaction> transactions = [];

// Maps for Quick Lookup
Map<String, Product> productMap = {};
Map<String, User> userMap = {};
Map<String, Transaction> transactionMap = {};

// Function to Generate Unique ID
String generateUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}

// Function to Add New Product
void addNewProduct(
    {String? name, ProductCategory? category, double? price, int? quantity}) {
  String id = generateUniqueId();
  Product newProduct = Product(id, name ?? "Unknown",
      category ?? ProductCategory.Groceries, price ?? 0.0, quantity ?? 0);
  products.add(newProduct);
  productMap[id] = newProduct;
  print("Product added successfully.");
}

// Function to Display Products
void displayProducts() {
  if (products.isEmpty) {
    print("No products available.");
  } else {
    print("Displaying Products:");
    for (var product in products) {
      product.displayProduct();
    }
  }
}

// Menu Function
void displayMenu() {
  print('''\nMenu:
  1) Display products
  2) Add new product
  3) Exit
''');
}

// Function to Handle User Input
void handleUserInput() {
  while (true) {
    displayMenu();
    stdout.write("Enter your choice: ");
    try {
      int choice = int.parse(stdin.readLineSync()!);
      switch (choice) {
        case 1:
          displayProducts();
          break;
        case 2:
          addNewProduct(
              name: "Smartphone",
              category: ProductCategory.Electronics,
              price: 499.99,
              quantity: 50);
          break;
        case 3:
          print("Exiting program...");
          return;
        default:
          print("Invalid choice. Please enter a valid option.");
      }
    } catch (e) {
      print("Invalid input. Please enter a number.");
    }
  }
}

// Main Function
void main() {
  handleUserInput();
}
