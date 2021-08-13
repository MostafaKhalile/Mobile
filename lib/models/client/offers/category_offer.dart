import 'package:equatable/equatable.dart';

class CategoryOffer extends Equatable {
  final int? categoryId;
  final String? categoryAr;
  final String? categoryEn;
  final String? image;
  final int? offers;

  const CategoryOffer({
    this.categoryId,
    this.categoryAr,
    this.categoryEn,
    this.image,
    this.offers,
  });

  factory CategoryOffer.fromJson(Map<String, dynamic> json) => CategoryOffer(
        categoryId: json['CategoryID'] as int?,
        categoryAr: json['CategoryAR'] as String?,
        categoryEn: json['CategoryEN'] as String?,
        image: json['Image'] as String?,
        offers: json['Offers'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'CategoryID': categoryId,
        'CategoryAR': categoryAr,
        'CategoryEN': categoryEn,
        'Image': image,
        'Offers': offers,
      };

  CategoryOffer copyWith({
    int? categoryId,
    String? categoryAr,
    String? categoryEn,
    String? image,
    int? offers,
  }) {
    return CategoryOffer(
      categoryId: categoryId ?? this.categoryId,
      categoryAr: categoryAr ?? this.categoryAr,
      categoryEn: categoryEn ?? this.categoryEn,
      image: image ?? this.image,
      offers: offers ?? this.offers,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      categoryId,
      categoryAr,
      categoryEn,
      image,
      offers,
    ];
  }
}
