import 'package:moloch_app/config/enviroment.dart';
import 'package:moloch_app/config/injectable.config.dart';
import 'package:moloch_app/domain/core/enums/enviroments_type.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Instancia global de GetIt para la inyección de dependencias.
GetIt getIt = GetIt.instance;


@InjectableInit()
void configureDependencies() {
  final env = Enviroments.appEnv;
  final dev = EnviromentType.dev.value;

  if (env == dev) {
    getIt.init(environment: dev);
    return;
  }
  getIt.init(environment: EnviromentType.prod.value);
}
