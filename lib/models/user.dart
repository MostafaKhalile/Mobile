class User {
  int? statusCode;
  String? status;
  String? message;
  String? token;
  int? userID;
  int? accountTypeUser;
  String? name;
  String? image;
  String? coverImage;
  bool? locations;
  bool? confirmedCompany;
  String? goUrl;

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
    statusCode = json['status'] as int?;
    status = json['Status'] as String?;
    message = json['message'] as String?;
    token = json['token'] as String?;
    userID = json['UserID'] as int?;
    accountTypeUser = json['AccountTypeUser'] as int?;
    name = json['Name'] as String?;
    image = json['Image'] as String?;
    coverImage = json['CoverImage'] as String?;
    locations = json['Locations'] as bool?;
    confirmedCompany = json['ConfirmedCompany'] as bool?;
    goUrl = json['Go_url'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = statusCode;
    data['Status'] = status;
    data['message'] = message;
    data['token'] = token;
    data['UserID'] = userID;
    data['AccountTypeUser'] = accountTypeUser;
    data['Name'] = name;
    data['Image'] = image;
    data['CoverImage'] = coverImage;
    data['Locations'] = locations;
    data['ConfirmedCompany'] = confirmedCompany;
    data['Go_url'] = goUrl;
    return data;
  }
}
