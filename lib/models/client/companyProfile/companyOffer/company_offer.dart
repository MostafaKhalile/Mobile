import 'package:equatable/equatable.dart';

import 'all_services.dart';

class CompanyOfferInfo extends Equatable {
  final int offerId;
  final String offerName;
  final String offerImage;
  final int totalServices;
  final bool available;
  final int price;
  final int fullTime;
  final List<AllServices> allServices;

  const CompanyOfferInfo({
    this.offerId,
    this.offerName,
    this.offerImage,
    this.totalServices,
    this.available,
    this.price,
    this.fullTime,
    this.allServices,
  });

  factory CompanyOfferInfo.fromJson(Map<String, dynamic> json) =>
      CompanyOfferInfo(
        offerId: json['OfferId'] as int,
        offerName: json['OfferName'] as String,
        offerImage: json['OfferImage'] as String,
        totalServices: json['TotalServices'] as int,
        available: json['Available'] as bool,
        price: json['Price'] as int,
        fullTime: json['FullTime'] as int,
        allServices: (json['AllServices'] as List<dynamic>)
            ?.map((e) => e == null
                ? null
                : AllServices.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

  Map<String, dynamic> toJson() => {
        'OfferId': offerId,
        'OfferName': offerName,
        'OfferImage': offerImage,
        'TotalServices': totalServices,
        'Available': available,
        'Price': price,
        'FullTime': fullTime,
        'AllServices': allServices?.map((e) => e?.toJson())?.toList(),
      };

  CompanyOfferInfo copyWith({
    int offerId,
    String offerName,
    String offerImage,
    int totalServices,
    bool available,
    int price,
    int fullTime,
    List<AllServices> allServices,
  }) {
    return CompanyOfferInfo(
      offerId: offerId ?? this.offerId,
      offerName: offerName ?? this.offerName,
      offerImage: offerImage ?? this.offerImage,
      totalServices: totalServices ?? this.totalServices,
      available: available ?? this.available,
      price: price ?? this.price,
      fullTime: fullTime ?? this.fullTime,
      allServices: allServices ?? this.allServices,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      offerId,
      offerName,
      offerImage,
      totalServices,
      available,
      price,
      fullTime,
      allServices,
    ];
  }
}
