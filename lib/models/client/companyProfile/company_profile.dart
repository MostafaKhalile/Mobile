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
    status = json['status'] as int;
    companyData = json['CompanyData'] != null
        ? CompanyData.fromJson(json['CompanyData'] as Map<String, dynamic>)
        : null;
    if (json['CompanyBranches'] != null) {
      companyBranches = [];
      json['CompanyBranches'].forEach((v) {
        companyBranches.add(CompanyBranche.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['CompanyServices'] != null) {
      companyServices = [];
      json['CompanyServices'].forEach((v) {
        companyServices.add(CompanyService.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['CompanyOffers'] != null) {
      companyOffers = [];
      json['CompanyOffers'].forEach((v) {
        companyOffers.add(CompanyOffer.fromJson(v as Map<String, dynamic>));
      });
    }
    companyReviews = json['CompanyReviews'] != null
        ? CompanyReviews.fromJson(
            json['CompanyReviews'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (companyData != null) {
      data['CompanyData'] = companyData.toJson();
    }
    if (companyBranches != null) {
      data['CompanyBranches'] = companyBranches.map((v) => v.toJson()).toList();
    }
    if (companyServices != null) {
      data['CompanyServices'] = companyServices.map((v) => v.toJson()).toList();
    }
    if (companyOffers != null) {
      data['CompanyOffers'] = companyOffers.map((v) => v.toJson()).toList();
    }
    if (companyReviews != null) {
      data['CompanyReviews'] = companyReviews.toJson();
    }
    return data;
  }
}
