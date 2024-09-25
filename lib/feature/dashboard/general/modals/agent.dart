// To parse this JSON data, do
//
//     final agent = agentFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'agent.g.dart';


Agent agentFromJson(String str) => Agent.fromJson(json.decode(str));

String agentToJson(Agent data) => json.encode(data.toJson());

@HiveType(typeId: 6)
class Agent {
  @HiveField(0)
    String email;
    @HiveField(1)
    bool isAgent;
    @HiveField(2)
    String firstName;
    @HiveField(3)
    String lastName;
    @HiveField(4)
    String phoneNumber;
    @HiveField(5)
    String countryCode;
    @HiveField(6)
    String countryIsoCode2;
    @HiveField(7)
    bool emailVerified;
    @HiveField(8)
    String id;

    Agent({
        required this.email,
        required this.isAgent,
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.countryCode,
        required this.countryIsoCode2,
        required this.emailVerified,
        required this.id,
    });

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        email: json["email"],
        isAgent: json["is_agent"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        countryIsoCode2: json["country_iso_code_2"],
        emailVerified: json["email_verified"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "is_agent": isAgent,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "country_iso_code_2": countryIsoCode2,
        "email_verified": emailVerified,
        "_id": id,
    };
}

