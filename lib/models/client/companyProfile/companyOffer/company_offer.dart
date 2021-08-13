import 'package:equatable/equatable.dart';

import 'all_services.dart';

class CompanyOfferInfo extends Equatable {
  final int? offerId;
  final String? offerName;
  final String? offerImage;
  final int? totalServices;
  final bool? available;
  final int? price;
  final int? fullTime;
  final int? branchId;

  final List<AllServices?>? allServices;

  const CompanyOfferInfo({
    this.branchId,
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
        offerId: json['OfferId'] as int?,
        offerName: json['OfferName'] as String?,
        offerImage: json['OfferImage'] as String?,
        totalServices: json['TotalServices'] as int?,
        available: json['Available'] as bool?,
        price: json['Price'] as int?,
        fullTime: json['FullTime'] as int?,
        branchId: json["BranchID"] as int?,
        allServices: (json['AllServices'] as List<dynamic>?)
            ?.map((e) => e == null
                ? null
                : AllServices.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'OfferId': offerId,
        'OfferName': offerName,
        'OfferImage': offerImage,
        'TotalServices': totalServices,
        'Available': available,
        'Price': price,
        'FullTime': fullTime,
        'BranchID': branchId,
        'AllServices': allServices?.map((e) => e?.toJson()).toList(),
      };

  CompanyOfferInfo copyWith({
    int? offerId,
    String? offerName,
    String? offerImage,
    int? totalServices,
    bool? available,
    int? price,
    int? fullTime,
    int? branchIdl,
    List<AllServices>? allServices,
  }) {
    return CompanyOfferInfo(
      offerId: offerId ?? this.offerId,
      offerName: offerName ?? this.offerName,
      offerImage: offerImage ?? this.offerImage,
      totalServices: totalServices ?? this.totalServices,
      available: available ?? this.available,
      price: price ?? this.price,
      fullTime: fullTime ?? this.fullTime,
      branchId: branchId ?? branchId,
      allServices: allServices ?? this.allServices,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      offerId,
      offerName,
      offerImage,
      totalServices,
      available,
      price,
      fullTime,
      branchId,
      allServices,
    ];
  }
}
