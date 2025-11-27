import 'package:moloch_app/presentation/widget/custom/custom_input.dart';
import 'package:moloch_app/presentation/widget/custom/custom_padding.dart';
import 'package:moloch_app/theme/app_colors.dart';
import 'package:moloch_app/theme/extension.dart';
import 'package:flutter/material.dart';

class CustomPinWidget extends StatefulWidget {
  final bool enable;
  final String header;
  final String message;
  final bool labelLarge;
  final bool isFooter;
  final String footer;
  final bool isBiometric;
  final Function()? onBiometric;
  final Function(String)? onConfirm;

  const CustomPinWidget({
    Key? key,
    this.enable = true,
    this.header = '',
    this.message = '',
    this.labelLarge = true,
    this.isFooter = true,
    this.footer = '',
    this.isBiometric = true,
    this.onBiometric,
    this.onConfirm,
  }) : super(key: key);

  @override
  State<CustomPinWidget> createState() => _CustomPinWidgetState();
}

class _CustomPinWidgetState extends State<CustomPinWidget> {
  final FocusNode focusNode = FocusNode();
  final textEditingController = TextEditingController();
  late String pin;
  late List<bool> isCircleFilled;

  @override
  void initState() {
    super.initState();
    pin = '';
    isCircleFilled = List.generate(6, (index) => false);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _header(),
        SizedBox(height: 10),
        _pinList(context),
        _keyBoard(context),
      ],
    );
  }

  Widget _header() {
    return CustomPadding(
      bottom: 0,
      child: Center(
        child: Column(
          children: [
            _text(text: widget.header, labelLarge: widget.labelLarge),
            SizedBox(height: 15),
            Text(widget.message,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).extension<CustomColors>()?.neutral0,
                )),
          ],
        ),
      ),
    );
  }

  Text _text({required String text, required bool labelLarge}) {
    return Text(
      text,
      style:
          labelLarge
              ? Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral0,
              )
              : Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).extension<CustomColors>()?.neutral0,
              ),
    );
  }

  Widget _pinList(_context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
        Future.delayed(Duration(milliseconds: 100), () {
          FocusScope.of(_context).requestFocus(focusNode);
        });
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(6, (index) => _pinBox(index)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _pinBox(int index) {
    Color neutral30 =
        Theme.of(context).extension<CustomColors>()?.neutral30 ??
        AppColors.neutral30;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Opacity(
        opacity: .4,
        child: Container(
          width: 43,
          height: 63,
          decoration: BoxDecoration(
            color: isCircleFilled[index] ? neutral30 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: neutral30),
          ),
          child: !isCircleFilled[index] ? SizedBox() : _filledPin(),
        ),
      ),
    );
  }

  Widget _filledPin() {
    return Center(
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).extension<CustomColors>()?.neutral100,
        ),
      ),
    );
  }

  Widget _footer() {
    return TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: _text(text: widget.footer, labelLarge: false),
      onPressed: () {
        //AutoRouter.of(context).push(const RecoverPinStepOneRoute());
      },
    );
  }

  Widget _keyBoard(BuildContext context) {
    final bool enable = widget.enable;
    return AbsorbPointer(
      absorbing: !enable,
      child: Opacity(
        opacity: 0,
        child: CustomInput(
          controller: textEditingController,
          keyboardType: CustomTextInputType.number,
          focusNode: focusNode,
          onChanged: (newPin) {
            _setPin(newPin);
            if (newPin.length >= 6) {
              focusNode.unfocus();
              textEditingController.clear();
              widget.onConfirm?.call(newPin);
              _setPin('');
            }
          },
        ),
      ),
    );
  }

  void _setPin(String newPin) {
    setState(() {
      pin = newPin;
      for (int i = 0; i < 6; i++) {
        isCircleFilled[i] = i < newPin.length;
      }
    });
  }
}
