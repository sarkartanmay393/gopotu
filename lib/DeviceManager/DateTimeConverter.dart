import 'package:intl/intl.dart';

class DateTimeUtility {
  String parse({String? dateTime, String? returnFormat}) {
    DateTime dt = DateTime.parse(dateTime!);
    DateFormat dateFormat = DateFormat(returnFormat);
    String returnDT = dateFormat.format(dt.toLocal());
    return returnDT;
  }

  String parseTime({String? dateTime, String? returnFormat}) {
    DateFormat dtFor = DateFormat("HH:mm:ss");
    DateTime dt = dtFor.parse(dateTime!);
    DateFormat dateFormat = DateFormat(returnFormat);
    String returnDT = dateFormat.format(dt);
    return returnDT;
  }

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    return todayDate;
  }

  String getTimeFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    print(timeInMillis);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateTimeUtility()
        .parse(dateTime: date.toString(), returnFormat: "hh:mm a");
    return formattedDate;
  }

  String getDateFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateFormat.yMMMd().format(date);
    return formattedDate;
  }
}
