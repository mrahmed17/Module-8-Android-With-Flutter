import 'package:flutter/material.dart';
import 'package:test_projects/models/hotel.dart';
import 'package:test_projects/page/RoomDetailsPage.dart';
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
              return Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasData) {
              return Center(child: Text('Error: ${snapshot.error}'),);
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hotels are available'),);
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
                            leading: hotel.image != null ? Image.network(
                                'http://localhost:8080/images/hotel/${hotel
                                    .image}') : Icon(Icons.hotel),
                            title: Text(hotel.name ?? 'Unnamed Hotel'),
                            subtitle: Text(
                                hotel.address ?? 'No address is available'),
                            trailing: Text(
                                '${hotel.minPrice} - ${hotel.maxPrice}'),
                          ),
                          Padding(padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: () {
                              if (hotel.id != null) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      RoomDetailsPage(hotel: hotel),),);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hotel ID is missing. Cannot load rooms.')),);
                              }
                            }, child: Text('View Room'),
                            style: ElevatedButton.styleFrom(),),),
                        ],
                      ),
                    );
                  });
            }
          },
      ),
    );
  }
}
