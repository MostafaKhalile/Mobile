import 'package:equatable/equatable.dart';

import 'branche_data.dart';
import 'branche_images.dart';

class BrancheProfile extends Equatable {
  final int? status;
  final BrancheData? brancheData;
  final List<BrancheImage?>? brancheImages;

  const BrancheProfile({
    this.status,
    this.brancheData,
    this.brancheImages,
  });

  factory BrancheProfile.fromJson(Map<String, dynamic> json) {
    return BrancheProfile(
      status: json['status'] as int?,
      brancheData: json['BrancheData'] == null
          ? null
          : BrancheData.fromJson(json['BrancheData'] as Map<String, dynamic>),
      brancheImages: (json['BrancheImages'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BrancheImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'BrancheData': brancheData?.toJson(),
      'BrancheImages': brancheImages?.map((e) => e?.toJson()).toList(),
    };
  }

  BrancheProfile copyWith({
    int? status,
    BrancheData? brancheData,
    List<BrancheImage>? brancheImages,
  }) {
    return BrancheProfile(
      status: status ?? this.status,
      brancheData: brancheData ?? this.brancheData,
      brancheImages: brancheImages ?? this.brancheImages,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, brancheData, brancheImages];
}
