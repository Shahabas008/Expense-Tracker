// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetModelAdapter extends TypeAdapter<BudgetModel> {
  @override
  final int typeId = 2;

  @override
  BudgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BudgetModel(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
      fields[4] as bool,
      fields[5] as IconData,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.setLimitvalue)
      ..writeByte(1)
      ..write(obj.spendAmount)
      ..writeByte(2)
      ..write(obj.remainingAmount)
      ..writeByte(3)
      ..write(obj.categories)
      ..writeByte(4)
      ..write(obj.isBudgeted)
      ..writeByte(5)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
