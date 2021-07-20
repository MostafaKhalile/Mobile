import 'package:equatable/equatable.dart';

class CompanyDataOffer extends Equatable {
  final int companyId;
  final String companyName;
  final String companyImage;
  final String companyCoverImage;
  final String categoryAr;
  final String categoryEn;
  final int companyOffers;

  const CompanyDataOffer({
    this.companyId,
    this.companyName,
    this.companyImage,
    this.companyCoverImage,
    this.categoryAr,
    this.categoryEn,
    this.companyOffers,
  });

  factory CompanyDataOffer.fromJson(Map<String, dynamic> json) =>
      CompanyDataOffer(
        companyId: json['CompanyID'] as int,
        companyName: json['CompanyName'] as String,
        companyImage: json['CompanyImage'] as String,
        companyCoverImage: json['CompanyCoverImage'] as String,
        categoryAr: json['CategoryAR'] as String,
        categoryEn: json['CategoryEN'] as String,
        companyOffers: json['CompanyOffers'] as int,
      );

  Map<String, dynamic> toJson() => {
        'CompanyID': companyId,
        'CompanyName': companyName,
        'CompanyImage': companyImage,
        'CompanyCoverImage': companyCoverImage,
        'CategoryAR': categoryAr,
        'CategoryEN': categoryEn,
        'CompanyOffers': companyOffers,
      };

  CompanyDataOffer copyWith({
    int companyId,
    String companyName,
    String companyImage,
    String companyCoverImage,
    String categoryAr,
    String categoryEn,
    int companyOffers,
  }) {
    return CompanyDataOffer(
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyImage: companyImage ?? this.companyImage,
      companyCoverImage: companyCoverImage ?? this.companyCoverImage,
      categoryAr: categoryAr ?? this.categoryAr,
      categoryEn: categoryEn ?? this.categoryEn,
      companyOffers: companyOffers ?? companyOffers,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      companyId,
      companyName,
      companyImage,
      companyCoverImage,
      categoryAr,
      categoryEn,
      companyOffers,
    ];
  }
}
