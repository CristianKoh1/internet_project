part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.initial({
    @Default(false) bool loading,
    @Default(Option.none()) Option<List<Account>> accounts,
    @Default(Option.none()) Option<Account> activeAccount,
    @Default(Option.none()) Option<Either<OperationFailure, List<InvoiceModel>>> invoicesResponse,
    @Default(Option.none()) Option<Either<OperationFailure, CurrentInvoiceModel?>> currentInvoiceResponse,
    @Default(Option.none()) Option<Either<OperationFailure, InvoiceResponseModel>> getInvoiceDetailResponse,
    @Default(Option.none()) Option<Either<OperationFailure, String>> getPayUrlResponse,
  }) = _HomeInitial;
}
