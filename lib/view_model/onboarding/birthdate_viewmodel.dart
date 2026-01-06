import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvtravel/utilis/colors.dart';

class BirthDateViewModel extends ChangeNotifier {
  DateTime? selectedDate;

  /// UI display ke liye
  final TextEditingController dateController = TextEditingController();

  /// 🔥 Firebase ke liye (TIMESTAMP)
  int? birthDateTimestamp;

  /// ✅ Validation: check if date is selected
  bool get isValid => selectedDate != null;

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.blue1),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate = picked;

      /// UI ke liye readable date
      dateController.text = DateFormat('MM / dd / yyyy').format(picked);

      /// 🔥 Firebase ke liye timestamp
      birthDateTimestamp = picked.millisecondsSinceEpoch;

      notifyListeners();
    }
  }

  /// Firebase ko send karne ke liye
  Map<String, dynamic> toMap() {
    return {
      'birthDate': birthDateTimestamp, // ✅ timestamp
    };
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }
}
