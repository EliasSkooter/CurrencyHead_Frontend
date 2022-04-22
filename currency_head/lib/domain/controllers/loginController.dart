import 'package:currency_head/domain/entities/LogedUser.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Map userInfo = {}.obs;

  void setCurrentUserInfo(LogedUser logedUser) {
    userInfo = logedUser.toJson();
    print("user info ===> $userInfo");
  }

  void clearCurrentUser() {
    userInfo.clear();
  }
}
