class CompanyBranche {
  int brancheID;
  String brancheName;
  String branchAddressAR;
  String branchAddressEN;
  String image;

  CompanyBranche(
      {this.brancheID,
      this.brancheName,
      this.branchAddressAR,
      this.branchAddressEN,
      this.image});

  CompanyBranche.fromJson(Map<String, dynamic> json) {
    brancheID = json['BrancheID'] as int;
    brancheName = json['BrancheName'] as String;
    branchAddressAR = json['BranchAddressAR'] as String;
    branchAddressEN = json['BranchAddressEN'] as String;
    image = json['Image'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BrancheID'] = brancheID;
    data['BrancheName'] = brancheName;
    data['BranchAddressAR'] = branchAddressAR;
    data['BranchAddressEN'] = branchAddressEN;
    data['Image'] = image;
    return data;
  }
}
