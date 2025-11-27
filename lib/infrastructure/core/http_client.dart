import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:moloch_app/config/enviroment.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';



enum HttpClientType {
  json(value: 'application/json'),
  file(value: 'multipart/form-data');

  final String value;

  const HttpClientType({required this.value});
}

@injectable
class HttpClient {
  final ILocalRepository localRepository;

  HttpClient(this.localRepository);

  /// Realiza una petición HTTP de tipo POST.
  ///
  /// - `endpoint`: La ruta del endpoint al cual se realizará la petición.
  /// - `body`: El cuerpo de la solicitud, opcional, se codifica como JSON si está presente.
  /// - `type`: Tipo de contenido de la solicitud, por defecto es `HttpClientType.json`.
  Future<http.Response> post({
    required String endpoint,
    dynamic body,
    bool sendToken = true,
    HttpClientType type = HttpClientType.json,
  }) async {
    final String? token = await localRepository.getActiveToken();
    final url = Uri.parse(_getUrl(endpoint));
    Map<String, String> headers;

    if (sendToken) {
      headers = {
        'Authorization':  token ?? '',
        'Content-Type': type.value,
      };
    } else {
      headers = {'Content-Type': type.value};
    }
    if (body == null) {
      return http.post(url, headers: headers);
    }
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    _shouldShowModal(response);
    _updateTokenIfPresent(response);

    return response;
  }

  /// Realiza una petición HTTP de tipo PUT.
  ///
  /// - `endpoint`: La ruta del endpoint al cual se realizará la petición.
  /// - `body`: El cuerpo de la solicitud, opcional, se codifica como JSON si está presente.
  Future<http.Response> put({required String endpoint, dynamic body}) async {
    final String? token = await localRepository.getActiveToken();
    final url = Uri.parse(_getUrl(endpoint));
    final headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    if (body == null) {
      return http.put(url, headers: headers, body: jsonEncode(body));
    }
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    _shouldShowModal(response);
    _updateTokenIfPresent(response);

    return response;
  }

  /// Realiza una petición HTTP de tipo DELETE.
  ///
  /// - `endpoint`: La ruta del endpoint al cual se realizará la petición.
  Future<http.Response> delete({required String endpoint}) async {
    final String? token = await localRepository.getActiveToken();
    final url = Uri.parse(_getUrl(endpoint));
    final response = await http.delete(
      url,
      headers: {
        'Authorization': token ?? '',
        'Content-Type': 'application/json',
      },
    );

    _shouldShowModal(response);
    _updateTokenIfPresent(response);

    return response;
  }

  /// Realiza una petición HTTP de tipo GET a un servidor remoto.
  ///
  /// - `endpoint`: La ruta del endpoint al cual se realizará la petición.
  Future<http.Response> get({required String endpoint}) async {
    final String? token = await localRepository.getActiveToken();
    final url = Uri.parse(_getUrl(endpoint));
    final response = await http.get(
      url,
      headers: {
        'Authorization': token ?? '',
        'Content-Type': 'application/json',
      },
    );

    _shouldShowModal(response);
    _updateTokenIfPresent(response);

    return response;
  }

  /// Obtiene la URL final para la petición según el entorno de la aplicación.
  ///
  /// - `endpoint`: La ruta del endpoint al cual se realizará la petición.
  String _getUrl(String endpoint) {
    return Enviroments.apiURL + endpoint;
  }

  /// Actualiza el token en el local storage si se encuentra un nuevo token
  /// en la respuesta de la API.
  ///
  /// Esta función se encarga de manejar la respuesta de la API y verificar
  /// si el código de estado es 200 (OK) o 201 (Creado). Si es así, busca
  /// un nuevo token en el encabezado `new-token`. Si se encuentra un
  /// nuevo token, se guarda en el local storage.
  ///
  /// - [response]: La respuesta HTTP de la API que se está manejando.
  Future<void> _updateTokenIfPresent(http.Response response) async {
    if (response.statusCode != 200 && response.statusCode != 201) return;

    final newToken = response.headers['new-token'];

    if (newToken == null || newToken.isEmpty) return;

    await localRepository.saveOrUpdateAccount(newToken);
  }

  /// Notifica sobre la expiración del token cuando se recibe un código de estado 401.
  ///
  /// Si la respuesta de la API indica que el token ha caducado (código 401),
  /// se dispara un evento a través del `apiEventBus` para manejar la expiración
  /// del token, como podría ser solicitar un nuevo inicio de sesión o refrescar el token.
  Future<void> _shouldShowModal(http.Response response) async {
    return;
  }
}
