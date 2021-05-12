import 'company_branches.dart';
import 'company_data.dart';

class CompanyProfile {
  int status;
  CompanyData companyData;
  List<CompanyBranches> companyBranches;

  CompanyProfile({this.status, this.companyData, this.companyBranches});

  CompanyProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    companyData = json['CompanyData'] != null
        ? new CompanyData.fromJson(json['CompanyData'])
        : null;
    if (json['CompanyBranches'] != null) {
      companyBranches = [];
      json['CompanyBranches'].forEach((v) {
        companyBranches.add(new CompanyBranches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.companyData != null) {
      data['CompanyData'] = this.companyData.toJson();
    }
    if (this.companyBranches != null) {
      data['CompanyBranches'] =
          this.companyBranches.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
