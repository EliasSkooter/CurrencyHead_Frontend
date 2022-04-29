import 'package:currency_head/domain/entities/LogedUser.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  RxMap userInfo = {}.obs;
  final storage = GetStorage();

  @override
  void onInit() async {
    await GetStorage.init();
    userInfo.value = storage.read('userInfo') ?? {};
    print('user infooo ===> $userInfo');
    super.onInit();
  }

  void setCurrentUserInfo(LogedUser logedUser) {
    userInfo.value = logedUser.toJson();
    print("user info ===> $userInfo");
    storage.write("userInfo", userInfo);
  }

  void clearCurrentUser() {
    userInfo.clear();
    storage.remove("userInfo");
  }
}
