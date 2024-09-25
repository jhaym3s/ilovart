// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class XFileAdapterAdapter extends TypeAdapter<XFileAdapter> {
  @override
  final int typeId = 5;

  @override
  XFileAdapter read(BinaryReader reader) {
    return XFileAdapter();
  }

  @override
  void write(BinaryWriter writer, XFileAdapter obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is XFileAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
