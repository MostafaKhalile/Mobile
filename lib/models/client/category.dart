import 'package:flutter/foundation.dart';

@immutable
class Category {
  final int? categoryId;
  final String? categoryAr;
  final String? categoryEn;
  final String? image;

  const Category({
    this.categoryId,
    this.categoryAr,
    this.categoryEn,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['CategoryID'] as int?,
      categoryAr: json['CategoryAR'] as String?,
      categoryEn: json['CategoryEN'] as String?,
      image: json['Image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CategoryID': categoryId,
      'CategoryAR': categoryAr,
      'CategoryEN': categoryEn,
      'Image': image,
    };
  }
}
