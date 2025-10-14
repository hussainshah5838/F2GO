// import 'package:f2g/constants/app_colors.dart';
// import 'package:f2g/constants/app_fonts.dart';
// import 'package:f2g/view/widget/Custom_text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../constants/app_images.dart';
// import '../../../constants/app_styling.dart';
// import '../../../controller/create_plan_controller.dart';
// import '../../../model/plan_model.dart';
// import '../../widget/common_image_view_widget.dart';

// class CreatePlanAndMapScreen extends StatefulWidget {
//   CreatePlanAndMapScreen({super.key});

//   @override
//   State<CreatePlanAndMapScreen> createState() => _CreatePlanAndMapScreenState();
// }

// class _CreatePlanAndMapScreenState extends State<CreatePlanAndMapScreen> {
//   final CreatePlanController controller = Get.put(CreatePlanController());

//   late GoogleMapController mapController;

//   final List<String> eventAddresses = [
//     'Islamabad, Pakistan',
//     'Karachi, Pakistan',
//     'Peshawar, Pakistan',
//   ];

//   final Set<Marker> markers = {};

//   LatLng initialPosition = const LatLng(17.517362, -0.806597);
//   // Default: Islamabad
//   @override
//   void initState() {
//     super.initState();
//     _setEventMarkers();
//   }

//   Future<void> _setEventMarkers() async {
//     for (var address in eventAddresses) {
//       try {
//         List<Location> locations = await locationFromAddress(address);
//         if (locations.isNotEmpty) {
//           final loc = locations.first;
//           setState(() {
//             markers.add(
//               Marker(
//                 markerId: MarkerId(address),
//                 position: LatLng(loc.latitude, loc.longitude),
//                 infoWindow: InfoWindow(title: address),
//               ),
//             );
//           });
//         }
//       } catch (e) {
//         debugPrint("Error finding location for $address: $e");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       body:
//       // GoogleMap(
//       //   onMapCreated: (controller) => mapController = controller,
//       //   initialCameraPosition: CameraPosition(
//       //     target: initialPosition,
//       //     zoom: 10.5,
//       //   ),
//       //   markers: markers,
//       // ),
//       Stack(
//         children: [
//           Stack(
//             children: [
//               Positioned.fill(
//                 child: GoogleMap(
//                   myLocationButtonEnabled: true,
//                   zoomControlsEnabled: false,
//                   onMapCreated: (controller) => mapController = controller,
//                   initialCameraPosition: CameraPosition(
//                     target: initialPosition,
//                     zoom: 5.5,
//                   ),
//                   markers: markers,
//                 ),
//               ),
//               //
//               //
//               // Positioned.fill(
//               //   child: Image.asset(Assets.imagesMap, fit: BoxFit.cover),
//               // ),

//               // Positioned(
//               //   bottom: 40,
//               //   left: 0,
//               //   right: 0,
//               //   child: Obx(
//               //     () => SizedBox(
//               //       height: h(context, 208),
//               //       child: ListView.builder(
//               //         scrollDirection: Axis.horizontal,
//               //         padding: only(context, left: 20),
//               //         itemCount: controller.planItems.length,
//               //         itemBuilder: (context, index) {
//               //           final item = controller.planItems[index];
//               //           return _buildPlanItemCard(context, item, controller);
//               //         },
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
// //
//           Container(
//             height: h(context, 100),
//             width: w(context, double.maxFinite),
//             decoration: BoxDecoration(color: kWhiteColor),
//             child: SafeArea(
//               bottom: false,
//               child: Column(
//                 children: [
//                   SizedBox(height: h(context, 10)),
//                   Padding(
//                     padding: symmetric(context, horizontal: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: CommonImageView(
//                             imagePath: Assets.imagesGreybackicon,
//                             height: 48,
//                             width: 48,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         SizedBox(width: w(context, 15)),
//                         Expanded(
//                           child: CustomText(
//                             text: "Create new plan",
//                             size: 16,
//                             weight: FontWeight.w500,
//                             color: kBlackColor,
//                             fontFamily: AppFonts.HelveticaNowDisplay,
//                           ),
//                         ),
//                         CustomText(
//                           text: "Create Manually",
//                           size: 16,
//                           weight: FontWeight.w500,
//                           fontFamily: AppFonts.HelveticaNowDisplay,
//                           color: kSecondaryColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPlanItemCard(
//     BuildContext context,
//     PlanItem item,
//     CreatePlanController controller,
//   ) {
//     return Container(
//       padding: symmetric(context, vertical: 12, horizontal: 14),
//       width: w(context, 317),
//       margin: only(context, right: 10),
//       decoration: BoxDecoration(
//         color: kWhiteColor,
//         borderRadius: BorderRadius.circular(h(context, 10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Row(
//                 children: List.generate(
//                   5,
//                   (i) => Padding(
//                     padding: only(context, right: 4),
//                     child: CommonImageView(
//                       imagePath: Assets.imagesStar,
//                       height: 10,
//                       width: 10,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//               CustomText(
//                 text: "${item.rating} Ratings",
//                 size: 12,
//                 weight: FontWeight.w500,
//                 color: Color(0xff2C2C2C),
//                 fontFamily: AppFonts.HelveticaNowDisplay,
//               ),
//             ],
//           ),
//           SizedBox(height: h(context, 11)),
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(h(context, 8)),
//                 child: CommonImageView(
//                   imagePath: item.imagePath,
//                   fit: BoxFit.cover,
//                   height: 46,
//                   width: 48,
//                 ),
//               ),

//               SizedBox(width: w(context, 9)),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: item.title,
//                       size: 20,
//                       weight: FontWeight.w500,
//                       color: kBlackColor,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                     ),
//                     SizedBox(height: h(context, 4)),
//                     Row(
//                       children: [
//                         CommonImageView(
//                           imagePath: Assets.imagesLocationicon,
//                           height: 16,
//                           width: 16,
//                           fit: BoxFit.contain,
//                         ),
//                         SizedBox(width: w(context, 4)),
//                         CustomText(
//                           text: item.location,
//                           size: 14,
//                           weight: FontWeight.w500,
//                           color: kBlackColor.withValues(alpha: 0.5),
//                           fontFamily: AppFonts.HelveticaNowDisplay,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: h(context, 8)),
//           CustomText(
//             text: item.description,
//             size: 14,
//             weight: FontWeight.w500,
//             color: kBlackColor.withValues(alpha: 0.5),
//             fontFamily: AppFonts.HelveticaNowDisplay,
//             maxLines: 2,
//             paddingBottom: 10,
//             textOverflow: TextOverflow.ellipsis,
//           ),
//           Divider(
//             color: Color(0xffE3E3E3),
//             thickness: h(context, 1),
//             height: h(context, 1),
//           ),
//           SizedBox(height: h(context, 10)),
//           Row(
//             children: [
//               CustomText(
//                 text: "${item.price}",
//                 size: 18,
//                 weight: FontWeight.w500,
//                 color: kBlackColor,
//                 fontFamily: AppFonts.HelveticaNowDisplay,
//               ),
//               Expanded(
//                 child: CustomText(
//                   text: "/person",
//                   size: 14,
//                   weight: FontWeight.w500,
//                   color: kBlackColor.withValues(alpha: 0.5),
//                   fontFamily: AppFonts.HelveticaNowDisplay,
//                 ),
//               ),
//               InkWell(
//                 onTap: () => controller.selectPlan(item),
//                 child: Container(
//                   height: h(context, 42),
//                   padding: symmetric(context, horizontal: 27),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Color(0xff62D5C3), Color(0xffD7FAB7)],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),

//                     borderRadius: BorderRadius.circular(h(context, 100)),
//                   ),
//                   child: Center(
//                     child: CustomText(
//                       text: "View Details",
//                       size: 16,
//                       weight: FontWeight.w500,
//                       color: kBlackColor,
//                       fontFamily: AppFonts.HelveticaNowDisplay,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/constants/app_fonts.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/view/screens/createplan/create_new_plan.dart';
import 'package:f2g/view/screens/plans/plan_details.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/common_image_view_widget.dart';

class CreatePlanAndMapScreen extends StatefulWidget {
  const CreatePlanAndMapScreen({super.key});

  @override
  State<CreatePlanAndMapScreen> createState() => _CreatePlanAndMapScreenState();
}

class _CreatePlanAndMapScreenState extends State<CreatePlanAndMapScreen> {
  final PlanController controller = Get.put(PlanController());
  late GoogleMapController mapController;

  // final List<Map<String, String>> eventAddresses = [
  //   {
  //     'address': 'Islamabad, Pakistan',
  //     'title': 'Islamabad Event',
  //     'image': Assets.imagesMap,
  //   },
  //   {
  //     'address': 'Karachi, Pakistan',
  //     'title': 'Karachi Event',
  //     'image': Assets.imagesMap,
  //   },
  //   {
  //     'address': 'Peshawar, Pakistan',
  //     'title': 'Peshawar Event',
  //     'image': Assets.imagesMap,
  //   },
  // ];

  final Set<Marker> markers = {};
  LatLng? currentPosition;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.fetchPlans();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    await _setEventMarkers();
    setState(() => isLoading = false);
  }

  // Get user current location
  Future<void> _getCurrentLocation() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPosition = LatLng(position.latitude, position.longitude);
  }

  // Add event markers
  Future<void> _setEventMarkers() async {
    for (var event in controller.plans) {
      try {
        List<Location> locations = await locationFromAddress(event.location!);
        if (locations.isNotEmpty) {
          final loc = locations.first;
          setState(() {
            markers.add(
              Marker(
                markerId: MarkerId(event.location!),
                position: LatLng(loc.latitude, loc.longitude),
                infoWindow: InfoWindow(title: event.title),
                onTap: () => _showEventPopup(event),
              ),
            );
          });
        }
      } catch (e) {
        debugPrint("Error finding location for ${event.location}: $e");
      }
    }
  }

  // Move camera to user current location
  Future<void> _goToMyLocation() async {
    if (currentPosition != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(currentPosition!, 12),
      );
    } else {
      Get.snackbar("Location", "Unable to get current location");
    }
  }

  // Bottom Sheet Popup
  void _showEventPopup(PlanModel model) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kWhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: kBlackColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),

                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CommonImageView(
                        url: model.planPhoto,
                        height: 80,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: model.title ?? "No Title",
                            size: 18,
                            weight: FontWeight.w600,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                          CustomText(
                            paddingTop: 5,
                            text: model.description ?? "No Description",
                            size: 14,
                            weight: FontWeight.w400,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 117,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CustomText(
                            text: "Close",
                            size: 14,
                            weight: FontWeight.w600,
                            color: kBlackColor,
                            fontFamily: AppFonts.HelveticaNowDisplay,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),

                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.close(1);
                          Get.to(
                            () => PlansDetailScreen(),
                            arguments: {"data": model},
                          );
                        },
                        child: Container(
                          height: 40,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            border: Border.all(color: kSecondaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "View Details",
                              size: 14,
                              weight: FontWeight.w600,
                              color: kBlackColor,
                              fontFamily: AppFonts.HelveticaNowDisplay,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              mapController = controller;
              if (currentPosition != null) {
                mapController.animateCamera(
                  CameraUpdate.newLatLngZoom(currentPosition!, 10),
                );
              }
            },
            initialCameraPosition: CameraPosition(
              target:
                  currentPosition ??
                  const LatLng(33.6844, 73.0479), // Default Islamabad
              zoom: 6.5,
            ),
            markers: markers,
          ),
          _buildHeader(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: _goToMyLocation,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  // AppBar-like header
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: h(context, 100),
      width: w(context, double.maxFinite),
      decoration: BoxDecoration(color: kWhiteColor),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: h(context, 10)),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CommonImageView(
                      imagePath: Assets.imagesGreybackicon,
                      height: 48,
                      width: 48,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: w(context, 15)),
                  Expanded(
                    child: CustomText(
                      // text: "Create new plan",
                      text: "Discover Plans",
                      size: 16,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                      fontFamily: AppFonts.HelveticaNowDisplay,
                    ),
                  ),
                  CustomText(
                    text: "Create Plan",
                    size: 16,
                    weight: FontWeight.w500,
                    fontFamily: AppFonts.HelveticaNowDisplay,
                    color: kSecondaryColor,
                    onTap: () {
                      Get.to(() => CreateNewPlanScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
