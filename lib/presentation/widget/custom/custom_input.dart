import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moloch_app/theme/app_colors.dart';
import 'package:moloch_app/theme/extension.dart';

enum CustomInputType { enabled, disabled, sendMoney, molochSecundary }

enum CustomTextInputType {
  accountNumber,
  countryCode,
  curp,
  dateTime,
  email,
  itin,
  money,
  name,
  number,
  password,
  phone,
  pin,
  postalcode,
  rfc,
  routingNumberAba,
  ssn,
  text,
}

class CustomInput extends StatefulWidget {
  final String? initValue;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final Widget? sufix;
  final String? suffixText;
  final bool obscureText;
  final CustomInputType type;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final TextEditingController? controller;
  final EdgeInsets padding;
  final Widget? prefixIcon;
  final CustomTextInputType keyboardType;
  final FocusNode? focusNode;

  const CustomInput({
    Key? key,
    this.initValue = '',
    this.hintText = '',
    this.labelText,
    this.helperText,
    this.sufix,
    this.suffixText,
    this.obscureText = false,
    this.icon,
    this.onIconPressed,
    this.type = CustomInputType.enabled,
    this.onChanged,
    this.validator,
    this.controller,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.prefixIcon,
    this.keyboardType = CustomTextInputType.text,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final TextEditingController _controller = TextEditingController();
  late String currentText;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    final initText = widget.initValue != null ? widget.initValue! : '';
    currentText = initText;
    _controller.text = initText;
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDisable = false;

    if (widget.type == CustomInputType.disabled) {
      isDisable = true;
    }

    return isDisable == true ? inputDisable() : inputEnable();
  }

  Widget inputEnable() {
        final molochSecondary = widget.type == CustomInputType.molochSecundary;

    return Padding(
      padding: widget.padding,
      child: _ansorbingPointer(
        child: TextFormField(
          focusNode: widget.focusNode,
          maxLength: _maxLength(),
          textCapitalization: _textCapitalization(),
          controller: widget.controller,
          initialValue: widget.controller != null ? null : widget.initValue,
          obscureText: _obscureText,
          obscuringCharacter: '*',
          autocorrect: false,
          readOnly: widget.keyboardType == CustomTextInputType.dateTime,
          enableSuggestions: true,
          inputFormatters: _inputFormatters(),
          keyboardType: _textInputType(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color:  molochSecondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 : Theme.of(context).extension<CustomColors>()?.neutral30,
          ),
          onChanged: (value) {
            String? cleanedValue;
            currentText = value;
            if (widget.keyboardType == CustomTextInputType.money) {
              cleanedValue = value.replaceAll(',', '');
            }
            widget.onChanged?.call(cleanedValue ?? value);
          },
          onFieldSubmitted: (value) {
            widget.onFieldSubmitted?.call(value);
          },
          validator: widget.validator,
          decoration: _decorationEnable(),
        ),
      ),
    );
  }

  Widget inputDisable() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        enabled: false,
        initialValue: widget.initValue,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).extension<CustomColors>()?.neutral80,
        ),
        decoration: _decorationDisable(),
      ),
    );
  }

  Widget _ansorbingPointer({required Widget child}) {
    if (widget.keyboardType == CustomTextInputType.dateTime) {
      return GestureDetector(
        onTap: () {
          _selectdate();
        },
        child: AbsorbPointer(child: child),
      );
    }
    return child;
  }

  int? _maxLength() {
    switch (widget.keyboardType) {
      case CustomTextInputType.countryCode:
        return 3;
      case CustomTextInputType.postalcode:
        return 5;
      case CustomTextInputType.routingNumberAba:
        return 9;
      case CustomTextInputType.itin:
        return 9;
      case CustomTextInputType.ssn:
        return 9;
      case CustomTextInputType.curp:
        return 18;
      case CustomTextInputType.phone:
        return 10;
      case CustomTextInputType.rfc:
        return 13;
      case CustomTextInputType.accountNumber:
        return 17;
      default:
        return null;
    }
  }

  TextCapitalization _textCapitalization() {
    if (widget.keyboardType == CustomTextInputType.name) {
      return TextCapitalization.words;
    }
    if (widget.keyboardType == CustomTextInputType.curp) {
      return TextCapitalization.characters;
    }
    if (widget.keyboardType == CustomTextInputType.rfc) {
      return TextCapitalization.characters;
    }
    return TextCapitalization.none;
  }

  List<TextInputFormatter> _inputFormatters() {
    List<TextInputFormatter> list = [];

    if (widget.keyboardType == CustomTextInputType.text ||
        widget.keyboardType == CustomTextInputType.email ||
        widget.keyboardType == CustomTextInputType.name ||
        widget.keyboardType == CustomTextInputType.password ||
        widget.keyboardType == CustomTextInputType.curp ||
        widget.keyboardType == CustomTextInputType.password ||
        widget.keyboardType == CustomTextInputType.rfc ||
        widget.keyboardType == CustomTextInputType.routingNumberAba ||
        widget.keyboardType == CustomTextInputType.accountNumber) {
      list.add(LengthLimitingTextInputFormatter(130));
    }
    if (widget.keyboardType == CustomTextInputType.email ||
        widget.keyboardType == CustomTextInputType.password) {
      list.add(FilteringTextInputFormatter.deny(' '));
    }
    if (widget.keyboardType == CustomTextInputType.phone ||
        widget.keyboardType == CustomTextInputType.countryCode ||
        widget.keyboardType == CustomTextInputType.number ||
        widget.keyboardType == CustomTextInputType.postalcode ||
        widget.keyboardType == CustomTextInputType.routingNumberAba ||
        widget.keyboardType == CustomTextInputType.accountNumber) {
      list.add(FilteringTextInputFormatter.digitsOnly);
    }
    if (widget.keyboardType == CustomTextInputType.name) {
      list.add(
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z áéíóúÁÉÍÓÚñÑüÜ]')),
      );
    }
    if (widget.keyboardType == CustomTextInputType.curp ||
        widget.keyboardType == CustomTextInputType.rfc) {
      list.add(FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z]')));
    }
    if (widget.keyboardType == CustomTextInputType.dateTime) {
      list.add(FilteringTextInputFormatter.allow(RegExp('[0-9-]')));
    }
    if (widget.keyboardType == CustomTextInputType.money) {
      list.add(ThousandsSeparatorInputFormatter());
    }
    if (widget.keyboardType == CustomTextInputType.itin ||
        widget.keyboardType == CustomTextInputType.ssn) {
      list.add(FilteringTextInputFormatter.digitsOnly);
    }

    return list;
  }

  TextInputType _textInputType() {
    switch (widget.keyboardType) {
      case CustomTextInputType.text:
        return TextInputType.text;
      case CustomTextInputType.email:
        return TextInputType.emailAddress;
      case CustomTextInputType.number:
        return TextInputType.number;
      case CustomTextInputType.accountNumber:
        return TextInputType.number;
      case CustomTextInputType.routingNumberAba:
        return TextInputType.number;
      case CustomTextInputType.itin:
        return TextInputType.number;
      case CustomTextInputType.ssn:
        return TextInputType.number;
      case CustomTextInputType.dateTime:
        return TextInputType.datetime;
      case CustomTextInputType.phone:
        return TextInputType.phone;
      case CustomTextInputType.money:
        return const TextInputType.numberWithOptions(decimal: true);
      case CustomTextInputType.countryCode:
        return TextInputType.number;
      case CustomTextInputType.postalcode:
        return TextInputType.number;
      case CustomTextInputType.pin:
        return TextInputType.numberWithOptions(decimal: false, signed: false);
      default:
        return TextInputType.text;
    }
  }

  InputDecoration _decorationEnable() {
    final moloch_secondary = widget.type == CustomInputType.molochSecundary;
    return InputDecoration(
      // suffixText: widget.suffixText,
      helperText: widget.helperText != null ? widget.helperText! : null,
      helperStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color:  moloch_secondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 :Theme.of(context).extension<CustomColors>()?.neutral50,
      ),
      fillColor: moloch_secondary
              ? Colors.transparent
              : Theme.of(context).extension<CustomColors>()?.neutral100,
      filled: true,
      isCollapsed: false,
      suffixIcon: _suffixIcon(),
      prefixIcon: widget.prefixIcon,
      hintText: widget.hintText,
      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: moloch_secondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 :Theme.of(context).extension<CustomColors>()?.neutral50,
      ),
      label: Text(widget.labelText != null ? widget.labelText! : ''),
      labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color:moloch_secondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 : Theme.of(context).extension<CustomColors>()?.neutral50,
      ),
      floatingLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: moloch_secondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 : Theme.of(context).extension<CustomColors>()?.neutral50,
      ),
      focusedBorder: _focusedBorder(),
      enabledBorder: _enabledBorder(),
      focusedErrorBorder: _focusedErrorBorder(),
      errorBorder: _errorBorder(),
    );
  }

  InputBorder _focusedBorder() {
    final molochSecondary = widget.type == CustomInputType.molochSecundary;

    return widget.type == CustomInputType.sendMoney
        ? UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color:
                (molochSecondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 : Theme.of(context).extension<CustomColors>()?.primary) ??
                AppColors.secondary,
          ),
        )
        : OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            width: 1.5,
            color:
                (molochSecondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 : Theme.of(context).extension<CustomColors>()?.primary)??
                AppColors.primary,
          ),
        );
  }

  InputBorder _enabledBorder() {
    final molochSecondary = widget.type == CustomInputType.molochSecundary;

    return widget.type == CustomInputType.sendMoney
        ? UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color:
                (molochSecondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 : Theme.of(context).extension<CustomColors>()?.primary )??
                AppColors.secondary,
          ),
        )
        : OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            width: 1,
            color:
                (molochSecondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 : Theme.of(context).extension<CustomColors>()?.primary) ??
                AppColors.primary,
          ),
        );
  }

  InputBorder _focusedErrorBorder() {
    return widget.type == CustomInputType.sendMoney
        ? UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color:
                Theme.of(context).extension<CustomColors>()?.red ??
                AppColors.red,
          ),
        )
        : OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            width: 1,
            color:
                Theme.of(context).extension<CustomColors>()?.red ??
                AppColors.red,
          ),
        );
  }

  InputBorder _errorBorder() {
    return widget.type == CustomInputType.sendMoney
        ? UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color:
                Theme.of(context).extension<CustomColors>()?.red ??
                AppColors.red,
          ),
        )
        : OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            width: 1,
            color:
                Theme.of(context).extension<CustomColors>()?.red ??
                AppColors.red,
          ),
        );
  }

  InputDecoration _decorationDisable() {
    return InputDecoration(
      fillColor: Theme.of(context).extension<CustomColors>()?.neutral100,
      label: Text(widget.labelText != null ? widget.labelText! : ''),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).extension<CustomColors>()?.neutral50,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color:
              Theme.of(context).extension<CustomColors>()?.neutral50 ??
              AppColors.primary,
        ),
      ),
    );
  }

  Widget? _suffixIcon() {
    final moloch_secondary = widget.type == CustomInputType.molochSecundary;

    if (widget.suffixText != null) {
      return Container(
        padding: const EdgeInsets.only(top: 12, left: 8),
        child: Text(
          widget.suffixText!,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: moloch_secondary
              ? Theme.of(context).extension<CustomColors>()?.neutral100 :Theme.of(context).extension<CustomColors>()?.neutral50,
          ),
        ),
      );
    }
    if (widget.icon != null) {
      return IconButton(
        onPressed: widget.onIconPressed,
        icon: Icon(widget.icon),
      );
    } else if (widget.keyboardType == CustomTextInputType.password ||
        widget.obscureText) {
      return _eyeButton();
    } else if (widget.keyboardType == CustomTextInputType.dateTime) {
      return IconButton(
        onPressed: _selectdate,
        icon: const Icon(Icons.calendar_month),
      );
    } else if (widget.type == CustomInputType.sendMoney) {
      return IconButton(
        onPressed: widget.onIconPressed,
        icon: const Icon(Icons.cancel_outlined, color: AppColors.neutral50),
      );
    }
    return null;
  }

  Widget _eyeButton() {
        final moloch_secondary = widget.type == CustomInputType.molochSecundary;

    return InkWell(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: SvgPicture.asset(
            _obscureText ? 'assets/icons/eye.svg' : 'assets/icons/no_eye.svg',
            colorFilter: ColorFilter.mode(
              moloch_secondary
                ? Theme.of(context).extension<CustomColors>()?.neutral100 ?? AppColors.neutral100
                : Theme.of(context).extension<CustomColors>()?.neutral50 ?? AppColors.neutral50,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectdate() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: DateTime.now().subtract(const Duration(days: 100 * 365)),
      lastDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
    );

    if (fecha != null) {
      setState(() {
        widget.controller?.text = fecha.toString().split(" ")[0];
      });
      widget.onChanged?.call(fecha.toString());
    }
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    String newString = newValue.text.replaceAll(',', '');

    final RegExp regExp = RegExp(r'^\d*\.?\d{0,2}$');

    if (!regExp.hasMatch(newString)) {
      return oldValue;
    }

    if (newString.contains('.')) {
      List<String> parts = newString.split('.');
      String integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : '';

      integerPart = NumberFormat('#,###').format(int.parse(integerPart));

      newString = '$integerPart.${decimalPart}';
    } else {
      newString = NumberFormat('#,###').format(int.parse(newString));
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
