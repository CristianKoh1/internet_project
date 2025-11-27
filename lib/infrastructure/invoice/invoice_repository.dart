import 'package:moloch_app/domain/core/operation_failure/operation_failure.dart';
import 'package:moloch_app/domain/invoices/i_invoice_repository.dart';
import 'package:moloch_app/domain/response/current_invoice_model.dart';
import 'package:moloch_app/domain/response/invoice_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/response/invoice_response_model.dart';
import 'package:moloch_app/infrastructure/core/http_client.dart';
import 'package:moloch_app/infrastructure/utils/response_decode.dart';

/// Implementación concreta de [IInvoiceRepository] que utiliza un cliente HTTP para interactuar con un servicio externo relacionado con la autenticación y gestión de PIN.
///
/// Esta clase se registra como un singleton perezoso y proporciona métodos para iniciar sesión con contraseña, solicitar un nuevo PIN, confirmar código de solicitud de PIN,
/// actualizar PIN, iniciar sesión con PIN, y validar PIN.
@prod
@LazySingleton(as: IInvoiceRepository)
class InvoiceRepository implements IInvoiceRepository {
  final HttpClient _httpClient;

  InvoiceRepository(this._httpClient);

  @override
  Future<Either<OperationFailure, List<InvoiceModel>>> getInvoices() async{
     try {
      final response = await _httpClient.get(
        endpoint: '/PublicUserController/get_invoices',
      );

      if (response.statusCode == 200) {
        final responseModel = responseDecode<List<InvoiceModel>>(
          response,
          (json) =>
              (json as List).map((e) => InvoiceModel.fromJson(e)).toList(),
        );

        final List<InvoiceModel>? data = responseModel.data;
        if (responseModel.status && data != null) {
          return right(data);
        } else {
          return left(
            OperationFailure(
              code: response.statusCode,
              message: responseModel.message,
            ),
          );
        }
      }
      return left(OperationFailure());
    } catch (e) {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<OperationFailure, CurrentInvoiceModel?>> getCurrentInvoice() async {
    try {
      final response = await _httpClient.get(
        endpoint: '/PublicUserController/get_current_invoice',
      );

      if (response.statusCode == 200) {
        final responseModel = responseDecode<CurrentInvoiceModel?>(
          response,
          (json) => CurrentInvoiceModel.fromJson(json),
        );

        final CurrentInvoiceModel? data = responseModel.data;
        if (responseModel.status) {
          return right(data);
        } else {
          return left(
            OperationFailure(
              code: response.statusCode,
              message: responseModel.message,
            ),
          );
        }
      }
      return left(OperationFailure());
    } catch (e) {
      return left(OperationFailure());
    }
  }
  
  @override
  Future<Either<OperationFailure, String>> getPayUrl({required String idfactura}) async{
      try {
      final response = await _httpClient.post(
        endpoint: '/PublicUserController/get_link_to_pay_bill',
        body: {'idfactura': idfactura},
      );

      if (response.statusCode == 200) {
        final responseModel = responseDecode(
          response,
          (json) => json as Map<String, dynamic>,
        );

        final data = responseModel.data;
        if (responseModel.status && data != null) {
          return right(data['url']);
        } else {
          return left(
            OperationFailure(
              code: response.statusCode,
              message: responseModel.message,
            ),
          );
        }
      }
      return left(OperationFailure());
    } catch (e) {
      return left(OperationFailure());
    }
  }

  @override
  Future<Either<OperationFailure, InvoiceResponseModel>> getInvoiceDetail({required String idfactura}) async{
    try {
      final response = await _httpClient.post(
        endpoint: '/PublicUserController/get_invoice_detail',
        body: {"id": idfactura} ,
      );

      if (response.statusCode == 200) {
        final responseModel = responseDecode<InvoiceResponseModel?>(
          response,
          (json) => InvoiceResponseModel.fromJson(json),
        );

        final InvoiceResponseModel? data = responseModel.data;
        if (responseModel.status && data != null) {
          return right(data);
        } else {
          return left(
            OperationFailure(
              code: response.statusCode,
              message: responseModel.message,
            ),
          );
        }
      }
      return left(OperationFailure());
    } catch (e) {
      return left(OperationFailure());
    }
  }
}
