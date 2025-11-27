import 'package:moloch_app/presentation/utils/responsive/responsive.dart';
import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/theme/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Este widget representa un diálogo con una imagen opcional, un título, un mensaje,
/// botones primarios y secundarios, y un botón para cerrar el diálogo. Puede mostrar
/// imágenes en formato SVG o en formato de imagen. El diálogo se adapta
/// automáticamente al tamaño de la pantalla y aplica diferentes tamaños de padding
/// según las dimensiones de la pantalla y el dispositivo.
///
/// Parámetros:
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
class CustomDialog extends StatelessWidget {
  final bool disableClickOutsideModal;
  final Function()? onClose;
  final bool iconButtonClose;
  final String imageUrl;
  final String title;
  final String? message;
  final String primaryButtonText;
  final Function()? primaryButtonCallback;
  final String? secondaryButtonText;
  final Function()? secondaryButtonCallback;

  /// `CustomDialog` es un widget de diálogo personalizado utilizado en la aplicación.
  ///
  /// Para su uso es recomendable utilizar `showCustomDialog`
  const CustomDialog({
    super.key,
    this.disableClickOutsideModal = false,
    this.onClose,
    this.iconButtonClose = true,
    required this.imageUrl,
    required this.title,
    this.message,
    required this.primaryButtonText,
    required this.primaryButtonCallback,
    this.secondaryButtonText,
    this.secondaryButtonCallback,
  });

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

        return Stack(
          children: [
            _onCloseWidget(context),
            _body(padding, context),
          ],
        );
      },
    );
  }

  Widget _onCloseWidget(BuildContext context) {
    if (onClose == null) const SizedBox();

    return GestureDetector(
      onTap: () {
        if (!disableClickOutsideModal) {
          context.router.maybePop();
          onClose?.call();
        }
      },
      child: Container(
        color: Colors.transparent,
      ),
    );
  }

  Center _body(double padding, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).extension<CustomColors>()?.neutral100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomPadding(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  iconButtonClose ? _iconButtonClose(context) : SizedBox(),
                  _image(),
                  _title(context),
                  _message(context),
                  _primaryButton(),
                  _secondaryButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _iconButtonClose(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            context.router.maybePop();
            onClose?.call();
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).extension<CustomColors>()?.primary,
          ),
        )
      ],
    );
  }

  Padding _image() {
    final Widget image;
    if (imageUrl.contains('.svg')) {
      image = SvgPicture.asset(
        imageUrl,
        height: 230,
        width: 230,
      );
    } else {
      image = Image.asset(
        imageUrl,
        height: 230,
        width: 230,
        fit: BoxFit.cover,
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21),
      child: image,
    );
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).extension<CustomColors>()?.neutral0,
            ),
      ),
    );
  }

  Padding _message(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        message ?? '',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).extension<CustomColors>()?.neutral30,
            ),
      ),
    );
  }

  Padding _primaryButton() {
    return Padding(
      padding: EdgeInsets.only(
        top: 7,
        bottom: secondaryButtonText == null ? 7 : 2,
      ),
      child: CustomButton(
        type: CustomButtonType.primary,
        text: primaryButtonText,
        onPressed: primaryButtonCallback,
      ),
    );
  }

  Widget _secondaryButton() {
    if (secondaryButtonText == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: CustomButton(
        type: CustomButtonType.secondary,
        text: secondaryButtonText ?? '',
        onPressed: secondaryButtonCallback,
      ),
    );
  }
}
