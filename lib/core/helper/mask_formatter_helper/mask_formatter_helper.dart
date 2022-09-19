import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatterHelper {
  var maskPhoneFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}
