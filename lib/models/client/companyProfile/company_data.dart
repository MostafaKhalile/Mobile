class CompanyData {
  double raty;
  int companyID;
  String companyName;
  String companyImage;
  String companyCoverImage;
  String categoryAR;
  String categoryEN;

  CompanyData(
      {this.raty,
      this.companyID,
      this.companyName,
      this.companyImage,
      this.companyCoverImage,
      this.categoryAR,
      this.categoryEN});

  CompanyData.fromJson(Map<String, dynamic> json) {
    raty = json['raty'] as double;
    companyID = json['CompanyID'] as int;
    companyName = json['CompanyName'] as String;
    companyImage = json['CompanyImage'] as String;
    companyCoverImage = json['CompanyCoverImage'] as String;
    categoryAR = json['CategoryAR'] as String;
    categoryEN = json['CategoryEN'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['raty'] = raty;
    data['CompanyID'] = companyID;
    data['CompanyName'] = companyName;
    data['CompanyImage'] = companyImage;
    data['CompanyCoverImage'] = companyCoverImage;
    data['CategoryAR'] = categoryAR;
    data['CategoryEN'] = categoryEN;
    return data;
  }
}
