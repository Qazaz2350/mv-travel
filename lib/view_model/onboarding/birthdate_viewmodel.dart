import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvtravel/utilis/colors.dart';

class BirthDateViewModel extends ChangeNotifier {
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: AppColors.blue1)),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text = DateFormat('MM / dd / yyyy').format(picked);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }
}
