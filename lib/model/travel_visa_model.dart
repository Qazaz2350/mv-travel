class TravelVisaModel {
  DateTime? startDate;
  DateTime? endDate;
  String? reason;
  String? estimatedBudget;

  TravelVisaModel({
    this.startDate,
    this.endDate,
    this.reason,
    this.estimatedBudget,
  });

  bool get isValid =>
      startDate != null &&
      endDate != null &&
      reason != null &&
      reason!.isNotEmpty &&
      estimatedBudget != null &&
      estimatedBudget!.isNotEmpty;
}
