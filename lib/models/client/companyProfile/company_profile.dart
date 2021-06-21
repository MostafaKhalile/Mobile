import 'package:techtime/Models/client/companyProfile/company_service.dart';

import 'companyOffer/company_offer.dart';
import 'companyReviews/company_reviews.dart';
import 'company_branches.dart';
import 'company_data.dart';

class CompanyProfile {
  int status;
  CompanyData companyData;
  List<CompanyBranche> companyBranches;
  List<CompanyService> companyServices;
  List<CompanyOffer> companyOffers;
  CompanyReviews companyReviews;

  CompanyProfile(
      {this.status,
      this.companyData,
      this.companyBranches,
      this.companyServices});

  CompanyProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    companyData = json['CompanyData'] != null
        ? new CompanyData.fromJson(json['CompanyData'])
        : null;
    if (json['CompanyBranches'] != null) {
      companyBranches = [];
      json['CompanyBranches'].forEach((v) {
        companyBranches.add(new CompanyBranche.fromJson(v));
      });
    }
    if (json['CompanyServices'] != null) {
      companyServices = [];
      json['CompanyServices'].forEach((v) {
        companyServices.add(new CompanyService.fromJson(v));
      });
    }
    if (json['CompanyOffers'] != null) {
      companyOffers = [];
      json['CompanyOffers'].forEach((v) {
        companyOffers.add(new CompanyOffer.fromJson(v));
      });
    }
    companyReviews = json['CompanyReviews'] != null
        ? new CompanyReviews.fromJson(json['CompanyReviews'])
        : null;
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
    if (this.companyServices != null) {
      data['CompanyServices'] =
          this.companyServices.map((v) => v.toJson()).toList();
    }
    if (this.companyOffers != null) {
      data['CompanyOffers'] =
          this.companyOffers.map((v) => v.toJson()).toList();
    }
    if (this.companyReviews != null) {
      data['CompanyReviews'] = this.companyReviews.toJson();
    }
    return data;
  }
}
