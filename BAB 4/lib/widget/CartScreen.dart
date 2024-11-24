import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      "name": "Hoodie",
      "brand": "Essentials",
      "price": 20,
      "quantity": 0,
      "image": 'assets/images/hoodie.jpeg'
    },
    {
      "name": "Watch",
      "brand": "Apple Watch SE",
      "price": 20,
      "quantity": 0,
      "image": 'assets/images/watch.jpeg'
    },
    {
      "name": "Shoes",
      "brand": "Sweet Heart",
      "price": 30,
      "quantity": 0,
      "image": 'assets/images/shoes.jpeg'
    },
    {
      "name": "Jeans",
      "brand": "Y2K",
      "price": 15,
      "quantity": 0,
      "image": 'assets/images/jeans.jpeg'
    },
  ];

  double get subtotal {
    return _cartItems.fold(
        0, (total, item) => total + (item["price"] * item["quantity"]));
  }

  double discount = 4.0;
  double deliveryCharges = 2.0;

  @override
  Widget build(BuildContext context) {
    double total = subtotal - discount + deliveryCharges;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Tambahkan menu tambahan di sini jika diperlukan
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // List Item di Keranjang
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(item["image"],
                            width: 80, height: 80, fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item["name"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(item["brand"],
                                  style: const TextStyle(color: Colors.grey)),
                              Text("\$${item["price"]}",
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 111, 106, 244))),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            // Tombol Tambah dan Kurang dengan Background
                            Row(
                              children: [
                                // Tombol Kurang
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (item["quantity"] > 0) {
                                        item["quantity"]--;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 111, 106, 244),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(Icons.remove, size: 16),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "${item["quantity"]}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 8),
                                // Tombol Tambah
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      item["quantity"]++;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 111, 106, 244),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(Icons.add, size: 16),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Color.fromARGB(255, 255, 17, 0)),
                              onPressed: () {
                                setState(() {
                                  _cartItems.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Ringkasan Pesanan
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    blurRadius: 10,
                    offset: Offset(0, -2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Order Summary",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Items"),
                    Text("${_cartItems.length}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal"),
                    Text("\$${subtotal.toStringAsFixed(2)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Discount"),
                    Text("-\$${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Delivery Charges"),
                    Text("\$${deliveryCharges.toStringAsFixed(2)}"),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika checkout di sini
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color.fromARGB(255, 111, 106, 244),
                  ),
                  child: const Center(
                    child: Text("Check Out", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
