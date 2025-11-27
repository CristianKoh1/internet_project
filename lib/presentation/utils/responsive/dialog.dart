import 'package:moloch_app/presentation/widget/custom/custom_dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_draggable_scrollable_sheet.dart';
import 'package:moloch_app/presentation/widget/custom/custom_skip_dialog.dart';
import 'package:moloch_app/presentation/widget/custom/custom_snack_bar.dart';
import 'package:moloch_app/domain/enums/url_type.dart';
import 'package:flutter/material.dart';

/// `showCustomDialog` es una función de utilidad que muestra un diálogo personalizado
/// `CustomDialog` en el contexto proporcionado.
///
/// Esta función simplifica la creación y presentación de un `CustomDialog`
///
/// Parámetros:
/// - `context`: El contexto en el que se mostrará el diálogo.
/// - `imageUrl`: La ruta de la imagen que se mostrará en el diálogo. Puede ser una imagen
///   en formato SVG o en otro formato de imagen admitido por Flutter.
/// - `title`: El título del diálogo, que se muestra en la parte superior del diálogo.
/// - `message`: El mensaje principal del diálogo, que se muestra debajo del título.
/// - `primaryButtonText`: El texto del botón primario del diálogo.
/// - `primaryButtonCallback`: Una función de retorno de llamada que se ejecutará cuando
///   se presione el botón primario del diálogo.
/// - `secondaryButtonText`: El texto del botón secundario del diálogo (opcional).
/// - `secondaryButtonCallback`: Una función de retorno de llamada que se ejecutará cuando
///   se presione el botón secundario del diálogo (opcional).
void showCustomDialog(
  BuildContext context, {
  bool disableClickOutsideModal = false,
  void Function()? onClose,
  bool iconButtonClose = true,
  required String imageUrl,
  required String title,
  String? message,
  required String primaryButtonText,
  required void Function() primaryButtonCallback,
  String? secondaryButtonText,
  void Function()? secondaryButtonCallback,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return CustomDialog(
        disableClickOutsideModal: disableClickOutsideModal,
        onClose: onClose,
        iconButtonClose: iconButtonClose,
        imageUrl: imageUrl,
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        primaryButtonCallback: primaryButtonCallback,
        secondaryButtonText: secondaryButtonText,
        secondaryButtonCallback: secondaryButtonCallback,
      );
    },
  );
}

/// `showCustomDialog` es una función de utilidad que muestra un diálogo personalizado
/// `CustomDialog` en el contexto proporcionado.
///
/// Esta función simplifica la creación y presentación de un `CustomDialog`
///
/// Parámetros:
/// - `context`: El contexto en el que se mostrará el diálogo.
/// - `title`: El título del diálogo, que se muestra en la parte superior del diálogo.
/// - `message`: El mensaje principal del diálogo, que se muestra debajo del título.
/// - `buttonText`: El texto del botón de que ejecuta la accion ingresada como callback.
/// - `buttonCallback`: Una función de retorno de llamada que se ejecutará cuando
///   se presione el botón.
void showCustomSkipDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String buttonText,
  void Function()? buttonCallback,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return CustomSkipDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        buttonCallback: buttonCallback,
      );
    },
  );
}

/// `showModalBottomSheetCustom` es una función de utilidad que muestra un showModalBottomSheet personalizado
/// `CustomDraggableScrollableSheet` en el contexto proporcionado.
///
/// Esta función simplifica la creación y presentación de un `showModalBottomSheet`
///
/// Parámetros:
/// - `context`: El contexto en el que se mostrará el diálogo.
/// - `initialChildSize`: El tamaño de la altura del ModalBottomSheet que se
///   abrira al dale click.
/// - `minChildSize`: El tamaño minimo al que llegara el ModalBottomSheet cuando
///   el usuraio desplace el ModalBottomSheet ventana hacia abajo.
/// - `maxChildSize`: El tamaño maximo al que llegara el ModalBottomSheet cuando
///   el usuraio desplace el ModalBottomSheet ventana hacia arriba.
/// - `title`: El título del ModalBottomSheet, que se muestra en la parte superior del diálogo.
/// - `textAlign`: De tipo TextAlign que nos inidcara como queremos que se muestre el title.
/// - `messageOne`: El mensaje principal del diálogo, que se muestra debajo del título.
/// - `imageUrl`: La ruta de la imagen que se mostrará en el diálogo. Puede ser una imagen
///   en formato SVG o en otro formato de imagen admitido por Flutter.
/// - `messageTwo`: Un mensaje secundario del diálogo, que se muestra debajo del mensaje princiapal.
/// - `linkText`: El texto que se mostrara al usuario para donde lo vamos a redirigir.
/// - `link`: El link de la página web hacia donde lo vamos a dirigir cuando le de click al linkText.
/// - `buttonText`: El texto del botón del diálogo.
/// - `onPressed`: Una función de retorno de llamada que se ejecutará cuando se presione el
///   botón del diálogo.
void showModalBottomSheetCustom(
  BuildContext context, {
  double? initialChildSize,
  double? minChildSize,
  double? maxChildSize,
  required String title,
  TextAlign? textAlign,
  required String messageOne,
  String? imageUrl,
  String? messageTwo,
  String? linkText,
  String? link,
  required String buttonText,
  required Function() onPressed,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return CustomDraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        title: title,
        textAlign: textAlign,
        messageOne: messageOne,
        imageUrl: imageUrl,
        messageTwo: messageTwo,
        linkText: linkText,
        link: link,
        buttonText: buttonText,
        onPressed: onPressed,
      );
    },
  );
}

/// `showCustomSnackBar` es una función de utilidad que muestra un showSnackBar personalizado
/// `CustomSnackBar` es el contexto proporcionado.
///
/// Esta función simplifica la creación y presentación de un `showSnackBar`
///
/// Parámetros:
/// - `context`: El contexto en el que se mostrará el diálogo.
/// - `CustomSnackBarType`: Es el tipo de showCustomSnackBar que queremos usar, por
///   defecto no se usa ninguno para poder personalizarlo pero podemos usar el de
///   tipo error para un diseño ya predefinido.
/// - `message`: El texto del mensaje a mostrar.
/// - `textColor`: Es el color de las letras del message, por defecto cuenta con un
///   color que es el neutral100.
/// - `duration`: Indica el tiempo que estara visible el SnackBar, por defecto tiene
///   un tiempo de 4 segundos.
void showCustomSnackBar({
  required BuildContext context,
  CustomSnackBarType type = CustomSnackBarType.success,
  String? message,
  Color? textColor,
  Duration? duration,
}) {
  String newMessage = message ?? 'Error, por favor intenta de nuevo';

  final snackBar = CustomSnackBar(
    type: type,
    message: newMessage,
    textColor: textColor,
    duration: duration,
  ).createSnackBar(context);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// `showCustomDialogWithoutImage` es una función de utilidad que muestra un diálogo
///  personalizado sin imagen
/// `CustomDialog` en el contexto proporcionado.
///
/// Esta función simplifica la creación y presentación de un `CustomDialog`
///
/// Parámetros:
/// - `context`: El contexto en el que se mostrará el diálogo.
/// - `type`: Es el tipo de WebView que se mostrara con su respectivo mensaje y url.
void showCustomDialogWithoutImage(
  BuildContext context, {
  required UrlType type,
}) {}
