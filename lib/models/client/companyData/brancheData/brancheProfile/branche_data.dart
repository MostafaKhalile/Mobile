import 'package:equatable/equatable.dart';

class BrancheData extends Equatable {
  final int? companyId;
  final dynamic raty;
  final int? brancheId;
  final String? brancheName;
  final String? companyImage;
  final String? branchAddressAr;
  final String? branchAddressEn;
  final String? longitude;
  final String? latitude;
  final bool? favorite;
  final int? totalBranches;

  const BrancheData({
    this.companyId,
    this.raty,
    this.brancheId,
    this.brancheName,
    this.companyImage,
    this.branchAddressAr,
    this.branchAddressEn,
    this.longitude,
    this.latitude,
    this.favorite,
    this.totalBranches,
  });

  factory BrancheData.fromJson(Map<String, dynamic> json) {
    return BrancheData(
      companyId: json['CompanyID'] as int?,
      raty: json['raty'] as dynamic,
      brancheId: json['BrancheID'] as int?,
      brancheName: json['BrancheName'] as String?,
      companyImage: json['CompanyImage'] as String?,
      branchAddressAr: json['BranchAddressAR'] as String?,
      branchAddressEn: json['BranchAddressEN'] as String?,
      longitude: json['Longitude'] as String?,
      latitude: json['Latitude'] as String?,
      favorite: json['Favorite'] as bool?,
      totalBranches: json['TotalBranches'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CompanyID': companyId,
      'raty': raty,
      'BrancheID': brancheId,
      'BrancheName': brancheName,
      'CompanyImage': companyImage,
      'BranchAddressAR': branchAddressAr,
      'BranchAddressEN': branchAddressEn,
      'Longitude': longitude,
      'Latitude': latitude,
      'Favorite': favorite,
      'TotalBranches': totalBranches,
    };
  }

  BrancheData copyWith({
    int? companyId,
    int? raty,
    int? brancheId,
    String? brancheName,
    String? companyImage,
    String? branchAddressAr,
    String? branchAddressEn,
    String? longitude,
    String? latitude,
    bool? favorite,
    int? totalBranches,
  }) {
    return BrancheData(
      companyId: companyId ?? this.companyId,
      raty: raty ?? this.raty,
      brancheId: brancheId ?? this.brancheId,
      brancheName: brancheName ?? this.brancheName,
      companyImage: companyImage ?? this.companyImage,
      branchAddressAr: branchAddressAr ?? this.branchAddressAr,
      branchAddressEn: branchAddressEn ?? this.branchAddressEn,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      favorite: favorite ?? this.favorite,
      totalBranches: totalBranches ?? this.totalBranches,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      companyId,
      raty,
      brancheId,
      brancheName,
      companyImage,
      branchAddressAr,
      branchAddressEn,
      longitude,
      latitude,
      favorite,
      totalBranches,
    ];
  }
}
