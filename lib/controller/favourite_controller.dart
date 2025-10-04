import 'package:get/get.dart';
import '../constants/app_images.dart';
import '../model/favourite_model.dart';

class FavouriteController extends GetxController {
  RxList<FavouriteModel> favouriteList = <FavouriteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    favouriteList.addAll([
      FavouriteModel(
        image: Assets.imagesMueseumhd,
        title: "Visit to York Museum",
        location: "New York, United States",
        dateTime: "12:00 am | June 23, 2025",
        status: "Active",
        avatars: [
          Assets.imagesStackimage1,
          Assets.imagesStackimage2,
          Assets.imagesStackimage3,
        ],
      ),
      FavouriteModel(
        image: Assets.imagesMueseumhd,
        title: "Visit to York Museum",
        location: "New York, United States",
        dateTime: "12:00 am | June 23, 2025",
        status: "Active",
        avatars: [
          Assets.imagesStackimage1,
          Assets.imagesStackimage2,
          Assets.imagesStackimage3,
        ],
      ),
    ]);
  }
}
