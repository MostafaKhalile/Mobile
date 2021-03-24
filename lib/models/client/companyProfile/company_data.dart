// import 'package:equatable/equatable.dart';

// class CompanyData extends Equatable {
//   final double raty;
//   final int companyId;
//   final String companyName;
//   final String companyImage;
//   final String companyCoverImage;
//   final String categoryAr;
//   final String categoryEn;

//   const CompanyData({
//     this.raty,
//     this.companyId,
//     this.companyName,
//     this.companyImage,
//     this.companyCoverImage,
//     this.categoryAr,
//     this.categoryEn,
//   });

//   @override
//   String toString() {
//     return 'CompanyData(raty: $raty, companyId: $companyId, companyName: $companyName, companyImage: $companyImage, companyCoverImage: $companyCoverImage, categoryAr: $categoryAr, categoryEn: $categoryEn)';
//   }

//   factory CompanyData.fromJson(Map<String, dynamic> json) {
//     return CompanyData(
//       raty: json['raty'] as double,
//       companyId: json['CompanyID'] as int,
//       companyName: json['CompanyName'] as String,
//       companyImage: json['CompanyImage'] as String,
//       companyCoverImage: json['CompanyCoverImage'] as String,
//       categoryAr: json['CategoryAR'] as String,
//       categoryEn: json['CategoryEN'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'raty': raty,
//       'CompanyID': companyId,
//       'CompanyName': companyName,
//       'CompanyImage': companyImage,
//       'CompanyCoverImage': companyCoverImage,
//       'CategoryAR': categoryAr,
//       'CategoryEN': categoryEn,
//     };
//   }

//   CompanyData copyWith({
//     int raty,
//     int companyId,
//     String companyName,
//     String companyImage,
//     String companyCoverImage,
//     String categoryAr,
//     String categoryEn,
//   }) {
//     return CompanyData(
//       raty: raty ?? this.raty,
//       companyId: companyId ?? this.companyId,
//       companyName: companyName ?? this.companyName,
//       companyImage: companyImage ?? this.companyImage,
//       companyCoverImage: companyCoverImage ?? this.companyCoverImage,
//       categoryAr: categoryAr ?? this.categoryAr,
//       categoryEn: categoryEn ?? this.categoryEn,
//     );
//   }

//   @override
//   List<Object> get props {
//     return [
//       raty,
//       companyId,
//       companyName,
//       companyImage,
//       companyCoverImage,
//       categoryAr,
//       categoryEn,
//     ];
//   }
// }
