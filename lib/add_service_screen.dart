import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/service_model.dart';
import '../firebase/firestore_service.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  double _price = 0.0;
  String _imageUrl = '';
  final _firestoreService = FirestoreService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Service newService = Service(
        id: Uuid().v4(),
        title: _title,
        description: _description,
        imageUrl: _imageUrl,
        price: _price,
        rating: 0.0,
      );

      await _firestoreService.addService(newService);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service'),
        backgroundColor: Colors.orange[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a price' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                onSaved: (value) => _imageUrl = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an image URL' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Service'),
                style: ElevatedButton.styleFrom(primary: Colors.orange[300]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
