class CompanyBranches {
  int brancheID;
  String brancheName;
  String branchAddressAR;
  String branchAddressEN;
  String image;

  CompanyBranches(
      {this.brancheID,
      this.brancheName,
      this.branchAddressAR,
      this.branchAddressEN,
      this.image});

  CompanyBranches.fromJson(Map<String, dynamic> json) {
    brancheID = json['BrancheID'];
    brancheName = json['BrancheName'];
    branchAddressAR = json['BranchAddressAR'];
    branchAddressEN = json['BranchAddressEN'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BrancheID'] = this.brancheID;
    data['BrancheName'] = this.brancheName;
    data['BranchAddressAR'] = this.branchAddressAR;
    data['BranchAddressEN'] = this.branchAddressEN;
    data['Image'] = this.image;
    return data;
  }
}
