import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/core/account.dart';

/// Repositorio que maneja las operaciones de almacenamiento local.
///
/// Este repositorio define métodos para guardar, obtener y eliminar
/// datos relacionados con las cuentas de usuario, tokens, y configuración del código PIN.
@factoryMethod
abstract class ILocalRepository {
  /// Guarda o actualiza una cuenta.
  ///
  /// [account] debe contener al menos "cliente", "nombre", "phone" y "token".
  Future<void> saveOrUpdateAccount(String token);

  /// Obtiene todas las cuentas guardadas.
  ///
  /// Devuelve una lista de cuentas como objetos [account].
  Future<List<Account>> getAccounts();

  Future<void> deleteAccount();

  /// Cambia la cuenta activa actual según su [cliente].
  Future<void> switchToAccount(String cliente);

  /// Obtiene el token de la´ cuenta activa.
  ///
  /// Devuelve un `Future` que resuelve en el token o `null` si no hay sesión activa.
  Future<String?> getActiveToken();

  /// Obtiene los datos completos de la cuenta activa.
  ///
  /// Devuelve un `Future` que resuelve en un objeto [Cuenta] o `null`.
  Future<Account?> getActiveAccount();

  /// Guarda el estado de configuración del código PIN.
  ///
  /// Devuelve `true` si se guardó exitosamente.
  Future<bool> saveIsSettingUpPinCode();

  /// Verifica si el código PIN está en proceso de configuración.
  ///
  /// Devuelve `true` si se está configurando, `false` en otro caso.
  Future<bool> getIsSettingUpPinCode();

  /// Elimina el estado de configuración del código PIN.
  ///
  /// Devuelve `true` si se eliminó exitosamente.
  Future<bool> deleteIsSettingUpPinCode();
}
