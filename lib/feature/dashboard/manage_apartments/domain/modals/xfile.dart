import 'package:hive/hive.dart';
import 'package:cross_file/cross_file.dart';

part 'xfile.g.dart';

@HiveType(typeId: 5)
class XFileAdapter extends TypeAdapter<XFile> {
  @override
  final int typeId = 5;

  @override
  XFile read(BinaryReader reader) {
    final String path = reader.readString();
    return XFile(path);
  }

  @override
  void write(BinaryWriter writer, XFile obj) {
    writer.writeString(obj.path);
  }
}