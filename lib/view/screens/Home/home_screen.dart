import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/controller/my_ctrl/auth_input_controller.dart';
import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/core/enums/categories_status.dart';
import 'package:f2g/view/screens/createplan/create_new_plan.dart';
import 'package:f2g/view/screens/favourite/favourites.dart';
import 'package:f2g/view/screens/notifcation/notification.dart';
import 'package:f2g/view/screens/plans/plans.dart';
import 'package:f2g/view/screens/user_profile/User_Profile.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:f2g/view/widget/custom_button_widget.dart';
import 'package:f2g/view/widget/home_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_images.dart';
import '../../../controller/home_menu_controller.dart';
import 'filter_bottomshett.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeMenuController menuController = Get.put(HomeMenuController());

  @override
  void initState() {
    super.initState();
    userService.getCurrentUserInformation();
  }

  final List<HomeOptionsContainer> homeoptions = [
    HomeOptionsContainer(
      image: Assets.imagesFootball,
      text: "Football",
      subtext: "Maria Fernanda",
      color: Color(0xffFAEDCB).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(categorieValue: CategoriesStatus.Football.name),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesMusic,
      text: "Music",
      subtext: "Jessa Irvine",
      color: Color(0xffF2C6DF).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(categorieValue: CategoriesStatus.Music.name),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesGames,
      text: "Games & Movies",
      subtext: "Maria Fernanda",
      color: Color(0xffC9E4DF).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(categorieValue: CategoriesStatus.GamesMovies.name),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesComida,
      text: "Comida",
      subtext: "Ivan Taylor",
      color: Color(0xffFAFFBF).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(categorieValue: CategoriesStatus.Comida.name),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesGym,
      text: "Gym Training",
      subtext: "Ximena Valentine",
      color: Color(0xffC5DEF2).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(categorieValue: CategoriesStatus.GymTraining.name),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesPainting,
      text: "Painting & Fun",
      subtext: "Andrew Hike",
      color: Color(0xffF8D9C4).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(categorieValue: CategoriesStatus.PaintingFun.name),
          binding: PlanBindings(),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff21E3D7), Color(0xffB5F985)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: only(context, left: 20, top: 24),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            (userService.userModel.value.profileImage != null)
                                ? CommonImageView(
                                  url: userService.userModel.value.profileImage,
                                  height: 36,
                                  width: 36,
                                  radius: 100,
                                  fit: BoxFit.cover,
                                )
                                : CommonImageView(
                                  imagePath: Assets.imagesProfilepic,
                                  height: 36,
                                  width: 36,
                                  radius: 100,
                                  fit: BoxFit.cover,
                                ),

                            SizedBox(width: w(context, 6)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  paddingBottom: 2,
                                  text:
                                      userService.userModel.value.fullName ??
                                      "",
                                  size: 16,
                                  weight: FontWeight.w700,
                                  color: Color(0xff0E0E0C),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                ),
                                CustomText(
                                  paddingBottom: 2,
                                  text: userService.userModel.value.email ?? "",
                                  size: 11,
                                  weight: FontWeight.w500,
                                  color: Color(
                                    0xff0E0E0C,
                                  ).withValues(alpha: 0.7),
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h(context, 23.5)),
                      sideOptions(
                        context,
                        Assets.imagesHome,
                        "Home",
                        onTap: () {
                          menuController.isMenuOpen.value = false;
                        },
                      ),
                      SizedBox(height: h(context, 13.5)),
                      SizedBox(
                        width: w(context, 158),
                        child: Divider(
                          color: kWhiteColor.withValues(alpha: 0.67),
                          height: h(context, 0.5),
                          thickness: h(context, 0.5),
                        ),
                      ),
                      SizedBox(height: h(context, 13.5)),
                      sideOptions(
                        context,
                        Assets.imagesFavourite,
                        "Favourites",
                        onTap: () {
                          Get.to(
                            () => FavouritesScreen(),
                            binding: PlanBindings(),
                          );
                          menuController.isMenuOpen.value = false;
                        },
                      ),
                      SizedBox(height: h(context, 13.5)),
                      SizedBox(
                        width: w(context, 158),
                        child: Divider(
                          color: kWhiteColor.withValues(alpha: 0.67),
                          height: h(context, 0.5),
                          thickness: h(context, 0.5),
                        ),
                      ),
                      SizedBox(height: h(context, 13.5)),
                      sideOptions(
                        context,
                        Assets.imagesPlans,
                        "Plans",
                        onTap: () {
                          menuController.isMenuOpen.value = false;
                          Get.to(PlansScreen(), binding: PlanBindings());
                        },
                      ),
                      SizedBox(height: h(context, 13.5)),
                      SizedBox(
                        width: w(context, 158),
                        child: Divider(
                          color: kWhiteColor.withValues(alpha: 0.67),
                          height: h(context, 0.5),
                          thickness: h(context, 0.5),
                        ),
                      ),
                      SizedBox(height: h(context, 13.5)),
                      sideOptions(
                        context,
                        Assets.imagesNotification,
                        "Notifications",
                        arenotification: true,
                        onTap: () {
                          Get.to(NotificationScreen());
                          menuController.isMenuOpen.value = false;
                        },
                      ),
                      SizedBox(height: h(context, 13.5)),
                      SizedBox(
                        width: w(context, 158),
                        child: Divider(
                          color: kWhiteColor.withValues(alpha: 0.67),
                          height: h(context, 0.5),
                          thickness: h(context, 0.5),
                        ),
                      ),
                      SizedBox(height: h(context, 13.5)),
                      sideOptions(
                        context,
                        Assets.imagesProfile,
                        "User Profile",
                        onTap: () {
                          Get.to(
                            UserProfileScreen(),
                            binding: ProfileBindings(),
                          );
                          menuController.isMenuOpen.value = false;
                        },
                      ),
                      Spacer(),
                      SafeArea(
                        bottom: true,
                        child: Row(
                          children: [
                            CommonImageView(
                              imagePath: Assets.imagesLogout,
                              height: 20,
                              width: 20,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: w(context, 6)),
                            CustomText(
                              text: "Logout",
                              size: 16,
                              weight: FontWeight.w500,
                              color: kSecondaryColor,
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              onTap: () {
                                Get.find<AuthInputController>()
                                    .logOutCurrentUser();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h(context, 30)),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () =>
                  menuController.isMenuOpen.value
                      ? AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        left:
                            menuController.isMenuOpen.value
                                ? w(context, 150)
                                : 0,
                        right:
                            menuController.isMenuOpen.value
                                ? -w(context, 150)
                                : 0,
                        top: h(
                          context,
                          menuController.isMenuOpen.value ? 0 : 0,
                        ),
                        bottom: h(
                          context,
                          menuController.isMenuOpen.value ? 0 : 0,
                        ),

                        child: Transform.scale(
                          scale: menuController.isMenuOpen.value ? 0.7 : 1,

                          child: Container(
                            width: w(context, 226),
                            decoration: BoxDecoration(
                              color: kWhiteColor.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(
                                h(context, 21.7),
                              ),
                            ),
                          ),
                        ),
                      )
                      : const SizedBox(),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: menuController.isMenuOpen.value ? w(context, 200) : 0,
                right: menuController.isMenuOpen.value ? -w(context, 200) : 0,
                top: h(context, menuController.isMenuOpen.value ? 0 : 0),
                bottom: h(context, menuController.isMenuOpen.value ? 0 : 0),
                child: Transform.scale(
                  scale: menuController.isMenuOpen.value ? 0.8 : 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      menuController.isMenuOpen.value ? h(context, 19.95) : 0,
                    ),
                    child: homeContent(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sideOptions(
    BuildContext context,
    String image,
    String title, {
    bool arenotification = false,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            CommonImageView(
              imagePath: image,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
            SizedBox(width: w(context, 6)),
            CustomText(
              text: title,
              size: 16,
              weight: FontWeight.w500,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
            ),
            if (arenotification) SizedBox(width: w(context, 6)),
            if (arenotification)
              Container(
                height: h(context, 6),
                width: w(context, 6),
                decoration: BoxDecoration(
                  color: kBlackColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget homeContent(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Image.asset(Assets.imagesRadialgradient, fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: symmetric(context, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: h(context, 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          menuController.toggleMenu();
                        },

                        child: CommonImageView(
                          imagePath: Assets.imagesMenu,
                          height: 48,
                          width: 48,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Good Morning!",
                            size: 12,
                            paddingBottom: 2,
                            weight: FontWeight.w500,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                            color: Color(0xff0E0E0C).withValues(alpha: 0.7),
                          ),
                          CustomText(
                            text: "${userService.userModel.value.fullName}",
                            size: 16,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                            weight: FontWeight.w500,
                            color: Color(0xff0E0E0C),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child:
                            (userService.userModel.value.profileImage != null)
                                ? CommonImageView(
                                  url: userService.userModel.value.profileImage,
                                  height: 48,
                                  width: 48,
                                  radius: 100,
                                  fit: BoxFit.cover,
                                )
                                : CommonImageView(
                                  imagePath: Assets.imagesProfilepic,
                                  height: 48,
                                  width: 48,
                                  radius: 100,
                                  fit: BoxFit.cover,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 21)),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: symmetric(context, horizontal: 12),
                          height: h(context, 46),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(
                              h(context, 100),
                            ),
                          ),
                          child: Row(
                            children: [
                              CommonImageView(
                                imagePath: Assets.imagesSearchicon,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: w(context, 4)),
                              Expanded(
                                child: TextFormField(
                                  cursorColor: kBlackColor,
                                  style: TextStyle(
                                    fontSize: f(context, 14),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppFonts.HelveticaNowDisplay,
                                    color: kBlackColor,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Search here...",
                                    hintStyle: TextStyle(
                                      fontSize: f(context, 14),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.HelveticaNowDisplay,
                                      color: kBlackColor.withValues(alpha: 0.5),
                                    ),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: w(context, 8)),
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            FilterBottomSheet(),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: Container(
                          height: h(context, 46),
                          width: w(context, 46),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CommonImageView(
                              imagePath: Assets.imagesFilter,
                              height: 22,
                              width: 22,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h(context, 16)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(parent: null),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: w(context, 8),
                                  mainAxisSpacing: h(context, 8),
                                  mainAxisExtent: h(context, 170),
                                ),
                            itemCount: homeoptions.length,
                            itemBuilder: (context, index) {
                              return homeoptions[index];
                            },
                          ),
                          SizedBox(height: h(context, 12)),
                          CustomButton(
                            onPressed: () {
                              // Get.to(CreatePlanScreen());
                              // Get.to(CreatePlanScreen());
                              Get.to(
                                () => CreateNewPlanScreen(),
                                binding: PlanBindings(),
                              );
                            },
                            text: "Create new Plan",
                            iscustomgradient: true,
                            gradient: LinearGradient(
                              colors: [Color(0xff62D5C3), Color(0xffB5F985)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderradius: 100,
                            isimage: true,
                            imagePath: Assets.imagesAddicon,
                            size: 18,
                            weight: FontWeight.w500,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                            color: kBlackColor,
                            height: 50,
                            width: 235,
                          ),
                          SizedBox(height: h(context, 15)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
