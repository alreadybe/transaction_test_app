import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transaction_app/models/transaction_type_model.dart';

part 'transacton_model.freezed.dart';
part 'transacton_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required TransactionType type,
    required double amount,
    required String date,
    required double fee,
    required double total,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
