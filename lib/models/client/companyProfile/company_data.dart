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
    raty = json['raty'];
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    companyImage = json['CompanyImage'];
    companyCoverImage = json['CompanyCoverImage'];
    categoryAR = json['CategoryAR'];
    categoryEN = json['CategoryEN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raty'] = this.raty;
    data['CompanyID'] = this.companyID;
    data['CompanyName'] = this.companyName;
    data['CompanyImage'] = this.companyImage;
    data['CompanyCoverImage'] = this.companyCoverImage;
    data['CategoryAR'] = this.categoryAR;
    data['CategoryEN'] = this.categoryEN;
    return data;
  }
}
