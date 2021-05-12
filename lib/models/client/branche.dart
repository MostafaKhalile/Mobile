class Branche {
  int status;
  BrancheData brancheData;
  List<BrancheImages> brancheImages;

  Branche({this.status, this.brancheData, this.brancheImages});

  Branche.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    brancheData = json['BrancheData'] != null
        ? BrancheData.fromJson(json['BrancheData'])
        : null;
    if (json['BrancheImages'] != null) {
      brancheImages = <BrancheImages>[];
      json['BrancheImages'].forEach((v) {
        brancheImages.add(BrancheImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.brancheData != null) {
      data['BrancheData'] = this.brancheData.toJson();
    }
    if (this.brancheImages != null) {
      data['BrancheImages'] =
          this.brancheImages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrancheData {
  int companyID;
  int raty;
  int brancheID;
  String brancheName;
  String companyImage;
  String branchAddressAR;
  String branchAddressEN;
  String longitude;
  String latitude;
  Null favorite;
  int totalBranches;

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
    companyID = json['CompanyID'];
    raty = json['raty'];
    brancheID = json['BrancheID'];
    brancheName = json['BrancheName'];
    companyImage = json['CompanyImage'];
    branchAddressAR = json['BranchAddressAR'];
    branchAddressEN = json['BranchAddressEN'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    favorite = json['Favorite'];
    totalBranches = json['TotalBranches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CompanyID'] = this.companyID;
    data['raty'] = this.raty;
    data['BrancheID'] = this.brancheID;
    data['BrancheName'] = this.brancheName;
    data['CompanyImage'] = this.companyImage;
    data['BranchAddressAR'] = this.branchAddressAR;
    data['BranchAddressEN'] = this.branchAddressEN;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['Favorite'] = this.favorite;
    data['TotalBranches'] = this.totalBranches;
    return data;
  }
}

class BrancheImages {
  String image;

  BrancheImages({this.image});

  BrancheImages.fromJson(Map<String, dynamic> json) {
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Image'] = this.image;
    return data;
  }
}
