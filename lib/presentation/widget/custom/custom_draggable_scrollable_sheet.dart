import 'package:moloch_app/presentation/widget/custom/custom_button.dart';
import 'package:moloch_app/theme/extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDraggableScrollableSheet extends StatelessWidget {
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;
  final String title;
  final TextAlign? textAlign;
  final String messageOne;
  final String? imageUrl;
  final String? messageTwo;
  final String? linkText;
  final String? link;
  final String buttonText;
  final Function() onPressed;

  const CustomDraggableScrollableSheet({
    super.key,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    required this.title,
    this.textAlign = TextAlign.start,
    required this.messageOne,
    this.imageUrl = '',
    this.messageTwo = '',
    this.linkText = '',
    this.link = '',
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomColors>()?.neutral100,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: _bodyDraggable(context),
    );
  }

  Widget _bodyDraggable(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(Icons.drag_handle_outlined),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _tittleDraggable(context),
                SizedBox(height: 16),
                _messageText(
                  context,
                  messageOne,
                ),
                imageUrl != null ? _imageBody() : SizedBox(),
                messageTwo != null
                    ? _messageText(
                        context,
                        messageTwo ?? '',
                      )
                    : SizedBox(),
                linkText != null ? _linkBody(context) : SizedBox(),
              ],
            ),
          ),
          _button(context)
        ],
      ),
    );
  }

  Text _tittleDraggable(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral0,
          ),
    );
  }

  Text _messageText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).extension<CustomColors>()?.neutral30,
          ),
    );
  }

  Column _imageBody() {
    return Column(
      children: [
        SizedBox(height: 16),
        _image(),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _image() {
    final String image =
        imageUrl ?? 'assets/images/home/Illustration.png';
    if (image.contains('.svg')) {
      return SvgPicture.asset(
        image,
        height: 230,
        width: 230,
      );
    } else {
      return Image.asset(
        image,
        width: double.infinity,
        fit: BoxFit.fitWidth,
      );
    }
  }

  Column _linkBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        _link(context),
      ],
    );
  }

  Container _link(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        child: Text(
          linkText ?? '',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral0,
              ),
        ),
        onTap: () async {
          final Uri url = Uri.parse(link ?? '');
          if (!await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          )) {
            throw 'No puede abrir el navegador';
          }
        },
      ),
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomButton(
        text: buttonText,
        onPressed: onPressed,
      ),
    );
  }
}
