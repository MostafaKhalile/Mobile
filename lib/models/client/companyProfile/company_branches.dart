import 'package:equatable/equatable.dart';

class CompanyBranche extends Equatable {
  final int brancheId;
  final String brancheName;
  final String branchAddressAr;
  final String branchAddressEn;
  final String image;

  const CompanyBranche({
    this.brancheId,
    this.brancheName,
    this.branchAddressAr,
    this.branchAddressEn,
    this.image,
  });

  @override
  String toString() {
    return 'CompanyBranches(brancheId: $brancheId, brancheName: $brancheName, branchAddressAr: $branchAddressAr, branchAddressEn: $branchAddressEn, image: $image)';
  }

  factory CompanyBranche.fromJson(Map<String, dynamic> json) {
    return CompanyBranche(
      brancheId: json['BrancheID'] as int,
      brancheName: json['BrancheName'] as String,
      branchAddressAr: json['BranchAddressAR'] as String,
      branchAddressEn: json['BranchAddressEN'] as String,
      image: json['Image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BrancheID': brancheId,
      'BrancheName': brancheName,
      'BranchAddressAR': branchAddressAr,
      'BranchAddressEN': branchAddressEn,
      'Image': image,
    };
  }

  CompanyBranche copyWith({
    int brancheId,
    String brancheName,
    String branchAddressAr,
    String branchAddressEn,
    String image,
  }) {
    return CompanyBranche(
      brancheId: brancheId ?? this.brancheId,
      brancheName: brancheName ?? this.brancheName,
      branchAddressAr: branchAddressAr ?? this.branchAddressAr,
      branchAddressEn: branchAddressEn ?? this.branchAddressEn,
      image: image ?? this.image,
    );
  }

  @override
  List<Object> get props {
    return [
      brancheId,
      brancheName,
      branchAddressAr,
      branchAddressEn,
      image,
    ];
  }
}
