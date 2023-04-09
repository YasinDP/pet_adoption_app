import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/helper_utils/page_routes.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<T?> showFullscreenDialogRoute<T>(BuildContext context, Widget child,
    {bool transparent = false}) async {
  return await Navigator.of(context).push<T>(
    PageRoutes.dialog<T>(child, duration: AppStyle().times.pageTransition),
  );
}

DateTime lastYear() {
  return DateTime.now().subtract(const Duration(days: 365));
}

DateTime currentMonth() {
  return DateTime.now().add(const Duration(days: 1));
}

List<DateTime> getMonthsBetween({
  required DateTime startDate,
  required DateTime endDate,
}) {
  List<DateTime> months = [];

  // Set the starting date to the first day of its month
  DateTime currentMonth = DateTime(startDate.year, startDate.month, 1);

  // Loop through each month until the end date is reached
  while (currentMonth.isBefore(endDate)) {
    months.add(currentMonth);

    // Move to the next month
    int nextMonth = currentMonth.month + 1;
    int nextYear = currentMonth.year;
    if (nextMonth > 12) {
      nextMonth = 1;
      nextYear++;
    }
    currentMonth = DateTime(nextYear, nextMonth, 1);
  }

  return months;
}

// Navigator function
Route createRoute(Widget child) {
  return MyCustomRoute(builder: (context) => child);
}

Future showToast(String message, {bool shortToast = true}) async {
  if (!kIsWeb) {
    await Fluttertoast.cancel();
  }
  Fluttertoast.showToast(
      msg: message,
      toastLength:
          shortToast && !kIsWeb ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG);
}
