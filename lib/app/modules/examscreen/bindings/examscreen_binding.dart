import 'package:get/get.dart';

import '../controllers/examscreen_controller.dart';

class ExamscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamscreenController>(
      () => ExamscreenController(),
    );
  }
}
