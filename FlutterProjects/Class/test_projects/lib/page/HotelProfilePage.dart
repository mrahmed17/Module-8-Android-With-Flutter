
import 'package:flutter/material.dart';

class HotelProfilePage extends StatelessWidget {
  final String hotelName;
  final String hotelImageUrl;
  final String address;
  final String rating;
  final int minPrice;
  final int maxPrice;

  const HotelProfilePage(
      {super.key, required this.hotelName,
      required this.hotelImageUrl,
      required this.address,
      required this.rating,
      required this.minPrice,
      required this.maxPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$hotelName Profile'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //hotel image
            Image.network(
              hotelImageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),

            //hotel details
            Text(
              hotelName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Rating: $rating ⭐',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Price Range: \$${minPrice.toString()} - \$${maxPrice.toString()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),

            //View rooms button
            ElevatedButton.icon(
              onPressed: () {
                //Navigate to rooms list or call an api to fetch room for this hotel
                print("View Rooms Clicked");
              },
              icon: Icon(Icons.room_service),
              label: Text('View Rooms'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //Manage bookings button
            ElevatedButton.icon(
              onPressed: () {
                // navigate to bookings management page
                print('Manage Bookings Clicked');
              },
              icon: Icon(Icons.book_online),
              label: Text("Manage Bookings"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(
              height: 10,
            ),

            //Edit hotel profile Button
            ElevatedButton.icon(
              onPressed: () {
                // navigate to edit hotel profile page
                print('Edit Profile clicked');
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
