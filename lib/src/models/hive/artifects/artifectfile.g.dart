part of 'artifectfile.dart';


class ArtifectFileAdapter extends TypeAdapter<ArtifectFile>
{
  @override
  ArtifectFile read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArtifectFile(
        artifectNumber:fields[0] as String,
        file: fields[1] as String,
        filePath: fields[2] as String,
        status: fields[3] as String,
      userId: fields[4] as String,



    );
  }

  @override
  void write(BinaryWriter writer, ArtifectFile obj)
  {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.artifectNumber)
      ..writeByte(1)
      ..write(obj.file)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.userId);

  }

  @override
  int get typeId => 2;


}