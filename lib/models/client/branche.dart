class Branche {
  int? status;
  BrancheData? brancheData;
  List<BrancheImages>? brancheImages;

  Branche({this.status, this.brancheData, this.brancheImages});

  Branche.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    brancheData = json['BrancheData'] != null
        ? BrancheData.fromJson(json['BrancheData'] as Map<String, dynamic>)
        : null;
    if (json['BrancheImages'] != null) {
      brancheImages = <BrancheImages>[];
      json['BrancheImages'].forEach((v) {
        brancheImages!.add(BrancheImages.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (brancheData != null) {
      data['BrancheData'] = brancheData!.toJson();
    }
    if (brancheImages != null) {
      data['BrancheImages'] = brancheImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrancheData {
  int? companyID;
  double? raty;
  int? brancheID;
  String? brancheName;
  String? companyImage;
  String? branchAddressAR;
  String? branchAddressEN;
  String? longitude;
  String? latitude;
  bool? favorite;
  int? totalBranches;

  BrancheData(
      {this.companyID,
      this.raty,
      this.brancheID,
      this.brancheName,
      this.companyImage,
      this.branchAddressAR,
      this.branchAddressEN,
      this.longitude,
      this.latitude,
      this.favorite,
      this.totalBranches});

  BrancheData.fromJson(Map<String, dynamic> json) {
    companyID = json['CompanyID'] as int?;
    raty = json['raty'] as double?;
    brancheID = json['BrancheID'] as int?;
    brancheName = json['BrancheName'] as String?;
    companyImage = json['CompanyImage'] as String?;
    branchAddressAR = json['BranchAddressAR'] as String?;
    branchAddressEN = json['BranchAddressEN'] as String?;
    longitude = json['Longitude'] as String?;
    latitude = json['Latitude'] as String?;
    favorite = json['Favorite'] as bool?;
    totalBranches = json['TotalBranches'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyID'] = companyID;
    data['raty'] = raty;
    data['BrancheID'] = brancheID;
    data['BrancheName'] = brancheName;
    data['CompanyImage'] = companyImage;
    data['BranchAddressAR'] = branchAddressAR;
    data['BranchAddressEN'] = branchAddressEN;
    data['Longitude'] = longitude;
    data['Latitude'] = latitude;
    data['Favorite'] = favorite;
    data['TotalBranches'] = totalBranches;
    return data;
  }
}

class BrancheImages {
  String? image;

  BrancheImages({this.image});

  BrancheImages.fromJson(Map<String, dynamic> json) {
    image = json['Image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Image'] = image;
    return data;
  }
}
