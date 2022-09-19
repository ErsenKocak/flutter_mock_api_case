import 'package:date_time_format/date_time_format.dart';

class DateFormatterHelper {
  dateFormat(String? dateTime, {bool? includeHours = false}) {
    if (dateTime == null) {
      return '';
    }
    if (dateTime.contains('+')) dateTime = dateTime.split('+')[0];
    var result = DateTimeFormat.format(DateTime.tryParse(dateTime)!,
        format: includeHours != null
            ? !includeHours
                ? 'd/m/Y'
                : 'd/m/Y H:i:s'
            : 'd/m/Y');
    return result;
  }
}
