import 'package:flutter/foundation.dart';

@immutable
class Advertise {
  final bool? adNormal;
  final bool? adCompany;
  final bool? adBranch;
  final int? adId;
  final dynamic titleAr;
  final dynamic titleEn;
  final String? image;

  const Advertise({
    this.adNormal,
    this.adCompany,
    this.adBranch,
    this.adId,
    this.titleAr,
    this.titleEn,
    this.image,
  });

  factory Advertise.fromJson(Map<String, dynamic> json) {
    return Advertise(
      adNormal: json['Ad-Normal'] as bool?,
      adCompany: json['Ad-Company'] as bool?,
      adBranch: json['Ad-Branch'] as bool?,
      adId: json['Ad-ID'] as int?,
      titleAr: json['TitleAR'] as dynamic,
      titleEn: json['TitleEN'] as dynamic,
      image: json['Image'] as String?,
    );
  }
  @override
  String toString() {
    return 'Advertise( Ad-Normal: $adNormal,Ad-Company: $adCompany,Ad-Branch: $adBranch,Ad-ID: $adId,TitleAR: $titleAr,TitleEN: $titleEn,Image: $image,)';
  }

  Map<String, dynamic> toJson() {
    return {
      'Ad-Normal': adNormal,
      'Ad-Company': adCompany,
      'Ad-Branch': adBranch,
      'Ad-ID': adId,
      'TitleAR': titleAr,
      'TitleEN': titleEn,
      'Image': image,
    };
  }
}
