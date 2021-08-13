import 'package:equatable/equatable.dart';

class AllServices extends Equatable {
  final int? servicesId;
  final String? servicesNameAr;
  final String? servicesNameEn;
  final dynamic imageService;
  final int? servicesPriceFrom;
  final int? servicesPriceTo;
  final int? servicesFullTime;
  final String? servicesDescription;

  const AllServices({
    this.servicesId,
    this.servicesNameAr,
    this.servicesNameEn,
    this.imageService,
    this.servicesPriceFrom,
    this.servicesPriceTo,
    this.servicesFullTime,
    this.servicesDescription,
  });

  factory AllServices.fromJson(Map<String, dynamic> json) => AllServices(
        servicesId: json['ServicesID'] as int?,
        servicesNameAr: json['ServicesNameAR'] as String?,
        servicesNameEn: json['ServicesNameEN'] as String?,
        imageService: json['ImageService'],
        servicesPriceFrom: json['ServicesPriceFrom'] as int?,
        servicesPriceTo: json['ServicesPriceTo'] as int?,
        servicesFullTime: json['ServicesFullTime'] as int?,
        servicesDescription: json['ServicesDescription'] as String?,
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

  AllServices copyWith({
    int? servicesId,
    String? servicesNameAr,
    String? servicesNameEn,
    dynamic imageService,
    int? servicesPriceFrom,
    int? servicesPriceTo,
    int? servicesFullTime,
    String? servicesDescription,
  }) {
    return AllServices(
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
  List<Object?> get props {
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
