class VisaTrackingModel {
  final String type;
  final String status;
  final String country;
  final String appliedDate;
  final String feeStatus;
  final int currentStep;

  VisaTrackingModel({
    required this.type,
    required this.status,
    required this.country,
    required this.appliedDate,
    required this.feeStatus,
    required this.currentStep,
  });
}
