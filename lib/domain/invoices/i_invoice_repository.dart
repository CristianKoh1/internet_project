import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/response/current_invoice_model.dart';
import 'package:moloch_app/domain/response/invoice_model.dart';
import 'package:moloch_app/domain/response/invoice_response_model.dart';

/// Interfaz del repositorio de autenticación.
///
/// Esta interfaz define métodos para el manejo de autenticación,
/// incluyendo inicio de sesión, solicitud y actualización de PIN, y validación de PIN.
@factoryMethod
abstract class IInvoiceRepository {
  Future<Either<OperationFailure, List<InvoiceModel>>> getInvoices();
  Future<Either<OperationFailure, CurrentInvoiceModel?>> getCurrentInvoice();
  Future<Either<OperationFailure, InvoiceResponseModel>> getInvoiceDetail({required String idfactura});
  Future<Either<OperationFailure, String>> getPayUrl({required String idfactura});
}
