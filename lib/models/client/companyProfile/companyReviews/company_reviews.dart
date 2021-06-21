import 'package:equatable/equatable.dart';
import 'package:techtime/Models/client/companyData/brancheData/brancheReviews/reviews.dart';

class CompanyReviews extends Equatable {
  final int totalReviews;
  final dynamic publicRaty;
  final List<Review> companyReviews;

  const CompanyReviews({
    this.totalReviews,
    this.publicRaty,
    this.companyReviews,
  });

  factory CompanyReviews.fromJson(Map<String, dynamic> json) => CompanyReviews(
        totalReviews: json['TotalReviews'] as int,
        publicRaty: json['PublicRaty'] as dynamic,
        companyReviews: (json['CompanyReviews'] as List<dynamic>)
            ?.map((e) =>
                e == null ? null : Review.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

  Map<String, dynamic> toJson() => {
        'TotalReviews': totalReviews,
        'PublicRaty': publicRaty,
        'CompanyReviews': companyReviews?.map((e) => e?.toJson())?.toList(),
      };

  CompanyReviews copyWith({
    int totalReviews,
    int publicRaty,
    List<CompanyReviews> companyReviews,
  }) {
    return CompanyReviews(
      totalReviews: totalReviews ?? this.totalReviews,
      publicRaty: publicRaty ?? this.publicRaty,
      companyReviews: companyReviews ?? this.companyReviews,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [totalReviews, publicRaty, companyReviews];
}
