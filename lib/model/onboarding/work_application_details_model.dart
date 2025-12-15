// ============================================
// MODEL - WorkApplicationDetailsModel
// ============================================
class WorkApplicationDetailsModel {
  String jobTitle;
  String experience;
  bool hasJobOffer;
  String offerLetterFileName;
  String salary;

  WorkApplicationDetailsModel({
    this.jobTitle = "",
    this.experience = "",
    this.hasJobOffer = false,
    this.offerLetterFileName = "",
    this.salary = "",
  });
}
