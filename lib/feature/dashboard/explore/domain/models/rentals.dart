// To parse this JSON data, do
//
//     final rentals = rentalsFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'rentals.g.dart';

List<Rentals> rentalsFromJson(String str) => List<Rentals>.from(json.decode(str).map((x) => Rentals.fromJson(x)));

String rentalsToJson(List<Rentals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 2)
class Rentals {
  @HiveField(0)
    String agentId;
    @HiveField(1)
    String agentEmail;
    @HiveField(2)
    String agentNumber;
    @HiveField(3)
    String lga;
    @HiveField(4)
    String listingType;
    @HiveField(5)
    List<Photo> videos;
    @HiveField(6)
    List<Photo> photos;
    @HiveField(7)
    String houseDirection;
    @HiveField(8)
    String propertyType;
    @HiveField(9)
    List<Bill> bills;
    @HiveField(10)
    String state;
    @HiveField(11)
    String houseAddress;
    @HiveField(12)
    List<String> houseFeatures;
    @HiveField(13)
    String id;
    @HiveField(14)
    int timeInMillis;

    Rentals({
        required this.agentId,
        required this.agentEmail,
        required this.agentNumber,
        required this.lga,
        required this.listingType,
        required this.videos,
        required this.photos,
        required this.houseDirection,
        required this.propertyType,
        required this.bills,
        required this.state,
        required this.houseAddress,
        required this.houseFeatures,
        required this.id,
        required this.timeInMillis,
    });

    factory Rentals.fromJson(Map<String, dynamic> json) => Rentals(
        agentId: json["agent_id"],
        agentEmail: json["agent_email"],
        agentNumber: json["agent_number"],
        lga: json["lga"],
        listingType: json["listing_type"],
        videos: List<Photo>.from(json["videos"].map((x) => Photo.fromJson(x))),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        houseDirection: json["house_direction"],
        propertyType: json["property_type"],
        bills: List<Bill>.from(json["bills"].map((x) => Bill.fromJson(x))),
        state: json["state"],
        houseAddress: json["house_address"],
        houseFeatures: List<String>.from(json["house_features"].map((x) => x)),
        id: json["_id"],
        timeInMillis: json["time_in_millis"],
    );

    Map<String, dynamic> toJson() => {
        "agent_id": agentId,
        "agent_email": agentEmail,
        "agent_number": agentNumber,
        "lga": lga,
        "listing_type": listingType,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "house_direction": houseDirection,
        "property_type": propertyType,
        "bills": List<dynamic>.from(bills.map((x) => x.toJson())),
        "state": state,
        "house_address": houseAddress,
        "house_features": List<dynamic>.from(houseFeatures.map((x) => x)),
        "_id": id,
        "time_in_millis": timeInMillis,
    };
}

@HiveType(typeId: 3)
class Bill {
    @HiveField(0)
    int price;
    @HiveField(1)
    String name;

    Bill({
        required this.price,
        required this.name,
    });

    factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        price: json["price"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "name": name,
    };
}


@HiveType(typeId: 4)
class Photo {
  @HiveField(0)
    String ref;
    @HiveField(1)
    String url;

    Photo({
        required this.ref,
        required this.url,
    });

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        ref: json["ref"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "ref": ref,
        "url": url,
    };
}
