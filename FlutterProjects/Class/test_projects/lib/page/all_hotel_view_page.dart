import 'package:flutter/material.dart';
import 'package:test_projects/models/hotel.dart';
import 'package:test_projects/services/hotel_service.dart';

class AllHotelViewPage extends StatefulWidget {
  const AllHotelViewPage({super.key});

  @override
  State<AllHotelViewPage> createState() => _AllHotelViewPageState();
}

class _AllHotelViewPageState extends State<AllHotelViewPage> {
  late Future<List<Hotel>> futureHotels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureHotels = HotelService().fetchHotels();
    print(futureHotels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Hotel>>(
      future: futureHotels,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hotels available'));
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final hotel = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: hotel.image != null
                            ? Image.network(
                                "http://localhost:8080/images/hotel/${hotel.image}")
                            : Icon(Icons.hotel),
                        title: Text(hotel.name ?? 'Unnamed Hotel'),
                        subtitle: Text(hotel.address ?? 'No address available'),
                        trailing: Text('${hotel.minPrice} - ${hotel.maxPrice}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement booking functionality or navigate to a booking page
                            print('Book Now clicked for hotel: ${hotel.name}');
                          },
                          style: ElevatedButton.styleFrom(),
                          child: Text('View Room'),
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
      },
    ));
  }
}
