import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/app/localization/localization_keys_constants.dart';

import '../../app/constants/constants.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  void Function(String)? onChanged;
  void Function(String?)? onSaved;
  bool? validator;
  final Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final bool? readOnly;
  final bool? enabled;
  final TextInputType? keyboardType;
  final String? initialValue;
  TextEditingController? controller;
  TextCapitalization? textCapitalization;
  bool? wantKeepAlive;
  int? maxLines;
  int? maxLength;
  String? errorText;
  List<TextInputFormatter>? customInputFormatters;
  CustomTextFormFieldWidget(
      {Key? key,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.prefix,
      this.prefixText,
      this.prefixStyle,
      this.prefixIcon,
      this.prefixIconConstraints,
      this.onChanged,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.readOnly,
      this.keyboardType,
      this.controller,
      this.initialValue,
      this.textCapitalization,
      this.wantKeepAlive,
      this.enabled,
      this.maxLines = 1,
      this.maxLength,
      this.errorText,
      this.customInputFormatters})
      : super(key: key);

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.wantKeepAlive == true) {
      super.build(context);
    }

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      autofocus: false,
      inputFormatters: widget.customInputFormatters,
      onSaved: widget.onSaved,
      maxLength: widget.maxLength,
      textInputAction: TextInputAction.next,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly ?? false,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      textCapitalization:
          widget.textCapitalization ?? TextCapitalization.sentences,
      validator: (value) {
        if (widget.validator != null && widget.validator == true) {
          if (value!.isEmpty) {
            return LocalizationKeys.REQUIRED.tr();
          }
        }
        return null;
      },
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ksecondaryColor),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          errorText: widget.errorText,
          errorStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.red, fontSize: 12),
          labelText: widget.labelText,
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: widget.suffixIcon,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints: widget.prefixIconConstraints,
          prefixText: widget.prefixText,
          prefixStyle: widget.prefixStyle),
    );
  }

  @override
  bool get wantKeepAlive =>
      widget.wantKeepAlive != null ? widget.wantKeepAlive! : true;
}
