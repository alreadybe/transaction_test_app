// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transacton_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      date: json['date'] as String,
      fee: (json['fee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'date': instance.date,
      'fee': instance.fee,
      'total': instance.total,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.transfer: 'transfer',
  TransactionType.refill: 'refill',
  TransactionType.withdrawal: 'withdrawal',
};
