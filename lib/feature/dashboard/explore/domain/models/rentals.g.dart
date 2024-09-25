// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rentals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RentalsAdapter extends TypeAdapter<Rentals> {
  @override
  final int typeId = 2;

  @override
  Rentals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rentals(
      agentId: fields[0] as String,
      agentEmail: fields[1] as String,
      agentNumber: fields[2] as String,
      lga: fields[3] as String,
      listingType: fields[4] as String,
      videos: (fields[5] as List).cast<Photo>(),
      photos: (fields[6] as List).cast<Photo>(),
      houseDirection: fields[7] as String,
      propertyType: fields[8] as String,
      bills: (fields[9] as List).cast<Bill>(),
      state: fields[10] as String,
      houseAddress: fields[11] as String,
      houseFeatures: (fields[12] as List).cast<String>(),
      id: fields[13] as String,
      timeInMillis: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Rentals obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.agentId)
      ..writeByte(1)
      ..write(obj.agentEmail)
      ..writeByte(2)
      ..write(obj.agentNumber)
      ..writeByte(3)
      ..write(obj.lga)
      ..writeByte(4)
      ..write(obj.listingType)
      ..writeByte(5)
      ..write(obj.videos)
      ..writeByte(6)
      ..write(obj.photos)
      ..writeByte(7)
      ..write(obj.houseDirection)
      ..writeByte(8)
      ..write(obj.propertyType)
      ..writeByte(9)
      ..write(obj.bills)
      ..writeByte(10)
      ..write(obj.state)
      ..writeByte(11)
      ..write(obj.houseAddress)
      ..writeByte(12)
      ..write(obj.houseFeatures)
      ..writeByte(13)
      ..write(obj.id)
      ..writeByte(14)
      ..write(obj.timeInMillis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RentalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 3;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill(
      price: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhotoAdapter extends TypeAdapter<Photo> {
  @override
  final int typeId = 4;

  @override
  Photo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Photo(
      ref: fields[0] as String,
      url: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Photo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ref)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
