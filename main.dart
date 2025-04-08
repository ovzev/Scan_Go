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

// User Class
class User {
  String id;
  String name;
  String email;

  User(this.id, this.name, this.email);
}

// Transaction Class
class Transaction {
  String id;
  String productId;
  String userId;
  double totalAmount;

  Transaction(this.id, this.productId, this.userId, this.totalAmount);
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
void addNewProduct({
  String? name,
  ProductCategory? category,
  double? price,
  int? quantity,
}) {
  String id = generateUniqueId();
  Product newProduct = Product(id, name ?? "Unknown",
      category ?? ProductCategory.Groceries, price ?? 0.0, quantity ?? 0);
  products.add(newProduct);
  productMap[id] = newProduct;
}

// Main Widget for the Application
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      home: ProductManagementPage(),
    );
  }
}

class ProductManagementPage extends StatefulWidget {
  @override
  _ProductManagementPageState createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  ProductCategory _selectedCategory = ProductCategory.Groceries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add New Product',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<ProductCategory>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (ProductCategory? newCategory) {
                setState(() {
                  _selectedCategory = newCategory!;
                });
              },
              items: ProductCategory.values.map((ProductCategory category) {
                return DropdownMenuItem<ProductCategory>(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Product Price',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Product Quantity',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  String name = _nameController.text;
                  double price = double.tryParse(_priceController.text) ?? 0.0;
                  int quantity = int.tryParse(_quantityController.text) ?? 0;

                  addNewProduct(
                    name: name,
                    category: _selectedCategory,
                    price: price,
                    quantity: quantity,
                  );

                  setState(() {});
                  _nameController.clear();
                  _priceController.clear();
                  _quantityController.clear();
                },
                icon: Icon(Icons.add),
                label: Text('Add Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text('Products List',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading:
                          Icon(Icons.inventory_2, color: Colors.deepPurple),
                      title: Text(product.name,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                        'Category: ${product.category.name}\nPrice: \$${product.price} | Quantity: ${product.quantity}',
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
