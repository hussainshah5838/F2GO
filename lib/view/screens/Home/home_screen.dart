import 'dart:developer';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/constants/app_styling.dart';
import 'package:f2g/constants/loading_animation.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/core/bindings/bindings.dart';
import 'package:f2g/core/common/global_instance.dart';
import 'package:f2g/core/enums/categories_status.dart';
import 'package:f2g/core/enums/plan_status.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/view/screens/createplan/create_new_plan.dart';
import 'package:f2g/view/screens/createplan/create_plan_and_map_screen.dart';
import 'package:f2g/view/screens/favourite/favourites.dart';
import 'package:f2g/view/screens/my_plans/my_plans.dart';
import 'package:f2g/view/screens/notifcation/notification.dart';
import 'package:f2g/view/screens/plans/plan_details.dart';
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
  final PlanController _ctrl = Get.find<PlanController>();

  final List<HomeOptionsContainer> homeoptions = [
    HomeOptionsContainer(
      image: Assets.imagesFootball,
      // text: "Football",
      // subtext: "Maria Fernanda",
      text: "Culture and Leisure",
      subtext: "",
      color: Color(0xffFAEDCB).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(
            categorieValue: CategoriesStatus.culture_and_leisure.name,
          ),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesMusic,
      // text: "Music",
      // subtext: "Jessa Irvine",
      text: "Nature and Outdoors",
      subtext: "",
      color: Color(0xffF2C6DF).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(
            categorieValue: CategoriesStatus.nature_and_outdoors.name,
          ),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesGames,
      text: "Sports and Wellness",
      subtext: "",
      color: Color(0xffC9E4DF).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(
            categorieValue: CategoriesStatus.sport_and_wellness.name,
          ),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesComida,
      // text: "Comida",
      // subtext: "Ivan Taylor",
      text: "Social and Lifestyle",
      subtext: "",
      color: Color(0xffFAFFBF).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(
            categorieValue: CategoriesStatus.social_and_lifestyle.name,
          ),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesGym,
      // text: "Gym Training",
      // subtext: "Ximena Valentine",
      text: "Creativity and Learning",
      subtext: "",
      color: Color(0xffC5DEF2).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(
            categorieValue: CategoriesStatus.creativity_and_learning.name,
          ),
          binding: PlanBindings(),
        );
      },
    ),
    HomeOptionsContainer(
      image: Assets.imagesPainting,
      // text: "Painting & Fun",
      // subtext: "Andrew Hike",
      text: "Travel and Getaways",
      subtext: "",
      color: Color(0xffF8D9C4).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(
            categorieValue: CategoriesStatus.travel_and_getaways.name,
          ),
          binding: PlanBindings(),
        );
      },
    ),

    HomeOptionsContainer(
      image: Assets.imagesGamingIcon,
      // text: "Painting & Fun",
      // subtext: "Andrew Hike",
      text: "Gaming and Geek",
      subtext: "",
      color: Color(0xffF8D9C4).withValues(alpha: 0.5),
      onTap: () {
        Get.to(
          () => PlansScreen(
            categorieValue: CategoriesStatus.gaming_and_geek.name,
          ),
          binding: PlanBindings(),
        );
      },
    ),
  ];

  // ✅ Controller for search input
  final TextEditingController _searchController = TextEditingController();
  // ✅ List to store filtered categories
  // late List<HomeOptionsContainer> filteredOptions;

  @override
  void initState() {
    super.initState();
    // _ctrl.fetchPlans(status: PlanStatus.active.name);
    userService.getCurrentUserInformation();

    // initially show all options
    // filteredOptions = homeoptions;

    // listen for search changes (optional, or can use onChanged directly)
    _searchController.addListener(() {
      filterCategories(_searchController.text);
    });
  }

  // ✅ Function to filter categories
  void filterCategories(String query) {
    final results =
        _ctrl.plans.where((option) {
          final title = option.title?.toLowerCase();
          final subtitle = option.title?.toLowerCase();
          final search = query.toLowerCase();
          return title!.contains(search) || subtitle!.contains(search);
        }).toList();

    // setState(() {
    //   filteredOptions = results;
    _ctrl.filterPlans.value = results;
    log("Filter Result: ${_ctrl.filterPlans.length}");
    //   log("Filter Options: ${filteredOptions.length}");
    // });
  }

  // --------------------
  // --------------------
  // --- Active Plans ---
  // --------------------
  // --------------------

  // Get current page items
  List<PlanModel> getCurrentPageItems() {
    final startIndex = _ctrl.currentPage.value * _ctrl.itemsPerPage.value;
    final endIndex = (startIndex + _ctrl.itemsPerPage.value).clamp(
      0,
      _ctrl.plans.length,
    );

    if (startIndex >= _ctrl.plans.length) return [];

    return _ctrl.plans.sublist(startIndex, endIndex);
  }

  // Check if can go to next page
  bool canGoNext() {
    return (_ctrl.currentPage.value + 1) * _ctrl.itemsPerPage.value <
        _ctrl.plans.length;
  }

  // Check if can go to previous page
  bool canGoPrevious() {
    return _ctrl.currentPage.value > 0;
  }

  // Go to next page
  void goToNextPage() {
    if (canGoNext()) {
      _ctrl.currentPage.value++;
    }
  }

  // Go to previous page
  void goToPreviousPage() {
    if (canGoPrevious()) {
      _ctrl.currentPage.value--;
    }
  }

  // Get total pages
  int getTotalPages() {
    return (_ctrl.plans.length / _ctrl.itemsPerPage.value).ceil();
  }

  // --------------------
  // --------------------
  // --- Expire Plans ---
  // --------------------
  // --------------------

  // Get current page items
  List<PlanModel> getExpireCurrentPageItems() {
    final startIndex =
        _ctrl.currentExpirePage.value * _ctrl.itemsExpirePerPage.value;
    final endIndex = (startIndex + _ctrl.itemsExpirePerPage.value).clamp(
      0,
      _ctrl.expirePlans.length,
    );

    if (startIndex >= _ctrl.expirePlans.length) return [];

    return _ctrl.expirePlans.sublist(startIndex, endIndex);
  }

  // Check if can go to next page
  bool canExpireGoNext() {
    return (_ctrl.currentExpirePage.value + 1) *
            _ctrl.itemsExpirePerPage.value <
        _ctrl.expirePlans.length;
  }

  // Check if can go to previous page
  bool canExpireGoPrevious() {
    return _ctrl.currentExpirePage.value > 0;
  }

  // Go to next page
  void goToExpireNextPage() {
    if (canGoNext()) {
      _ctrl.currentExpirePage.value++;
    }
  }

  // Go to previous page
  void goToExpirePreviousPage() {
    if (canGoPrevious()) {
      _ctrl.currentExpirePage.value--;
    }
  }

  // Get total pages
  int getExpireTotalPages() {
    return (_ctrl.expirePlans.length / _ctrl.itemsExpirePerPage.value).ceil();
  }

  // -------------------------------------------------------------
  // -------------------------------------------------------------
  // -------------------------------------------------------------
  // -------------------------------------------------------------

  // Get filter  current page items
  List<PlanModel> getFlterCurrentPageItems() {
    final startIndex = _ctrl.currentPage.value * _ctrl.itemsPerPage.value;
    final endIndex = (startIndex + _ctrl.itemsPerPage.value).clamp(
      0,
      _ctrl.filterPlans.length,
    );

    if (startIndex >= _ctrl.filterPlans.length) return [];

    return _ctrl.filterPlans.sublist(startIndex, endIndex);
  }

  // Check if can go to next page
  bool canFilterGoNext() {
    return (_ctrl.currentPage.value + 1) * _ctrl.itemsPerPage.value <
        _ctrl.filterPlans.length;
  }

  // Check if can go to previous page
  bool canFilterGoPrevious() {
    return _ctrl.currentPage.value > 0;
  }

  // Go to next page
  void goToFiterNextPage() {
    if (canFilterGoNext()) {
      _ctrl.currentPage.value++;
    }
  }

  // Go to previous page
  void goToFilterPreviousPage() {
    if (canGoPrevious()) {
      _ctrl.currentPage.value--;
    }
  }

  // Get total pages
  int getFilterTotalPages() {
    return (_ctrl.filterPlans.length / _ctrl.itemsPerPage.value).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: DefaultTabController(
        length: 2,
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
                                    url:
                                        userService
                                            .userModel
                                            .value
                                            .profileImage,
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
                                    text:
                                        userService.userModel.value.email ?? "",
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
                        // SizedBox(height: h(context, 13.5)),
                        // // sideOptions(
                        // //   context,
                        // //   Assets.imagesPlans,
                        // //   "Plans",
                        // //   onTap: () {
                        // //     menuController.isMenuOpen.value = false;
                        // //     Get.to(PlansScreen(), binding: PlanBindings());
                        // //   },
                        // // ),
                        // SizedBox(height: h(context, 13.5)),
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
                          "My Plans",
                          arenotification: false,
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              menuController.isMenuOpen.value = false;
                              Future.microtask(() {
                                Get.to(
                                  () => MyPlansScreen(),
                                  binding: PlanBindings(),
                                );
                              });
                            });
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
                          Assets.imagesLocationicon,
                          haveLocationIcon: true,
                          "Discover Plans",
                          onTap: () {
                            menuController.isMenuOpen.value = false;
                            Get.to(
                              CreatePlanAndMapScreen(),
                              binding: PlanBindings(),
                            );
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
                          arenotification: false,
                          onTap: () {
                            Get.to(
                              () => NotificationScreen(),
                              binding: NotificationBindings(),
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
                                onTap: () async {
                                  // await Get.find<AuthInputController>()
                                  //     .logOutCurrentUser();
                                  showLogoutSheet(context);
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
      ),
    );
  }

  Widget sideOptions(
    BuildContext context,
    String image,

    String title, {
    bool haveLocationIcon = false,
    bool arenotification = false,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            (haveLocationIcon)
                ? Icon(Icons.location_on_outlined, size: 20)
                : CommonImageView(
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
    return InkWell(
      onTap: () {
        menuController.isMenuOpen.value = false;
      },
      child: AbsorbPointer(
        absorbing: (menuController.isMenuOpen.value) ? true : false,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Stack(
            children: [
              Image.asset(Assets.imagesRadialgradient, fit: BoxFit.cover),
              SafeArea(
                child: Padding(
                  padding: symmetric(context, horizontal: 20),
                  child: Obx(
                    () => Column(
                      children: [
                        SizedBox(height: h(context, 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                menuController.toggleMenu();
                              },

                              child:
                                  (menuController.isMenuOpen.value)
                                      ? Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Icon(Icons.close),
                                      )
                                      : CommonImageView(
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
                                  // text: "Good Morning!",
                                  text:
                                      menuController.getGreetingMessage().value,
                                  size: 12,
                                  paddingBottom: 2,
                                  weight: FontWeight.w500,
                                  fontFamily: AppFonts.HelveticaNowDisplay,
                                  color: Color(
                                    0xff0E0E0C,
                                  ).withValues(alpha: 0.7),
                                ),
                                CustomText(
                                  text:
                                      "${userService.userModel.value.fullName}",
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
                                  (userService.userModel.value.profileImage !=
                                          null)
                                      ? CommonImageView(
                                        url:
                                            userService
                                                .userModel
                                                .value
                                                .profileImage,
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
                                        controller:
                                            _searchController, // ✅ Added
                                        onChanged:
                                            (value) => filterCategories(
                                              value,
                                            ), // ✅ Added
                                        cursorColor: kBlackColor,
                                        style: TextStyle(
                                          fontSize: f(context, 14),
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              AppFonts.HelveticaNowDisplay,
                                          color: kBlackColor,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Search here...",
                                          hintStyle: TextStyle(
                                            fontSize: f(context, 14),
                                            fontWeight: FontWeight.w500,
                                            fontFamily:
                                                AppFonts.HelveticaNowDisplay,
                                            color: kBlackColor.withValues(
                                              alpha: 0.5,
                                            ),
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

                        // ---- Search FIlter Code -----
                        (_ctrl.filterPlans.isNotEmpty &&
                                _searchController.text.isNotEmpty)
                            ? Expanded(
                              child:
                                  _ctrl.isLoading.value
                                      ? Center(child: WaveLoading())
                                      : _ctrl.filterPlans.isEmpty
                                      ? Center(
                                        child: CustomText(
                                          text: "No Plans Found!",
                                          color: kBlackColor,
                                          size: 13,
                                        ),
                                      )
                                      : SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      // getCurrentPageItems()
                                                      // .length,
                                                      getFlterCurrentPageItems()
                                                          .length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        mainAxisSpacing: 10,
                                                        crossAxisSpacing: 10,
                                                        mainAxisExtent: 180,
                                                      ),
                                                  itemBuilder: (
                                                    context,
                                                    index,
                                                  ) {
                                                    final item =
                                                        getFlterCurrentPageItems()[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                          () =>
                                                              PlansDetailScreen(),
                                                          arguments: {
                                                            'data': item,
                                                          },
                                                        );
                                                      },
                                                      child: _buildActiveCompletedCard(
                                                        item,
                                                        context,
                                                        () {
                                                          Get.to(
                                                            () =>
                                                                PlansDetailScreen(),
                                                            arguments: {
                                                              'data': item,
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),

                                                // Previous Button
                                                if (canFilterGoPrevious())
                                                  Positioned(
                                                    left: 0,
                                                    top: 0,
                                                    bottom: 0,
                                                    child: Center(
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap:
                                                              // goToPreviousPage,
                                                              goToFilterPreviousPage,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                25,
                                                              ),
                                                          child: Container(
                                                            height: 45,
                                                            width: 45,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                    0xff62D5C3,
                                                                  ),
                                                                  Color(
                                                                    0xffD7FAB7,
                                                                  ),
                                                                ],
                                                                begin:
                                                                    Alignment
                                                                        .topLeft,
                                                                end:
                                                                    Alignment
                                                                        .bottomRight,
                                                              ),
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: kSecondaryColor
                                                                      .withOpacity(
                                                                        0.3,
                                                                      ),
                                                                  blurRadius:
                                                                      10,
                                                                  offset:
                                                                      Offset(
                                                                        0,
                                                                        4,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_left,
                                                              color:
                                                                  kWhiteColor,
                                                              size: 28,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                // Next Button
                                                if (
                                                // canGoNext()
                                                canFilterGoNext())
                                                  Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 0,
                                                    child: Center(
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          // onTap: goToNextPage,
                                                          onTap:
                                                              goToFiterNextPage,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                25,
                                                              ),
                                                          child: Container(
                                                            height: 45,
                                                            width: 45,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                    0xff62D5C3,
                                                                  ),
                                                                  Color(
                                                                    0xffD7FAB7,
                                                                  ),
                                                                ],
                                                                begin:
                                                                    Alignment
                                                                        .topLeft,
                                                                end:
                                                                    Alignment
                                                                        .bottomRight,
                                                              ),
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: kSecondaryColor
                                                                      .withOpacity(
                                                                        0.3,
                                                                      ),
                                                                  blurRadius:
                                                                      10,
                                                                  offset:
                                                                      Offset(
                                                                        0,
                                                                        4,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              color:
                                                                  kWhiteColor,
                                                              size: 28,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),

                                            SizedBox(height: 70),
                                          ],
                                        ),
                                      ),

                              // SingleChildScrollView(
                              //   child: Column(
                              //     children: [
                              //       Obx(
                              //         () => ListView.builder(
                              //           shrinkWrap: true,
                              //           itemCount:
                              //               _ctrl.filterPlans.length,
                              //           itemBuilder: (context, index) {
                              //             final item =
                              //                 _ctrl.filterPlans[index];
                              //             return InkWell(
                              //               onTap: () {
                              //                 Get.to(
                              //                   () =>
                              //                       PlansDetailScreen(),
                              //                   arguments: {
                              //                     'data': item,
                              //                   },
                              //                 );
                              //               },
                              //               child:
                              //                   _buildActiveCompletedCard(
                              //                     item,
                              //                     context,
                              //                     () {},
                              //                   ),
                              //             );
                              //           },
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            )
                            :
                            // ---- Plans Code ------
                            // - Tabs -
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    padding: symmetric(
                                      context,
                                      horizontal: 3,
                                      vertical: 2,
                                    ),
                                    height: h(context, 38),
                                    width: w(context, double.maxFinite),
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(
                                        h(context, 14),
                                      ),
                                    ),
                                    child: TabBar(
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          h(context, 12),
                                        ),
                                        color: kSecondaryColor,
                                      ),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      labelStyle: TextStyle(
                                        fontSize: f(context, 14),
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            AppFonts.HelveticaNowDisplay,
                                      ),
                                      unselectedLabelStyle: TextStyle(
                                        fontSize: f(context, 14),
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            AppFonts.HelveticaNowDisplay,
                                      ),
                                      dividerHeight: h(context, 0),
                                      labelColor: kWhiteColor,
                                      unselectedLabelColor: ktextcolor,
                                      indicatorColor: Colors.transparent,
                                      onTap: (value) async {
                                        log("$value");

                                        if (value == 0) {
                                          // _ctrl.currentPage.value = 0;
                                          await _ctrl.fetchPlans(
                                            status: PlanStatus.active.name,
                                          );
                                        } else {
                                          await _ctrl.expiredFetchPlans();
                                          // _ctrl.currentPage.value = 1;

                                          // await _ctrl.fetchPlans(
                                          //   status: PlanStatus.completed.name,
                                          // );
                                        }
                                      },
                                      tabs: [
                                        Tab(text: 'Active'),
                                        Tab(text: 'Expired'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: h(context, 20)),
                                  Obx(
                                    () => Expanded(
                                      child: TabBarView(
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          // ACTIVE PLANS TAB
                                          _ctrl.isLoading.value
                                              ? Center(child: WaveLoading())
                                              : _ctrl.plans.isEmpty
                                              ? Center(
                                                child: CustomText(
                                                  text: "No Plans Found!",
                                                  color: kBlackColor,
                                                  size: 13,
                                                ),
                                              )
                                              : Obx(
                                                () => SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          GridView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                getCurrentPageItems()
                                                                    .length,
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                                  crossAxisCount:
                                                                      2,
                                                                  mainAxisSpacing:
                                                                      10,
                                                                  crossAxisSpacing:
                                                                      10,
                                                                  mainAxisExtent:
                                                                      180,
                                                                ),
                                                            itemBuilder: (
                                                              context,
                                                              index,
                                                            ) {
                                                              final item =
                                                                  getCurrentPageItems()[index];
                                                              return InkWell(
                                                                onTap: () {
                                                                  // Get.to(
                                                                  //   () =>
                                                                  //       PlansDetailScreen(),
                                                                  //   arguments: {
                                                                  //     'data':
                                                                  //         item,
                                                                  //   },
                                                                  // );
                                                                },
                                                                child: _buildActiveCompletedCard(
                                                                  item,
                                                                  context,
                                                                  () {
                                                                    Get.to(
                                                                      () =>
                                                                          PlansDetailScreen(),
                                                                      arguments: {
                                                                        'data':
                                                                            item,
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),

                                                          // Previous Button
                                                          if (canGoPrevious())
                                                            Positioned(
                                                              left: 0,
                                                              top: 0,
                                                              bottom: 0,
                                                              child: Center(
                                                                child: Material(
                                                                  color:
                                                                      Colors
                                                                          .transparent,
                                                                  child: InkWell(
                                                                    onTap:
                                                                        goToPreviousPage,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          25,
                                                                        ),
                                                                    child: Container(
                                                                      height:
                                                                          45,
                                                                      width: 45,
                                                                      decoration: BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                          colors: [
                                                                            Color(
                                                                              0xff62D5C3,
                                                                            ),
                                                                            Color(
                                                                              0xffD7FAB7,
                                                                            ),
                                                                          ],
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end:
                                                                              Alignment.bottomRight,
                                                                        ),
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: kSecondaryColor.withOpacity(
                                                                              0.3,
                                                                            ),
                                                                            blurRadius:
                                                                                10,
                                                                            offset: Offset(
                                                                              0,
                                                                              4,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .chevron_left,
                                                                        color:
                                                                            kWhiteColor,
                                                                        size:
                                                                            28,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                          // Next Button
                                                          if (canGoNext())
                                                            Positioned(
                                                              right: 0,
                                                              top: 0,
                                                              bottom: 0,
                                                              child: Center(
                                                                child: Material(
                                                                  color:
                                                                      Colors
                                                                          .transparent,
                                                                  child: InkWell(
                                                                    onTap:
                                                                        goToNextPage,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          25,
                                                                        ),
                                                                    child: Container(
                                                                      height:
                                                                          45,
                                                                      width: 45,
                                                                      decoration: BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                          colors: [
                                                                            Color(
                                                                              0xff62D5C3,
                                                                            ),
                                                                            Color(
                                                                              0xffD7FAB7,
                                                                            ),
                                                                          ],
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end:
                                                                              Alignment.bottomRight,
                                                                        ),
                                                                        shape:
                                                                            BoxShape.circle,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: kSecondaryColor.withOpacity(
                                                                              0.3,
                                                                            ),
                                                                            blurRadius:
                                                                                10,
                                                                            offset: Offset(
                                                                              0,
                                                                              4,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .chevron_right,
                                                                        color:
                                                                            kWhiteColor,
                                                                        size:
                                                                            28,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),

                                                      SizedBox(height: 70),
                                                    ],
                                                  ),
                                                ),

                                                //  GridView.builder(
                                                //   shrinkWrap: true,
                                                //   itemCount: _ctrl.plans.length,
                                                //   gridDelegate:
                                                //       SliverGridDelegateWithFixedCrossAxisCount(
                                                //         crossAxisCount: 2,
                                                //         mainAxisSpacing: 10,
                                                //         crossAxisSpacing: 10,
                                                //         mainAxisExtent: 180,
                                                //       ),
                                                //   itemBuilder: (
                                                //     context,
                                                //     index,
                                                //   ) {
                                                //     final item =
                                                //         _ctrl.plans[index];
                                                //     return InkWell(
                                                //       onTap: () {
                                                //         Get.to(
                                                //           () =>
                                                //               PlansDetailScreen(),
                                                //           arguments: {
                                                //             'data': item,
                                                //           },
                                                //         );
                                                //       },
                                                //       child:
                                                //           _buildActiveCompletedCard(
                                                //             item,
                                                //             context,
                                                //             () {},
                                                //           ),
                                                //     );
                                                //   },
                                                // ),
                                              ),

                                          // EXPIRED PLANS TAB
                                          _ctrl.isLoading.value
                                              ? Center(child: WaveLoading())
                                              : _ctrl.expirePlans.isEmpty
                                              ? Center(
                                                child: CustomText(
                                                  text: "No Plans Found!",
                                                  color: kBlackColor,
                                                  size: 13,
                                                ),
                                              )
                                              : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        GridView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount:
                                                              getExpireCurrentPageItems()
                                                                  .length,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisSpacing:
                                                                    10,
                                                                crossAxisSpacing:
                                                                    10,
                                                                mainAxisExtent:
                                                                    180,
                                                              ),
                                                          itemBuilder: (
                                                            context,
                                                            index,
                                                          ) {
                                                            final item =
                                                                getExpireCurrentPageItems()[index];
                                                            return InkWell(
                                                              onTap: () {
                                                                Get.to(
                                                                  () =>
                                                                      PlansDetailScreen(),
                                                                  arguments: {
                                                                    'data':
                                                                        item,
                                                                  },
                                                                );
                                                              },
                                                              child: _buildActiveCompletedCard(
                                                                item,
                                                                context,
                                                                () {
                                                                  Get.to(
                                                                    () =>
                                                                        PlansDetailScreen(),
                                                                    arguments: {
                                                                      'data':
                                                                          item,
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),

                                                        // Previous Button
                                                        // if (canGoPrevious())
                                                        if (canExpireGoPrevious())
                                                          Positioned(
                                                            left: 0,
                                                            top: 0,
                                                            bottom: 0,
                                                            child: Center(
                                                              child: Material(
                                                                color:
                                                                    Colors
                                                                        .transparent,
                                                                child: InkWell(
                                                                  onTap:
                                                                      // goToPreviousPage,
                                                                      goToExpirePreviousPage,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        25,
                                                                      ),
                                                                  child: Container(
                                                                    height: 45,
                                                                    width: 45,
                                                                    decoration: BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                            0xff62D5C3,
                                                                          ),
                                                                          Color(
                                                                            0xffD7FAB7,
                                                                          ),
                                                                        ],
                                                                        begin:
                                                                            Alignment.topLeft,
                                                                        end:
                                                                            Alignment.bottomRight,
                                                                      ),
                                                                      shape:
                                                                          BoxShape
                                                                              .circle,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: kSecondaryColor.withOpacity(
                                                                            0.3,
                                                                          ),
                                                                          blurRadius:
                                                                              10,
                                                                          offset: Offset(
                                                                            0,
                                                                            4,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .chevron_left,
                                                                      color:
                                                                          kWhiteColor,
                                                                      size: 28,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        // Next Button
                                                        // if (canGoNext())
                                                        if (canExpireGoNext())
                                                          Positioned(
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0,
                                                            child: Center(
                                                              child: Material(
                                                                color:
                                                                    Colors
                                                                        .transparent,
                                                                child: InkWell(
                                                                  onTap:
                                                                      // goToNextPage,
                                                                      goToExpireNextPage,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        25,
                                                                      ),
                                                                  child: Container(
                                                                    height: 45,
                                                                    width: 45,
                                                                    decoration: BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                            0xff62D5C3,
                                                                          ),
                                                                          Color(
                                                                            0xffD7FAB7,
                                                                          ),
                                                                        ],
                                                                        begin:
                                                                            Alignment.topLeft,
                                                                        end:
                                                                            Alignment.bottomRight,
                                                                      ),
                                                                      shape:
                                                                          BoxShape
                                                                              .circle,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: kSecondaryColor.withOpacity(
                                                                            0.3,
                                                                          ),
                                                                          blurRadius:
                                                                              10,
                                                                          offset: Offset(
                                                                            0,
                                                                            4,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .chevron_right,
                                                                      color:
                                                                          kWhiteColor,
                                                                      size: 28,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),

                                                    SizedBox(height: 70),
                                                  ],
                                                ),
                                              ),

                                          // GridView.builder(
                                          //   shrinkWrap: true,
                                          //   itemCount: _ctrl.plans.length,
                                          //   gridDelegate:
                                          //       SliverGridDelegateWithFixedCrossAxisCount(
                                          //         crossAxisCount: 2,
                                          //         mainAxisSpacing: 10,
                                          //         crossAxisSpacing: 10,
                                          //       ),
                                          //   itemBuilder: (context, index) {
                                          //     final item =
                                          //         _ctrl.plans[index];
                                          //     return InkWell(
                                          //       onTap: () {
                                          //         Get.to(
                                          //           () =>
                                          //               PlansDetailScreen(),
                                          //           arguments: {
                                          //             'data': item,
                                          //           },
                                          //         );
                                          //       },
                                          //       child:
                                          //           _buildActiveCompletedCard(
                                          //             item,
                                          //             context,
                                          //             () {},
                                          //           ),
                                          //     );
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                        // ---------------------------------------------------------------
                        //  ----------------- Categores Builder Old Code -----------------
                        // ---------------------------------------------------------------
                        // Search Results
                        // (filteredOptions.isNotEmpty)
                        //     ? Expanded(
                        //       child: SingleChildScrollView(
                        //         child: Column(
                        //           children: [
                        //             GridView.builder(
                        //               physics: NeverScrollableScrollPhysics(
                        //                 parent: null,
                        //               ),
                        //               shrinkWrap: true,
                        //               padding: EdgeInsets.zero,
                        //               gridDelegate:
                        //                   SliverGridDelegateWithFixedCrossAxisCount(
                        //                     crossAxisCount: 2,
                        //                     crossAxisSpacing: w(context, 8),
                        //                     mainAxisSpacing: h(context, 8),
                        //                     mainAxisExtent: h(context, 170),
                        //                   ),
                        //               itemCount: filteredOptions.length,
                        //               itemBuilder: (context, index) {
                        //                 return filteredOptions[index];
                        //               },
                        //             ),
                        //             SizedBox(height: h(context, 12)),
                        //             CustomButton(
                        //               onPressed: () {
                        //                 // Get.to(CreatePlanScreen());
                        //                 // Get.to(CreatePlanScreen());
                        //                 Get.to(
                        //                   () => CreateNewPlanScreen(),
                        //                   binding: PlanBindings(),
                        //                 );
                        //               },
                        //               text: "Create new Plan",
                        //               iscustomgradient: true,
                        //               gradient: LinearGradient(
                        //                 colors: [
                        //                   Color(0xff62D5C3),
                        //                   Color(0xffB5F985),
                        //                 ],
                        //                 begin: Alignment.centerLeft,
                        //                 end: Alignment.centerRight,
                        //               ),
                        //               borderradius: 100,
                        //               isimage: true,
                        //               imagePath: Assets.imagesAddicon,
                        //               size: 18,
                        //               weight: FontWeight.w500,
                        //               fontFamily: AppFonts.HelveticaNowDisplay,
                        //               color: kBlackColor,
                        //               height: 50,
                        //               width: 235,
                        //             ),
                        //             SizedBox(height: h(context, 15)),
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        // : Expanded(
                        //   child: SingleChildScrollView(
                        //     child: Column(
                        //       children: [
                        //         GridView.builder(
                        //           physics: NeverScrollableScrollPhysics(
                        //             parent: null,
                        //           ),
                        //           shrinkWrap: true,
                        //           padding: EdgeInsets.zero,
                        //           gridDelegate:
                        //               SliverGridDelegateWithFixedCrossAxisCount(
                        //                 crossAxisCount: 2,
                        //                 crossAxisSpacing: w(context, 8),
                        //                 mainAxisSpacing: h(context, 8),
                        //                 mainAxisExtent: h(context, 170),
                        //               ),
                        //           itemCount: homeoptions.length,
                        //           itemBuilder: (context, index) {
                        //             return homeoptions[index];
                        //           },
                        //         ),
                        //         SizedBox(height: h(context, 12)),
                        //         CustomButton(
                        //           onPressed: () {
                        //             // Get.to(CreatePlanScreen());
                        //             // Get.to(CreatePlanScreen());
                        //             Get.to(
                        //               () => CreateNewPlanScreen(),
                        //               binding: PlanBindings(),
                        //             );
                        //           },
                        //           text: "Create new Plan",
                        //           iscustomgradient: true,
                        //           gradient: LinearGradient(
                        //             colors: [
                        //               Color(0xff62D5C3),
                        //               Color(0xffB5F985),
                        //             ],
                        //             begin: Alignment.centerLeft,
                        //             end: Alignment.centerRight,
                        //           ),
                        //           borderradius: 100,
                        //           isimage: true,
                        //           imagePath: Assets.imagesAddicon,
                        //           size: 18,
                        //           weight: FontWeight.w500,
                        //           fontFamily: AppFonts.HelveticaNowDisplay,
                        //           color: kBlackColor,
                        //           height: 50,
                        //           width: 235,
                        //         ),
                        //         SizedBox(height: h(context, 15)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Obx(
            () =>
                (_ctrl.filterPlans.isNotEmpty &&
                        _searchController.text.isNotEmpty)
                    ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                          colors: [Color(0xff62D5C3), Color(0xffB5F985)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        // boxShadow: [BoxShadow(color: kBlackColor)],
                      ),
                      child:
                      // CustomText(text: "Clear")
                      InkWell(
                        onTap: () {
                          _ctrl.filterPlans.clear();
                          _searchController.clear();
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          child: Center(
                            child: CustomText(
                              text: "Clear Filter",
                              color: kBlackColor,
                            ),
                          ),
                        ),
                      ),

                      // -------- Floating Add button -----------

                      // FloatingActionButton(
                      //   backgroundColor: Colors.transparent,
                      //   mini: true,
                      //   onPressed: () {
                      //     Get.to(
                      //       () => CreateNewPlanScreen(),
                      //       binding: PlanBindings(),
                      //     );
                      //   },
                      //   child: Icon(Icons.add),
                      // ),
                    )
                    : Container(
                      height: 40,
                      child: Center(
                        child: CustomButton(
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
                          size: 12,
                          weight: FontWeight.w500,
                          fontFamily: AppFonts.HelveticaNowDisplay,
                          color: kBlackColor,
                          height: 40,
                          width: 170,
                        ),
                      ),
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveCompletedCard(
    PlanModel item,
    BuildContext context,
    VoidCallback onDetailPage,
  ) {
    return Container(
      margin: only(context, bottom: 10),
      padding: all(context, 10),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(h(context, 12)),
      ),
      child: InkWell(
        onTap: onDetailPage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(h(context, 8)),
              child: CommonImageView(
                url: item.planPhoto,
                fit: BoxFit.cover,
                height: 100,
                width: Get.width,
              ),
            ),
            CustomText(
              paddingTop: 5,
              text: item.title.toString(),
              size: 16,
              weight: FontWeight.w500,
              color: kBlackColor,
              fontFamily: AppFonts.HelveticaNowDisplay,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildActiveCompletedCard(PlanModel item, BuildContext context) {
  //   return Container(
  //     margin: only(context, bottom: 10),
  //     padding: all(context, 10),
  //     decoration: BoxDecoration(
  //       color: kWhiteColor,
  //       borderRadius: BorderRadius.circular(h(context, 12)),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(h(context, 8)),
  //               child: CommonImageView(
  //                 url: item.planPhoto,
  //                 fit: BoxFit.cover,
  //                 height: 46,
  //                 width: 48,
  //               ),
  //             ),

  //             SizedBox(width: w(context, 9)),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   CustomText(
  //                     text: item.title.toString(),
  //                     size: 16,
  //                     weight: FontWeight.w500,
  //                     color: kBlackColor,
  //                     fontFamily: AppFonts.HelveticaNowDisplay,
  //                   ),
  //                   SizedBox(height: h(context, 4)),
  //                   Row(
  //                     children: [
  //                       CommonImageView(
  //                         imagePath: Assets.imagesLocationicon,
  //                         height: 16,
  //                         width: 16,
  //                         fit: BoxFit.contain,
  //                       ),
  //                       SizedBox(width: w(context, 4)),
  //                       CustomText(
  //                         text: item.location.toString(),
  //                         size: 12,
  //                         weight: FontWeight.w500,
  //                         color: kBlackColor.withValues(alpha: 0.5),
  //                         fontFamily: AppFonts.HelveticaNowDisplay,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               height: h(context, 26),
  //               padding: symmetric(context, horizontal: 8),
  //               decoration: BoxDecoration(
  //                 color:
  //                     (item.status == PlanStatus.active.name)
  //                         ? const Color(0xff34A853).withValues(alpha: 0.08)
  //                         : kSecondaryColor.withValues(alpha: 0.08),
  //                 borderRadius: BorderRadius.circular(h(context, 100)),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Container(
  //                     height: h(context, 4),
  //                     width: w(context, 4),
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color:
  //                           (item.status == PlanStatus.active.name)
  //                               ? Color(0xff34A853)
  //                               : kSecondaryColor,
  //                     ),
  //                   ),
  //                   CustomText(
  //                     text: item.status!.capitalizeFirst.toString(),
  //                     size: 14,
  //                     paddingLeft: 6,
  //                     weight: FontWeight.w500,
  //                     color:
  //                         (item.status == PlanStatus.active.name)
  //                             ? Color(0xff34A853)
  //                             : kSecondaryColor,
  //                     fontFamily: AppFonts.HelveticaNowDisplay,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: h(context, 10)),
  //         Divider(
  //           color: Color(0xffE3E3E3),
  //           thickness: h(context, 1),
  //           height: h(context, 1),
  //         ),
  //         SizedBox(height: h(context, 10)),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   CustomText(
  //                     text: "Date & Time",
  //                     size: 12,
  //                     weight: FontWeight.w500,
  //                     color: kBlackColor.withValues(alpha: 0.5),
  //                     fontFamily: AppFonts.HelveticaNowDisplay,
  //                   ),
  //                   SizedBox(height: h(context, 2)),
  //                   CustomText(
  //                     text: dT.formatEventDateTime(
  //                       dTime: item.startTime!,
  //                       onlyDate: item.startDate!,
  //                     ),
  //                     size: 14,
  //                     weight: FontWeight.w500,
  //                     color: kBlackColor,
  //                     fontFamily: AppFonts.HelveticaNowDisplay,
  //                   ),
  //                 ],
  //               ),
  //             ),

  //             StreamBuilder<DocumentSnapshot>(
  //               stream: plansCollection.doc(item.id).snapshots(),
  //               builder: (context, snapshot) {
  //                 if (!snapshot.hasData) {
  //                   return const Center(child: CircularProgressIndicator());
  //                 }

  //                 final data = snapshot.data!.data() as Map<String, dynamic>?;

  //                 // List of participant IDs
  //                 final participantIds = List<String>.from(
  //                   data?['participantsIds'] ?? [],
  //                 );

  //                 // If no participants, show nothing
  //                 if (participantIds.isEmpty) {
  //                   return const SizedBox.shrink();
  //                 }

  //                 // Get only first 3 participant IDs
  //                 List<String> limitedIds = participantIds.take(3).toList();

  //                 return FutureBuilder<List<DocumentSnapshot>>(
  //                   future: Future.wait(
  //                     limitedIds.map(
  //                       (uid) => userCollection.doc(uid).get(),
  //                       // If you want to fetch all participants, use the below line instead
  //                       // FirebaseFirestore.instance
  //                       //     .collection('users')
  //                       //     .doc(uid)
  //                       //     .get(),
  //                     ),
  //                   ),
  //                   builder: (context, userSnapshots) {
  //                     if (!userSnapshots.hasData) {
  //                       return const Center(child: CircularProgressIndicator());
  //                     }

  //                     final userDocs =
  //                         userSnapshots
  //                             .data!; // List<DocumentSnapshot<Map<String, dynamic>>?>

  //                     List<UserModel> validUsers =
  //                         userDocs
  //                             .where(
  //                               (doc) =>
  //                                   (doc as DocumentSnapshot).exists &&
  //                                   doc.data() != null,
  //                             )
  //                             .map((doc) => UserModel.fromMap(doc))
  //                             .toList();

  //                     if (validUsers.isEmpty) {
  //                       return const SizedBox.shrink();
  //                     }

  //                     log("Valid Users: ${validUsers.length}");

  //                     return Stack(
  //                       clipBehavior: Clip.none,
  //                       children: List.generate(
  //                         validUsers.length,
  //                         (i) => Padding(
  //                           padding: only(context, left: w(context, i * 18.0)),
  //                           child: CommonImageView(
  //                             radius: 100,
  //                             url: validUsers[i].profileImage,
  //                             height: 28,
  //                             width: 28,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 );
  //               },
  //             ),

  //             // Stack(
  //             //   clipBehavior: Clip.none,
  //             //   children: List.generate(
  //             //     item.avatars.length,
  //             //     (i) => Padding(
  //             //       padding: only(context, left: w(context, i * 18.0)),
  //             //       child: CommonImageView(
  //             //         imagePath: item.avatars[i],
  //             //         height: 28,
  //             //         width: 28,
  //             //         fit: BoxFit.contain,
  //             //       ),
  //             //     ),
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
