import 'package:equatable/equatable.dart';

class ClientProfile extends Equatable {
  final String image;
  final dynamic coverImage;
  final int raty;
  final dynamic typeCategoryAr;
  final dynamic typeCategoryEn;
  final String firstName;
  final String lastName;
  final String email;
  final int mobile;
  final String cityAr;
  final String cityEn;
  final String regionAr;
  final String regionEn;

  const ClientProfile({
    this.image,
    this.coverImage,
    this.raty,
    this.typeCategoryAr,
    this.typeCategoryEn,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.cityAr,
    this.cityEn,
    this.regionAr,
    this.regionEn,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      image: json['Image'] as String,
      coverImage: json['CoverImage'],
      raty: json['raty'] as int,
      typeCategoryAr: json['TypeCategoryAR'],
      typeCategoryEn: json['TypeCategoryEN'],
      firstName: json['First_name'] as String,
      lastName: json['Last_name'] as String,
      email: json['Email'] as String,
      mobile: json['Mobile'] as int,
      cityAr: json['CityAR'] as String,
      cityEn: json['CityEN'] as String,
      regionAr: json['RegionAR'] as String,
      regionEn: json['RegionEN'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'CoverImage': coverImage,
      'raty': raty,
      'TypeCategoryAR': typeCategoryAr,
      'TypeCategoryEN': typeCategoryEn,
      'First_name': firstName,
      'Last_name': lastName,
      'Email': email,
      'Mobile': mobile,
      'CityAR': cityAr,
      'CityEN': cityEn,
      'RegionAR': regionAr,
      'RegionEN': regionEn,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      image,
      coverImage,
      raty,
      typeCategoryAr,
      typeCategoryEn,
      firstName,
      lastName,
      email,
      mobile,
      cityAr,
      cityEn,
      regionAr,
      regionEn,
    ];
  }
}
