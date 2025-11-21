import 'package:get/get.dart';
import 'package:mjbeauty/controllers/HomeController.dart';

class HomeBindings extends Bindings{
  @override
  void dependancies () {
    Get.put(Homecontroller());
  }

  @override
  void dependencies() {
    // TODO: implement dependencies
  }
  }