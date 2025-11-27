import 'package:injectable/injectable.dart';
import 'package:moloch_app/domain/core/account.dart';
import 'package:moloch_app/domain/local/i_local_repository.dart';

@dev
@LazySingleton(as: ILocalRepository)
class FakeLocalRepository implements ILocalRepository {
  @override
  Future<bool> saveIsSettingUpPinCode() async {
    return true;
  }

  @override
  Future<bool> getIsSettingUpPinCode() async {
    return false;
  }

  @override
  Future<bool> deleteIsSettingUpPinCode() async {
    return true;
  }

  @override
  Future<void> deleteAccount() async {
    return;
  }

  @override
  Future<List<Account>> getAccounts() async {
    return [Account(cliente: '', nombre: '', phone: '', token: '')];
  }

  @override
  Future<Account?> getActiveAccount() async {
    return Account(cliente: '', nombre: '', phone: '', token: '');
  }

  @override
  Future<String?> getActiveToken() async {
    return '';
  }

  @override
  Future<void> saveOrUpdateAccount(String token) async {
    return;
  }

  @override
  Future<void> switchToAccount(String cliente) async{
    return;
  }
}
