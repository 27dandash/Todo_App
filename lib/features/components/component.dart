import 'package:flutter/material.dart';

const Color white = Colors.white;
const Color darkBlue = Color(0xFF192882);  //Colors.white
const Color blue = Color(0xFF8aaae3);
const Color lightBlue = Color(0xFFbddbff);
const Color black = Color(0xFF000000);
const Color lightBlack = Colors.black54;
Color? gray = Colors.grey[600];

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? labelText;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final String? hintText;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? cursorColor;
  final double radius;
  final double? height;
  final int? maxLines;
  final double horizontalPadding;
  final InputBorder? inputBorder;
  final InputBorder? inputEnabledBorder;
  final InputBorder? inputFocusedBorder;
  final InputBorder? inputDisabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final AlignmentGeometry? containerAlignment;
  final BoxConstraints? suffixIconConstraints;
  final bool readOnly;
  final int? maxLength;
  final int? errorMaxLines;
  final TextDirection? textDirection;
  final TextAlign textAlign;

  const DefaultFormField(
      {Key? key,
      required this.controller,
      this.validator,
      this.onTap,
      this.labelText,
      required this.keyboardType,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onChanged,
      this.obscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.initialValue,
      this.hintText,
      this.backgroundColor,
      this.height,
      this.radius = 30.0,
      this.maxLines,
      this.enabled = true,
      this.inputBorder =
          const OutlineInputBorder(borderSide: BorderSide(width: 1)),
      this.inputEnabledBorder,
      this.inputFocusedBorder,
      this.inputDisabledBorder,
      this.horizontalPadding = 0,
      this.textColor,
      this.labelColor = lightBlue,
      this.contentPadding,
      this.containerAlignment,
      this.suffixText,
      this.suffixTextStyle,
      this.suffixIconConstraints,
      this.readOnly = false,
      this.cursorColor,
      this.maxLength,
      this.errorMaxLines = 2,
      this.textDirection = TextDirection.ltr,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: containerAlignment,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
      child: TextFormField(
        maxLength: maxLength,
        readOnly: readOnly,
        cursorColor: cursorColor,
        enabled: enabled,
        textAlignVertical: TextAlignVertical.center,
        textAlign: textAlign,
        maxLines: maxLines,
        textDirection: textDirection,
        initialValue: initialValue,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onTap: onTap,
        obscureText: obscureText,
        style: TextStyle(
          color: textColor,
        ),
        decoration: InputDecoration(
          counterText: '',
          suffixStyle: suffixTextStyle,
          suffixText: suffixText,
          errorMaxLines: errorMaxLines,
          contentPadding: contentPadding,
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIconConstraints: suffixIconConstraints,
          labelStyle: Theme.of(context).textTheme.caption!.copyWith(
                color: labelColor,
              ),
          labelText: labelText,
          border: inputBorder,
          enabledBorder: inputEnabledBorder,
          disabledBorder: inputDisabledBorder,
          focusedBorder: inputFocusedBorder,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          hintTextDirection: TextDirection.ltr,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}


class DefaultText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color color;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final TextDecoration? textDecoration;

  const DefaultText({
    Key? key,
    required this.text,
    this.maxLines,
    this.color = black,
    this.textStyle,
    this.textAlign,
    this.textScaleFactor,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.overflow = TextOverflow.ellipsis,
    this.textDecoration,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: textStyle != null
          ? textStyle!.copyWith(
              color: color, fontWeight: fontWeight, fontSize: fontSize)
          : TextStyle(
              color: color,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              fontSize: fontSize,
              decoration: textDecoration,
            ),
      maxLines: maxLines,
      overflow: overflow,

      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
    );
  }
}


Widget myDivider() => const Divider(
  color: Colors.grey,
  height:1,
  thickness: 1,

);
