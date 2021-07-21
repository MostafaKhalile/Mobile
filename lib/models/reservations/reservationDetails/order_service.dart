import 'package:equatable/equatable.dart';

class OrderService extends Equatable {
  final String servicesAr;
  final String servicesEn;
  final dynamic imageService;
  final int priceFrom;
  final int priceTo;
  final int fullTime;
  final String description;

  const OrderService({
    this.servicesAr,
    this.servicesEn,
    this.imageService,
    this.priceFrom,
    this.priceTo,
    this.fullTime,
    this.description,
  });

  factory OrderService.fromJson(Map<String, dynamic> json) => OrderService(
        servicesAr: json['ServicesAR'] as String,
        servicesEn: json['ServicesEN'] as String,
        imageService: json['ImageService'],
        priceFrom: json['PriceFrom'] as int,
        priceTo: json['PriceTo'] as int,
        fullTime: json['FullTime'] as int,
        description: json['Description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'ServicesAR': servicesAr,
        'ServicesEN': servicesEn,
        'ImageService': imageService,
        'PriceFrom': priceFrom,
        'PriceTo': priceTo,
        'FullTime': fullTime,
        'Description': description,
      };

  OrderService copyWith({
    String servicesAr,
    String servicesEn,
    dynamic imageService,
    int priceFrom,
    int priceTo,
    int fullTime,
    String description,
  }) {
    return OrderService(
      servicesAr: servicesAr ?? this.servicesAr,
      servicesEn: servicesEn ?? this.servicesEn,
      imageService: imageService ?? this.imageService,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      fullTime: fullTime ?? this.fullTime,
      description: description ?? this.description,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      servicesAr,
      servicesEn,
      imageService,
      priceFrom,
      priceTo,
      fullTime,
      description,
    ];
  }
}
