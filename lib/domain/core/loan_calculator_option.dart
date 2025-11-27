import 'package:moloch_app/domain/core/plan_model.dart';
import 'package:decimal/decimal.dart';

class LoanCalculatorOption {
  final PlanModel plan;
  final Decimal weeklyPayment;
  final Decimal totalPayment;
  final Decimal depositAmount;
  final Decimal oppeningFee;

  LoanCalculatorOption({
    required this.oppeningFee,
    required this.plan,
    required this.weeklyPayment,
    required this.totalPayment,
    required this.depositAmount,
  });
}