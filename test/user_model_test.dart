import 'package:flutter_test/flutter_test.dart';
import 'package:techtime/Models/user.dart';

void main() {
  final userModel = User(
      accountTypeUser: 3,
      confirmedCompany: false,
      coverImage: "",
      goUrl: "",
      image: "",
      locations: false,
      message: "",
      name: "Mostafa",
      status: "",
      token: "",
      userID: 1,
      statusCode: 4);

  test(
    'should be a subclass of User entity',
    () async {
      // assert
      expect(userModel, isA<User>());
    },
  );
}
