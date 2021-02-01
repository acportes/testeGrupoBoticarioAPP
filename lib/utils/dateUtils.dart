
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateUtils{

  static String getDateTimeNowString() {
    initializeDateFormatting("pt_BR", null);
    Intl.defaultLocale = 'pt_BR';

    DateTime dataTime = DateTime.now();

    var dateFormated = DateFormat("DD/MM/yyyy HH:MM","pt_BR");
    dateFormated.format(dataTime);

    return  dateFormated.format(dataTime);
  }

}