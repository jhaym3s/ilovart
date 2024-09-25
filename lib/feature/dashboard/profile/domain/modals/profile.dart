// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'profile.g.dart';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

@HiveType(typeId: 1)

class Profile {
  @HiveField(0)
    String id;
    @HiveField(1)
    List<String> favorites;
    @HiveField(2)
    String? tokenVersion;
    @HiveField(3)
    String countryCode;
    @HiveField(4)
    String lastName;
    @HiveField(5)
    Photo photo;
    @HiveField(6)
    String phoneNumber;
    @HiveField(7)
    bool isAgent;
    @HiveField(8)
    String firstName;
    @HiveField(9)
    String email;
    @HiveField(10)
    String countryIsoCode2;
    @HiveField(11)
    String? accessToken;
    @HiveField(12)
    String? refreshToken;

    Profile({
        required this.id,
        required this.favorites,
        required this.tokenVersion,
        required this.countryCode,
        required this.lastName,
        required this.photo,
        required this.phoneNumber,
        required this.isAgent,
        required this.firstName,
        required this.email,
        required this.countryIsoCode2,
        required this.accessToken,
        required this.refreshToken,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        favorites: List<String>.from(json["favorites"].map((x) => x)),
        tokenVersion: json["token_version"],
        countryCode: json["country_code"],
        lastName: json["last_name"],
        photo: Photo.fromJson(json["photo"]),
        phoneNumber: json["phone_number"],
        isAgent: json["is_agent"],
        firstName: json["first_name"],
        email: json["email"],
        countryIsoCode2: json["country_iso_code_2"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "favorites": List<dynamic>.from(favorites.map((x) => x)),
        "token_version": tokenVersion,
        "country_code": countryCode,
        "last_name": lastName,
        "photo": photo.toJson(),
        "phone_number": phoneNumber,
        "is_agent": isAgent,
        "first_name": firstName,
        "email": email,
        "country_iso_code_2": countryIsoCode2,
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };
}

class Photo {
    Photo();

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    );

    Map<String, dynamic> toJson() => {
    };
}
