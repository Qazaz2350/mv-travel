class InvestmentData {
  double? amount;
  InvestmentType? investmentType;
  List<UploadedDocument> uploadedDocuments = [];

  InvestmentData({
    this.amount,
    this.investmentType,
    List<UploadedDocument>? uploadedDocuments,
  }) {
    this.uploadedDocuments = uploadedDocuments ?? [];
  }
}

class UploadedDocument {
  final String fileName;
  final String fileUrl;

  UploadedDocument({required this.fileName, required this.fileUrl});
}

enum InvestmentType {
  Stocks,
  Bonds,
  RealEstate,
  MutualFunds;

  String get displayName {
    switch (this) {
      case InvestmentType.Stocks:
        return 'Stocks';
      case InvestmentType.Bonds:
        return 'Bonds';
      case InvestmentType.RealEstate:
        return 'Real Estate';
      case InvestmentType.MutualFunds:
        return 'Mutual Funds';
    }
  }
}
