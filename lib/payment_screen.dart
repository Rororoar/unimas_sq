import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String serviceTitle;
  final double price;

  PaymentScreen({required this.serviceTitle, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.orange[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Service: $serviceTitle',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Price: \$${price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Handle cash payment
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cash payment selected')),
              );
            },
            child: Text('Pay with Cash'),
            style: ElevatedButton.styleFrom(primary: Colors.orange[300]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to QR payment
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('QR transfer payment selected')),
              );
            },
            child: Text('Pay with QR Transfer'),
            style: ElevatedButton.styleFrom(primary: Colors.orange[300]),
          ),
        ],
      ),
    );
  }
}
