import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es')
  ];

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear una cuenta'**
  String get createAccount;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get login;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In es, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @loginHere.
  ///
  /// In es, this message translates to:
  /// **'Login here'**
  String get loginHere;

  /// No description provided for @yes.
  ///
  /// In es, this message translates to:
  /// **'sí'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @helloAgain.
  ///
  /// In es, this message translates to:
  /// **'Hola'**
  String get helloAgain;

  /// No description provided for @noAccountYet.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta todavía?'**
  String get noAccountYet;

  /// No description provided for @createAccountHere.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta aquí'**
  String get createAccountHere;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get email;

  /// No description provided for @fillThisField.
  ///
  /// In es, this message translates to:
  /// **'Llena este campo'**
  String get fillThisField;

  /// No description provided for @invalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo inválido'**
  String get invalidEmail;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @newpPassword.
  ///
  /// In es, this message translates to:
  /// **'Nueva Contraseña'**
  String get newpPassword;

  /// No description provided for @passwordIncorrect.
  ///
  /// In es, this message translates to:
  /// **'Contraseña incorrecta'**
  String get passwordIncorrect;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @enterDataLogin.
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu telefono para iniciar sesión'**
  String get enterDataLogin;

  /// No description provided for @phoneNumber.
  ///
  /// In es, this message translates to:
  /// **'Número de teléfono'**
  String get phoneNumber;

  /// No description provided for @phoneNumberOrNumberClient.
  ///
  /// In es, this message translates to:
  /// **'Número de teléfono o folio'**
  String get phoneNumberOrNumberClient;

  /// No description provided for @notRegistered.
  ///
  /// In es, this message translates to:
  /// **'¿Aun no estas registrado?'**
  String get notRegistered;

  /// No description provided for @welcomeBack.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido de nuevo 👋'**
  String get welcomeBack;

  /// No description provided for @enterPin.
  ///
  /// In es, this message translates to:
  /// **'Ingresa el código de seguridad'**
  String get enterPin;

  /// No description provided for @enterPinMessage.
  ///
  /// In es, this message translates to:
  /// **'Por favor ingresa el código de 6 dígitos enviado al ** *** *** '**
  String get enterPinMessage;

  /// No description provided for @pinField.
  ///
  /// In es, this message translates to:
  /// **'Campo del PIN (6 dígitos):'**
  String get pinField;

  /// No description provided for @forgotPin.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu PIN?'**
  String get forgotPin;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @skip.
  ///
  /// In es, this message translates to:
  /// **'saltar'**
  String get skip;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In es, this message translates to:
  /// **'Número de teléfono inválido'**
  String get invalidPhoneNumber;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @enterNewPassword.
  ///
  /// In es, this message translates to:
  /// **'Ingrese nueva contraseña'**
  String get enterNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get confirmPassword;

  /// No description provided for @loginWithPassword.
  ///
  /// In es, this message translates to:
  /// **'Iniciar con contraseña'**
  String get loginWithPassword;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @ccontinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get ccontinue;

  /// No description provided for @noClientMessage.
  ///
  /// In es, this message translates to:
  /// **'El número de celular que ingresaste no se encuentra registrado en el sistema desde el momento de la contratación.  Te pedimos que el titular de la cuenta acuda a nuestro Centro de Atención a Clientes o, si lo prefieres, llámanos al 9901 01 20 25 o al 800 777 7000.'**
  String get noClientMessage;

  /// No description provided for @goBack.
  ///
  /// In es, this message translates to:
  /// **'Regresar'**
  String get goBack;

  /// No description provided for @changePassword.
  ///
  /// In es, this message translates to:
  /// **'Cambiar contraseña'**
  String get changePassword;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In es, this message translates to:
  /// **'¿Está seguro de que desea Cerrar sesión?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @initWithPhone.
  ///
  /// In es, this message translates to:
  /// **'Ingresar con teléfono o folio'**
  String get initWithPhone;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordsNotMatch;

  /// No description provided for @addAccount.
  ///
  /// In es, this message translates to:
  /// **'Añadir otra cuenta'**
  String get addAccount;

  /// No description provided for @client.
  ///
  /// In es, this message translates to:
  /// **'Cliente'**
  String get client;

  /// No description provided for @loginWithPhone.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión con telefono'**
  String get loginWithPhone;

  /// No description provided for @passwordSecurityTips.
  ///
  /// In es, this message translates to:
  /// **'Para hacer tu contraseña más segura, sigue estos pasos:\n • Incluye letras una mayúscula y una minúscula\n • Agrega al menos un número (ejemplo: 1, 2, 3...)\n • Usa alguno de estos símbolos especiales: !, \$, @, %.\n • Asegura que tenga en total 8 caracteres'**
  String get passwordSecurityTips;

  /// No description provided for @noInvoices.
  ///
  /// In es, this message translates to:
  /// **'No cuentas con facturas por el momento'**
  String get noInvoices;

  /// No description provided for @enterAccount.
  ///
  /// In es, this message translates to:
  /// **'Ingresa a tu cuenta'**
  String get enterAccount;

  /// No description provided for @init_with_password.
  ///
  /// In es, this message translates to:
  /// **'Incia sesión con contraseña'**
  String get init_with_password;

  /// No description provided for @send_message.
  ///
  /// In es, this message translates to:
  /// **'Te enviaremos un mensaje con un código al número que brindaste al momento de tu contratación.'**
  String get send_message;

  /// No description provided for @confirmInfo.
  ///
  /// In es, this message translates to:
  /// **'Validar información'**
  String get confirmInfo;

  /// No description provided for @confirmInfoMessage.
  ///
  /// In es, this message translates to:
  /// **'Verifica que la información que se presenta a continuación sea correcta.'**
  String get confirmInfoMessage;

  /// No description provided for @validInfo.
  ///
  /// In es, this message translates to:
  /// **'Validar información'**
  String get validInfo;

  /// No description provided for @validInfoMessage.
  ///
  /// In es, this message translates to:
  /// **'Verifica que la información que se presenta a continuación sea correcta.'**
  String get validInfoMessage;

  /// No description provided for @validInfoCheck.
  ///
  /// In es, this message translates to:
  /// **'Acepto términos, condiciones y politicas de privacidad de Moloch Comunicaciones.'**
  String get validInfoCheck;

  /// No description provided for @changePasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Protege tu cuenta'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordMessage.
  ///
  /// In es, this message translates to:
  /// **'Por seguridad, configura una contraseña  para acceder a tu cuenta.'**
  String get changePasswordMessage;

  /// No description provided for @noRegistered.
  ///
  /// In es, this message translates to:
  /// **'No estas registrado en el sistema'**
  String get noRegistered;

  /// No description provided for @alias.
  ///
  /// In es, this message translates to:
  /// **'Alias'**
  String get alias;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actualizada'**
  String get passwordChangedSuccessfully;

  /// No description provided for @folio.
  ///
  /// In es, this message translates to:
  /// **'Folio'**
  String get folio;

  /// No description provided for @initWithFolio.
  ///
  /// In es, this message translates to:
  /// **'Incia sesión con folio'**
  String get initWithFolio;

  /// No description provided for @invoices.
  ///
  /// In es, this message translates to:
  /// **'Facturas'**
  String get invoices;

  /// No description provided for @successPayTitle.
  ///
  /// In es, this message translates to:
  /// **'✅ ¡Pago realizado con éxito!'**
  String get successPayTitle;

  /// No description provided for @successPayMessage.
  ///
  /// In es, this message translates to:
  /// **'Tu pago se ha procesado correctamente.\nLa confirmación puede tardar hasta 5 minutos en reflejarse.'**
  String get successPayMessage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
