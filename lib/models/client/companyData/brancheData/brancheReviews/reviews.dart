import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final dynamic image;
  final String? name;
  final bool? orderService;
  final int? totalServices;
  final int? totalOffers;
  final String? date;
  final dynamic raty;
  final String? comment;

  const Review({
    this.image,
    this.name,
    this.orderService,
    this.totalServices,
    this.totalOffers,
    this.date,
    this.raty,
    this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        image: json['Image'] as String?,
        name: json['Name'] as String?,
        orderService: json['OrderService'] as bool?,
        totalServices: json['TotalServices'] as int?,
        totalOffers: json['TotalOffers'] as int?,
        date: json['Date'] as String?,
        raty: json['raty'] as dynamic,
        comment: json['Comment'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Image': image as String?,
        'Name': name,
        'OrderService': orderService,
        'TotalServices': totalServices,
        'TotalOffers': totalOffers,
        'Date': date,
        'raty': raty,
        'Comment': comment,
      };

  Review copyWith({
    dynamic image,
    String? name,
    bool? orderService,
    int? totalServices,
    int? totalOffers,
    String? date,
    int? raty,
    String? comment,
  }) {
    return Review(
      image: image ?? this.image,
      name: name ?? this.name,
      orderService: orderService ?? this.orderService,
      totalServices: totalServices ?? this.totalServices,
      totalOffers: totalOffers ?? this.totalOffers,
      date: date ?? this.date,
      raty: raty ?? this.raty,
      comment: comment ?? this.comment,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      image,
      name,
      orderService,
      totalServices,
      totalOffers,
      date,
      raty,
      comment,
    ];
  }
}
