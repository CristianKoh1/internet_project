import 'package:moloch_app/l10n/app_localizations.dart';
import 'package:moloch_app/presentation/utils/responsive/responsive.dart';
import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/theme/extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Este widget representa un diálogo con una imagen opcional, un título,
/// un mensaje, un boton para omitir y otro para ejecutar la accion deseada.
/// El diálogo se adapta
/// automáticamente al tamaño de la pantalla y aplica diferentes tamaños de padding
/// según las dimensiones de la pantalla y el dispositivo.
///
/// Parámetros:
/// - `title`: El título del diálogo, que se muestra en la parte superior del diálogo.
/// - `message`: El mensaje principal del diálogo, que se muestra debajo del título.
/// - `buttonText`: El texto del botón de que ejecuta la accion ingresada como callback.
/// - `buttonCallback`: Una función de retorno de llamada que se ejecutará cuando
///   se presione el botón.
class CustomSkipDialog extends StatelessWidget {
  /// `CustomSkipDialog` es un widget de diálogo personalizado utilizado en la aplicación AfinClic.
  ///
  /// Para su uso es recomendable utilizar `CustomSkipDialog`
  const CustomSkipDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.buttonCallback,
  });

  final String title;
  final String message;
  final String buttonText;
  final Function()? buttonCallback;

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    double padding = 30;

    return LayoutBuilder(
      builder: (_, constrains) {
        if (kIsWeb && constrains.maxWidth < 1000) {
          padding = responsive.dp(5);
        } else if (kIsWeb && constrains.maxWidth >= 1000) {
          padding = responsive.dp(30);
        }

        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: padding, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .extension<CustomColors>()
                        ?.neutral100,
                    borderRadius: BorderRadius.circular(20)),
                child: CustomPadding(
                  top: 20,
                  bottom: 20,
                  left: 25,
                  right: 25,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _title(context),
                        const SizedBox(height: 5),
                        _message(context),
                        const SizedBox(height: 20),
                        _buttons(context)
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Row _buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_skipButton(context), _button(context)],
    );
  }

  Widget _skipButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: CustomButton(
        type: CustomButtonType.text,
        text: AppLocalizations.of(context).skip,
        onPressed: () {
          AutoRouter.of(context).maybePop();
        },
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: CustomButton(
        type: CustomButtonType.primary,
        text: buttonText,
        onPressed: () async{
         await AutoRouter.of(context).maybePop();
          buttonCallback?.call();
        },
      ),
    );
  }

  Padding _message(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        message,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral0,
            height: 1.5),
      ),
    );
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
