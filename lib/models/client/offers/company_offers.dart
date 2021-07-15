import 'package:equatable/equatable.dart';
import 'package:techtime/Models/client/companyProfile/company_data.dart';

class CompanyOffers extends Equatable {
  final int status;
  final CompanyData companyData;
  final List<CompanyOffer> companyOffers;

  const CompanyOffers({this.status, this.companyData, this.companyOffers});

  factory CompanyOffers.fromJson(Map<String, dynamic> json) => CompanyOffers(
        status: json['status'] as int,
        companyData: json['CompanyData'] == null
            ? null
            : CompanyData.fromJson(json['CompanyData'] as Map<String, dynamic>),
        companyOffers: (json['CompanyOffers'] as List<dynamic>)
            ?.map((e) => CompanyOffer.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'CompanyData': companyData?.toJson(),
        'CompanyOffers': companyOffers?.map((e) => e.toJson())?.toList(),
      };

  CompanyOffers copyWith({
    int status,
    CompanyData companyData,
    List<CompanyOffer> companyOffers,
  }) {
    return CompanyOffers(
      status: status ?? this.status,
      companyData: companyData ?? this.companyData,
      companyOffers: companyOffers ?? this.companyOffers,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, companyData, companyOffers];
}

class CompanyOffer extends Equatable {
  final int offerId;
  final dynamic offerName;
  final dynamic offerImage;
  final int totalServices;
  final bool available;
  final int price;
  final int fullTime;
  final int branchId;
  final List<Service> allServices;

  const CompanyOffer({
    this.offerId,
    this.offerName,
    this.offerImage,
    this.totalServices,
    this.available,
    this.price,
    this.fullTime,
    this.branchId,
    this.allServices,
  });

  factory CompanyOffer.fromJson(Map<String, dynamic> json) => CompanyOffer(
        offerId: json['OfferId'] as int,
        offerName: json['OfferName'],
        offerImage: json['OfferImage'],
        totalServices: json['TotalServices'] as int,
        available: json['Available'] as bool,
        price: json['Price'] as int,
        fullTime: json['FullTime'] as int,
        branchId: json['BranchID'] as int,
        allServices: (json['AllServices'] as List<dynamic>)
            ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
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
        'BranchID': branchId,
        'AllServices': allServices?.map((e) => e.toJson())?.toList(),
      };

  CompanyOffer copyWith({
    int offerId,
    dynamic offerName,
    dynamic offerImage,
    int totalServices,
    bool available,
    int price,
    int fullTime,
    int branchId,
    List<Service> allServices,
  }) {
    return CompanyOffer(
      offerId: offerId ?? this.offerId,
      offerName: offerName ?? this.offerName,
      offerImage: offerImage ?? this.offerImage,
      totalServices: totalServices ?? this.totalServices,
      available: available ?? this.available,
      price: price ?? this.price,
      fullTime: fullTime ?? this.fullTime,
      branchId: branchId ?? this.branchId,
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
      branchId,
      allServices,
    ];
  }
}

class Service extends Equatable {
  final int servicesId;
  final String servicesNameAr;
  final String servicesNameEn;
  final dynamic imageService;
  final int servicesPriceFrom;
  final int servicesPriceTo;
  final int servicesFullTime;
  final String servicesDescription;

  const Service({
    this.servicesId,
    this.servicesNameAr,
    this.servicesNameEn,
    this.imageService,
    this.servicesPriceFrom,
    this.servicesPriceTo,
    this.servicesFullTime,
    this.servicesDescription,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        servicesId: json['ServicesID'] as int,
        servicesNameAr: json['ServicesNameAR'] as String,
        servicesNameEn: json['ServicesNameEN'] as String,
        imageService: json['ImageService'],
        servicesPriceFrom: json['ServicesPriceFrom'] as int,
        servicesPriceTo: json['ServicesPriceTo'] as int,
        servicesFullTime: json['ServicesFullTime'] as int,
        servicesDescription: json['ServicesDescription'] as String,
      );

  Map<String, dynamic> toJson() => {
        'ServicesID': servicesId,
        'ServicesNameAR': servicesNameAr,
        'ServicesNameEN': servicesNameEn,
        'ImageService': imageService,
        'ServicesPriceFrom': servicesPriceFrom,
        'ServicesPriceTo': servicesPriceTo,
        'ServicesFullTime': servicesFullTime,
        'ServicesDescription': servicesDescription,
      };

  Service copyWith({
    int servicesId,
    String servicesNameAr,
    String servicesNameEn,
    dynamic imageService,
    int servicesPriceFrom,
    int servicesPriceTo,
    int servicesFullTime,
    String servicesDescription,
  }) {
    return Service(
      servicesId: servicesId ?? this.servicesId,
      servicesNameAr: servicesNameAr ?? this.servicesNameAr,
      servicesNameEn: servicesNameEn ?? this.servicesNameEn,
      imageService: imageService ?? this.imageService,
      servicesPriceFrom: servicesPriceFrom ?? this.servicesPriceFrom,
      servicesPriceTo: servicesPriceTo ?? this.servicesPriceTo,
      servicesFullTime: servicesFullTime ?? this.servicesFullTime,
      servicesDescription: servicesDescription ?? this.servicesDescription,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      servicesId,
      servicesNameAr,
      servicesNameEn,
      imageService,
      servicesPriceFrom,
      servicesPriceTo,
      servicesFullTime,
      servicesDescription,
    ];
  }
}
