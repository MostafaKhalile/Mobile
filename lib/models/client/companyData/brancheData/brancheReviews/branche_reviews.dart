import 'package:equatable/equatable.dart';

import 'reviews.dart';

class BrancheReviews extends Equatable {
  final int? status;
  final int? totalReviews;
  final dynamic publicRaty;
  final List<Review?>? reviews;

  const BrancheReviews({
    this.status,
    this.totalReviews,
    this.publicRaty,
    this.reviews,
  });

  factory BrancheReviews.fromJson(Map<String, dynamic> json) => BrancheReviews(
        status: json['status'] as int?,
        totalReviews: json['TotalReviews'] as int?,
        publicRaty: json['PublicRaty'] as dynamic,
        reviews: (json['Reviews'] as List<dynamic>?)
            ?.map((e) =>
                e == null ? null : Review.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'TotalReviews': totalReviews,
        'PublicRaty': publicRaty,
        'Reviews': reviews?.map((e) => e?.toJson()).toList(),
      };

  BrancheReviews copyWith({
    int? status,
    int? totalReviews,
    int? publicRaty,
    List<Review>? reviews,
  }) {
    return BrancheReviews(
      status: status ?? this.status,
      totalReviews: totalReviews ?? this.totalReviews,
      publicRaty: publicRaty ?? this.publicRaty,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, totalReviews, publicRaty, reviews];
}
