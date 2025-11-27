import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/invoices/i_invoice_repository.dart';
import 'package:moloch_app/domain/response/current_invoice_model.dart';
import 'package:moloch_app/domain/response/factura_model.dart';
import 'package:moloch_app/domain/response/invoice_model.dart';
import 'package:moloch_app/domain/response/invoice_response_model.dart';
import 'package:moloch_app/infrastructure/utils/fake_utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@dev
@LazySingleton(as: IInvoiceRepository)
class FakeInvoiceRepository implements IInvoiceRepository {
  @override
  Future<Either<OperationFailure, List<InvoiceModel>>> getInvoices() async {
    await FakeUtils.delayed();
    return right([]);
  }

  @override
  Future<Either<OperationFailure, CurrentInvoiceModel?>>
  getCurrentInvoice() async {
    await FakeUtils.delayed();
    return right(
      CurrentInvoiceModel(
        totalAfter: '100.00',
        totalBefore: '120.00',
        cutDate: '2023-10-01',
        limitDate: '2023-10-31',
        idBill: 'INV123456',
        statusBill: 'paid',
        flagListprice: 'standard',
        dayPay: '15',
        idClient: 'CLT123456',
        nameClient: 'John Doe',
        statusClient: 'active',
      ),
    );
  }

  @override
  Future<Either<OperationFailure, String>> getPayUrl({
    required String idfactura,
  }) async {
    await FakeUtils.delayed();
    return right('');
  }

  @override
  Future<Either<OperationFailure, InvoiceResponseModel>> getInvoiceDetail({required String idfactura}) async{
    await FakeUtils.delayed();
    return right(InvoiceResponseModel(
      factura: FacturaModel(),
      items: [],
      emisor: [],
    ));
  }
}
