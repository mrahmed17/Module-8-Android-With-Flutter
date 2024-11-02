import 'package:test_projects/models/location.dart';

class Hotel {
  int? id;
  String? name;
  String? address;
  String? rating;
  int? minPrice;
  int? maxPrice;
  String? image;
  Location? location;

  Hotel(
      {this.id,
      this.name,
      this.address,
      this.rating,
      this.minPrice,
      this.maxPrice,
      this.image,
      this.location});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    rating = json['rating'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    image = json['image'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['rating'] = rating;
    data['minPrice'] = minPrice;
    data['maxPrice'] = maxPrice;
    data['image'] = image;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}
