import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_projects/models/hotel.dart';
import 'package:test_projects/models/location.dart';
import 'package:test_projects/services/hotel_service.dart';
import 'dart:typed_data';

class AddHotelPage extends StatefulWidget {
  const AddHotelPage({super.key});

  @override
  State<AddHotelPage> createState() => _AddHotelPageState();
}

class _AddHotelPageState extends State<AddHotelPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile; //use XFile for Consistency with image picker
  Uint8List? _imageData; //To hold image data as Uint8List

  //Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  String _selectedRating = '3'; // default rating

  //pick an image from gallery
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        //read the image as bytes
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageFile = pickedFile; // assign the picked file
          _imageData = bytes; // store the image data
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: ${e.toString()}')),
      );
    }
  }

  // Save the hotel details
  Future<void> _saveHotel() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      if (double.parse(_minPriceController.text) >
          double.parse(_maxPriceController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Maximum price must be greater than minimum price')),
        );
        return;
      }
      final hotel = Hotel(
        id: 0,
        name: _nameController.text,
        address: _addressController.text,
        rating: _selectedRating,
        minPrice: double.parse(_minPriceController.text),
        maxPrice: double.parse(_maxPriceController.text),
        image: '',
        location: Location(id: 1, name: "Sample Location"),
      );

      try {
        //Assuming createHotel accepts an XFile; adjust as needed based on your service method

        await HotelService().createHotel(hotel, _imageFile!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hotel Added Successfully!')),
        );

        // Clear form fields and reset image
        _nameController.clear();
        _addressController.clear();
        _minPriceController.clear();
        _maxPriceController.clear();
        _imageFile = null;
        _imageData = null; //Reset image data
        setState(() {});
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding hotel: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please complete the form and upload an image.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Hotel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Hotel Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter hotel name" : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: "Address"),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter address' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedRating,
                items: ['1', '2', '3', '4', '5']
                    .map((rating) => DropdownMenuItem(
                          value: rating,
                          child: Text('Rating: $rating'),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedRating = value!),
                decoration: InputDecoration(labelText: 'Rating'),
              ),
              TextFormField(
                controller: _maxPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Minimum Price'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter minimum price'
                    : null,
              ),
              TextFormField(
                controller: _maxPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Maximum Price'),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter maximum price"
                    : null,
              ),
              SizedBox(
                height: 16,
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text("Upload Image"),
                onPressed: _pickImage,
              ),
              if (_imageData != null)
                Image.memory(
                  _imageData!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              //Display image
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _saveHotel,
                child: Text("Save Hotel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
