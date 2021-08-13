import 'package:equatable/equatable.dart';

class CompanyService extends Equatable {
  final String? image;
  final dynamic servicesId;
  final String? nameServicesAr;
  final String? nameServicesEn;
  final dynamic fullTime;
  final dynamic serviceTimeM;
  final dynamic serviceTimeH;
  final dynamic serviceTimeD;
  final dynamic priceFrom;
  final dynamic priceTo;
  final String? description;
  final dynamic raty;

  const CompanyService({
    this.image,
    this.servicesId,
    this.nameServicesAr,
    this.nameServicesEn,
    this.fullTime,
    this.serviceTimeM,
    this.serviceTimeH,
    this.serviceTimeD,
    this.priceFrom,
    this.priceTo,
    this.description,
    this.raty,
  });

  factory CompanyService.fromJson(Map<String, dynamic> json) {
    return CompanyService(
      image: json['Image'] as String?,
      servicesId: json['ServicesID'] as dynamic,
      nameServicesAr: json['NameServicesAR'] as String?,
      nameServicesEn: json['NameServicesEN'] as String?,
      fullTime: json['FullTime'] as dynamic,
      serviceTimeM: json['ServiceTimeM'] as dynamic,
      serviceTimeH: json['ServiceTimeH'] as dynamic,
      serviceTimeD: json['ServiceTimeD'] as dynamic,
      priceFrom: json['PriceFrom'] as dynamic,
      priceTo: json['PriceTo'] as dynamic,
      description: json['Description'] as String?,
      raty: json['raty'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'ServicesID': servicesId,
      'NameServicesAR': nameServicesAr,
      'NameServicesEN': nameServicesEn,
      'FullTime': fullTime,
      'ServiceTimeM': serviceTimeM,
      'ServiceTimeH': serviceTimeH,
      'ServiceTimeD': serviceTimeD,
      'PriceFrom': priceFrom,
      'PriceTo': priceTo,
      'Description': description,
      'raty': raty,
    };
  }

  CompanyService copyWith({
    String? image,
    dynamic servicesId,
    String? nameServicesAr,
    String? nameServicesEn,
    dynamic fullTime,
    dynamic serviceTimeM,
    dynamic serviceTimeH,
    dynamic serviceTimeD,
    dynamic priceFrom,
    dynamic priceTo,
    String? description,
    dynamic raty,
  }) {
    return CompanyService(
      image: image ?? this.image,
      servicesId: servicesId ?? this.servicesId,
      nameServicesAr: nameServicesAr ?? this.nameServicesAr,
      nameServicesEn: nameServicesEn ?? this.nameServicesEn,
      fullTime: fullTime ?? this.fullTime,
      serviceTimeM: serviceTimeM ?? this.serviceTimeM,
      serviceTimeH: serviceTimeH ?? this.serviceTimeH,
      serviceTimeD: serviceTimeD ?? this.serviceTimeD,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      description: description ?? this.description,
      raty: raty ?? this.raty,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      image,
      servicesId,
      nameServicesAr,
      nameServicesEn,
      fullTime,
      serviceTimeM,
      serviceTimeH,
      serviceTimeD,
      priceFrom,
      priceTo,
      description,
      raty,
    ];
  }
}
