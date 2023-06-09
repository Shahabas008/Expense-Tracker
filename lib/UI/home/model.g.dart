// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ValueOfTextFormAdapter extends TypeAdapter<ValueOfTextForm> {
  @override
  final int typeId = 3;

  @override
  ValueOfTextForm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ValueOfTextForm(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[4] as String,
      fields[3] as String,
      fields[5] as int,
      fields[6] as IconData,
      fields[7] as Color,
      fields[8] as String,
      fields[9] as String,
    )..id = fields[10] as int?;
  }

  @override
  void write(BinaryWriter writer, ValueOfTextForm obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.incomeAmount)
      ..writeByte(2)
      ..write(obj.expenseAmount)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.selectedIndexHome)
      ..writeByte(6)
      ..write(obj.categoryIcon)
      ..writeByte(7)
      ..write(obj.bgColorOfContainer)
      ..writeByte(8)
      ..write(obj.currentDate)
      ..writeByte(9)
      ..write(obj.currentTime)
      ..writeByte(10)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueOfTextFormAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
