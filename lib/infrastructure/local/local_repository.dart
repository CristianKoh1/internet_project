import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moloch_app/domain/core/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';

@prod
@LazySingleton(as: ILocalRepository)
class LocalRepository implements ILocalRepository {
  static const _cuentas = 'cuentas';
  static const _clienteActivo = 'cliente_activo';
  static const _isSettingUpPinCode = 'is_setting_up_pin_code';

  @override
  Future<bool> saveIsSettingUpPinCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_isSettingUpPinCode, true);
  }

  @override
  Future<bool> getIsSettingUpPinCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs.getBool(_isSettingUpPinCode) ?? false;
  }

  @override
  Future<bool> deleteIsSettingUpPinCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_isSettingUpPinCode);
  }

  @override
  Future<void> saveOrUpdateAccount(String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    decodedToken['token'] = token;
    final account = Account.fromJson(decodedToken);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_clienteActivo, account.cliente);
    final cuentas = await getAccounts();

    final index = cuentas.indexWhere((c) => c.cliente == account.cliente);
    if (index >= 0) {
      cuentas[index] = account;
    } else {
      cuentas.add(account);
    }

    final cuentasMap = cuentas.map((c) => c.toJson()).toList();
    await prefs.setString(_cuentas, jsonEncode(cuentasMap));
  }

  @override
  Future<List<Account>> getAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final cuentasRaw = prefs.getString(_cuentas);
    if (cuentasRaw == null) return [];

    final decoded = jsonDecode(cuentasRaw) as List<dynamic>;
    return decoded.map((json) => Account.fromJson(json)).toList();
  }

  @override
  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cuentas);
    await prefs.remove(_clienteActivo);
  }

  @override
  Future<void> switchToAccount(String cliente) async {
    final prefs = await SharedPreferences.getInstance();
    final cuentas = await getAccounts();
    final existe = cuentas.any((c) => c.cliente == cliente);
    if (existe) {
      await prefs.setString(_clienteActivo, cliente);
    }
  }

  @override
  Future<String?> getActiveToken() async {
    final cuenta = await getActiveAccount();
    return cuenta?.token;
  }

  @override
  Future<Account?> getActiveAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final clienteActivo = prefs.getString(_clienteActivo);
    if (clienteActivo == null) return null;

    final cuentas = await getAccounts();
    final index = cuentas.indexWhere((c) => c.cliente == clienteActivo);

    if (index == -1) return null;

    return cuentas[index];
  }
}
