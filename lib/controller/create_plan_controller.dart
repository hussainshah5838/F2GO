import 'package:get/get.dart';
import '../constants/app_images.dart';
import '../model/plan_model.dart';
import '../view/screens/createplan/plan_details.dart';

class CreatePlanController extends GetxController {
  final RxList<PlanItem> planItems = <PlanItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPlanItems();
  }

  void loadPlanItems() {
    planItems.addAll([
      PlanItem(
        title: 'Visit to York Museum',
        location: 'New York, United States',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: '\$256.99',
        imagePath: Assets.imagesMueseumhd,
        rating: 4.9,
        reviewCount: 455,
      ),

      PlanItem(
        title: 'Gili Trawangan',
        location: 'New York, United States',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
        price: '\$256.99',
        imagePath: Assets.imagesGili,
        rating: 4.9,
        reviewCount: 67,
      ),
    ]);
  }

  void selectPlan(PlanItem item) {
    Get.to(() => CreatePlanDetailsScreen(), arguments: item);
  }
}
