import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;

  ServiceCard({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(title),
        subtitle: Text(description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("\$${price.toString()}"),
            Text("⭐ $rating"),
          ],
        ),
        onTap: () {
          // Navigate to service details
        },
      ),
    );
  }
}
