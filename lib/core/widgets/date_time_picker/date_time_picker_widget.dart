import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mock_api_case_ersen_kocak/core/app/localization/localization_keys_constants.dart';

import 'package:logger/logger.dart';

import '../../app/constants/constants.dart';

class CustomDateTimePickerWidget extends StatefulWidget {
  CustomDateTimePickerWidget(
      {Key? key,
      this.labelText,
      this.onChanged,
      this.validator,
      this.hintText,
      this.readOnly,
      this.nextDate = true,
      this.weekend = false,
      this.onSaved,
      this.initialValue,
      this.wantKeepAlive,
      this.controller,
      this.dateTimePickerType,
      this.isWithHours = false})
      : super(key: key);

  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final bool? readOnly;
  final bool? validator;
  final bool? nextDate;
  final bool? weekend;
  final bool isWithHours;
  final DateTimePickerType? dateTimePickerType;
  bool? wantKeepAlive;
  TextEditingController? controller;

  @override
  State<CustomDateTimePickerWidget> createState() =>
      _CustomDateTimePickerWidgetState();
}

class _CustomDateTimePickerWidgetState extends State<CustomDateTimePickerWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: ksecondaryColor,
          onPrimary: Colors.white,
          onSurface: kprimaryColor,
        ),
      ),
      child: DateTimePicker(
        controller: widget.controller,
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
          fillColor: ksecondaryColor,
          focusColor: ksecondaryColor,
          iconColor: ksecondaryColor,
          hoverColor: ksecondaryColor,
          prefixIconColor: ksecondaryColor,
          suffixIconColor: ksecondaryColor,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.red, fontSize: 34),
          labelStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: ksecondaryColor),
          labelText: widget.labelText,
          hintText: widget.hintText ?? LocalizationKeys.CHOOSE.tr(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: const Icon(
            Icons.event,
            color: ksecondaryColor,
          ),
          // suffixIcon: IconButton(
          //   icon: Icon(Icons.close),
          //   color: ksecondaryColor,
          //   onPressed: () {},
          // ),
        ),
        type: widget.dateTimePickerType ?? DateTimePickerType.date,
        dateMask: widget.isWithHours ? 'dd/MM/yyyy HH:mm:ss' : 'dd/MM/yyyy',
        cursorColor: ksecondaryColor,

        // initialValue: DateTime.now().toString(),
        readOnly: widget.readOnly ?? false,
        firstDate: DateTime(1900),

        lastDate: DateTime(2100),

        selectableDayPredicate: (date) {
          if (widget.weekend == false) {
            if (date.weekday == 6 || date.weekday == 7) {
              return false;
            }
          }
          if (widget.nextDate == false) {
            if (date.day > DateTime.now().day &&
                date.month >= DateTime.now().month) {
              return false;
            }
          }

          return true;
        },
        onSaved: widget.onSaved,
        enableInteractiveSelection: false,
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        validator: (value) {
          if (widget.validator == true) {
            if (value == null || value.isEmpty)
              return LocalizationKeys.REQUIRED.tr();
            return null;
          }
          return null;
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive ?? true;
}
