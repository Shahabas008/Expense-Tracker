// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addbudgetmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddBudgetModelAdapter extends TypeAdapter<AddBudgetModel> {
  @override
  final int typeId = 1;

  @override
  AddBudgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddBudgetModel(
      fields[4] as bool,
      fields[3] as int,
      fields[1] as String,
      fields[2] as Color,
      fields[0] as IconData,
    );
  }

  @override
  void write(BinaryWriter writer, AddBudgetModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.icon)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.bgcolor)
      ..writeByte(3)
      ..write(obj.containerIndex)
      ..writeByte(4)
      ..write(obj.boolean);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddBudgetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
