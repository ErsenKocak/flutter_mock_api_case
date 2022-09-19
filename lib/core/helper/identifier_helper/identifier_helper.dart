import 'package:logger/logger.dart';

class IdentifierHelper {
  bool identificationNumberControl(String? tcNo) {
    if (tcNo != null) {
      String tc = tcNo.toString();

      if (tc.length != 11 || (tc[0]) == '' || (tc[0]) == 0 || (tc[0]) == null) {
        return false;
      } else {
        var oddNumber = int.parse(tc[0]) +
            int.parse(tc[2]) +
            int.parse(tc[4]) +
            int.parse(tc[6]) +
            int.parse(tc[8]);

        var cift = int.parse(tc[1]) +
            int.parse(tc[3]) +
            int.parse(tc[5]) +
            int.parse(tc[7]);

        var tc10 = ((oddNumber * 7) - cift) % 10;
        var tc11 = ((oddNumber + cift + int.parse(tc[9])) % 10);

        if (tc10 == int.parse(tc[9]) && tc11 == int.parse(tc[10])) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
}
