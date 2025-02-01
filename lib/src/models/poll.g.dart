// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PollAdapter extends TypeAdapter<Poll> {
  @override
  final int typeId = 0;

  @override
  Poll read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Poll(
      id: fields[0] as int,
      question: fields[1] as String,
      options: (fields[2] as List).cast<PollOption>(),
      totalVotes: fields[3] as int,
      createdBy: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Poll obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.options)
      ..writeByte(3)
      ..write(obj.totalVotes)
      ..writeByte(4)
      ..write(obj.createdBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
