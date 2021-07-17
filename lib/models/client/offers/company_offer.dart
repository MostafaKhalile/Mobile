import 'package:equatable/equatable.dart';

class CompanyOffer extends Equatable {
  final int companyId;
  final String companyName;
  final String companyImage;
  final String companyCoverImage;
  final String categoryAr;
  final String categoryEn;
  final int companyOffers;

  const CompanyOffer({
    this.companyId,
    this.companyName,
    this.companyImage,
    this.companyCoverImage,
    this.categoryAr,
    this.categoryEn,
    this.companyOffers,
  });

  factory CompanyOffer.fromJson(Map<String, dynamic> json) => CompanyOffer(
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

  CompanyOffer copyWith({
    int companyId,
    String companyName,
    String companyImage,
    String companyCoverImage,
    String categoryAr,
    String categoryEn,
    int companyOffers,
  }) {
    return CompanyOffer(
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyImage: companyImage ?? this.companyImage,
      companyCoverImage: companyCoverImage ?? this.companyCoverImage,
      categoryAr: categoryAr ?? this.categoryAr,
      categoryEn: categoryEn ?? this.categoryEn,
      companyOffers: companyOffers ?? this.companyOffers,
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
