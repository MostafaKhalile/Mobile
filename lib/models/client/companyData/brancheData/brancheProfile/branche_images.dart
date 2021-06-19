import 'package:equatable/equatable.dart';

class BrancheImage extends Equatable {
  final String image;

  const BrancheImage({this.image});

  factory BrancheImage.fromJson(Map<String, dynamic> json) {
    return BrancheImage(
      image: json['Image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Image': image,
    };
  }

  BrancheImage copyWith({
    String image,
  }) {
    return BrancheImage(
      image: image ?? this.image,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [image];
}
