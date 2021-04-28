class User {
  int statusCode;
  String status;
  String message;
  String token;
  int userID;
  int accountTypeUser;
  String name;
  String image;
  String coverImage;
  bool locations;
  bool confirmedCompany;
  String goUrl;

  User(
      {this.statusCode,
      this.status,
      this.message,
      this.token,
      this.userID,
      this.accountTypeUser,
      this.name,
      this.image,
      this.coverImage,
      this.locations,
      this.confirmedCompany,
      this.goUrl});

  User.fromJson(Map<String, dynamic> json) {
    statusCode = json['status'];
    status = json['Status'];
    message = json['message'];
    token = json['token'];
    userID = json['UserID'];
    accountTypeUser = json['AccountTypeUser'];
    name = json['Name'];
    image = json['Image'];
    coverImage = json['CoverImage'];
    locations = json['Locations'];
    confirmedCompany = json['ConfirmedCompany'];
    goUrl = json['Go_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.statusCode;
    data['Status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    data['UserID'] = this.userID;
    data['AccountTypeUser'] = this.accountTypeUser;
    data['Name'] = this.name;
    data['Image'] = this.image;
    data['CoverImage'] = this.coverImage;
    data['Locations'] = this.locations;
    data['ConfirmedCompany'] = this.confirmedCompany;
    data['Go_url'] = this.goUrl;
    return data;
  }
}
