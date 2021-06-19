import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final int companyId;
  final String companyName;
  final String categoryCityAr;
  final String categoryCityEn;
  final String categoryRegionAr;
  final String categoryRegionEn;
  final String logo;
  final String coverImage;
  final String categoryAr;
  final String categoryEn;
  final int totalServices;
  final dynamic raty;

  const Company({
    this.companyId,
    this.companyName,
    this.categoryCityAr,
    this.categoryCityEn,
    this.categoryRegionAr,
    this.categoryRegionEn,
    this.logo,
    this.coverImage,
    this.categoryAr,
    this.categoryEn,
    this.totalServices,
    this.raty,
  });

  @override
  String toString() {
    return 'Company(companyId: $companyId, companyName: $companyName, categoryCityAr: $categoryCityAr, categoryCityEn: $categoryCityEn, categoryRegionAr: $categoryRegionAr, categoryRegionEn: $categoryRegionEn, logo: $logo, coverImage: $coverImage, categoryAr: $categoryAr, categoryEn: $categoryEn, totalServices: $totalServices, raty: $raty)';
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['Company-ID'] as int,
      companyName: json['CompanyName'] as String,
      categoryCityAr: json['CategoryCityAR'] as String,
      categoryCityEn: json['CategoryCityEN'] as String,
      categoryRegionAr: json['CategoryRegionAR'] as String,
      categoryRegionEn: json['CategoryRegionEN'] as String,
      logo: json['Logo'] as String,
      coverImage: json['CoverImage'] as String,
      categoryAr: json['CategoryAR'] as String,
      categoryEn: json['CategoryEN'] as String,
      totalServices: json['TotalServices'] as int,
      raty: json['raty'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Company-ID': companyId,
      'CompanyName': companyName,
      'CategoryCityAR': categoryCityAr,
      'CategoryCityEN': categoryCityEn,
      'CategoryRegionAR': categoryRegionAr,
      'CategoryRegionEN': categoryRegionEn,
      'Logo': logo,
      'CoverImage': coverImage,
      'CategoryAR': categoryAr,
      'CategoryEN': categoryEn,
      'TotalServices': totalServices,
      'raty': raty,
    };
  }

  @override
  List<Object> get props {
    return [
      companyId,
      companyName,
      categoryCityAr,
      categoryCityEn,
      categoryRegionAr,
      categoryRegionEn,
      logo,
      coverImage,
      categoryAr,
      categoryEn,
      totalServices,
      raty,
    ];
  }
}
