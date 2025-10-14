// import 'dart:async';
// import 'package:f2g/constants/app_colors.dart';
// import 'package:f2g/controller/my_ctrl/plan_controller.dart';
// import 'package:f2g/model/my_model/plan_model.dart';
// import 'package:f2g/view/screens/Home/filter_bottomshett.dart';
// import 'package:f2g/view/screens/plans/plan_details.dart';
// import 'package:f2g/view/widget/Custom_text_widget.dart';
// import 'package:f2g/view/widget/common_image_view_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../constants/app_fonts.dart';

// class FilterScreenPage extends StatefulWidget {
//   const FilterScreenPage({super.key});

//   @override
//   State<FilterScreenPage> createState() => _FilterScreenPageState();
// }

// class _FilterScreenPageState extends State<FilterScreenPage> {
//   final PlanController planController = Get.find<PlanController>();
//   final FilterController filterController = Get.find<FilterController>();

//   late GoogleMapController mapController;
//   final Set<Marker> markers = {};
//   final Set<Circle> circles = {}; // ✅ Added Circle Set
//   LatLng? currentPosition;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     planController.fetchPlans();
//     _initializeMap();
//   }

//   Future<void> _initializeMap() async {
//     await _getCurrentLocation();
//     await _setFilteredMarkers();
//     _setRadiusCircle(); // ✅ Draw circle after everything loaded
//     setState(() => isLoading = false);
//   }

//   // Get user current location
//   Future<void> _getCurrentLocation() async {
//     LocationPermission permission;
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return;
//     }
//     if (permission == LocationPermission.deniedForever) return;

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     currentPosition = LatLng(position.latitude, position.longitude);
//   }

//   // Calculate distance in KM between two LatLngs
//   double _calculateDistance(LatLng start, LatLng end) {
//     return Geolocator.distanceBetween(
//           start.latitude,
//           start.longitude,
//           end.latitude,
//           end.longitude,
//         ) /
//         1000; // Convert to KM
//   }

//   // Set markers only for filtered events
//   Future<void> _setFilteredMarkers() async {
//     final ageRange = filterController.ageRange.value;
//     final peopleRange = filterController.peopleRange.value;
//     final distanceRange = filterController.distanceRange.value;

//     for (var event in planController.plans) {
//       try {
//         if (event.location == null) continue;
//         List<Location> locations = await locationFromAddress(event.location!);
//         if (locations.isEmpty) continue;

//         final loc = locations.first;
//         final eventPos = LatLng(loc.latitude, loc.longitude);
//         final distance = _calculateDistance(currentPosition!, eventPos);

//         int eventAge = int.tryParse(event.age?.toString() ?? '0') ?? 0;
//         int eventPeople =
//             int.tryParse(event.maxMembers?.toString() ?? '0') ?? 0;

//         final withinAge =
//             eventAge >= ageRange.start && eventAge <= ageRange.end;
//         final withinPeople =
//             eventPeople >= peopleRange.start && eventPeople <= peopleRange.end;
//         final withinDistance =
//             distance >= distanceRange.start && distance <= distanceRange.end;

//         if (withinAge && withinPeople && withinDistance) {
//           setState(() {
//             markers.add(
//               Marker(
//                 markerId: MarkerId(event.id ?? event.title ?? ''),
//                 position: eventPos,
//                 infoWindow: InfoWindow(title: event.title),
//                 onTap: () => _showEventPopup(event),
//               ),
//             );
//           });
//         }
//       } catch (e) {
//         debugPrint("Error filtering location: $e");
//       }
//     }
//   }

//   // ✅ Draw radius circle on the map
//   void _setRadiusCircle() {
//     if (currentPosition == null) return;

//     final distanceRange = filterController.distanceRange.value;
//     final double radiusKm = distanceRange.end; // Use max distance from filter

//     setState(() {
//       circles.clear();
//       circles.add(
//         Circle(
//           circleId: const CircleId("search_radius"),
//           center: currentPosition!,
//           radius: radiusKm * 1000, // convert to meters
//           fillColor: Colors.blue.withOpacity(0.15),
//           strokeColor: Colors.blueAccent,
//           strokeWidth: 2,
//         ),
//       );
//     });
//   }

//   // Show event details popup
//   void _showEventPopup(PlanModel model) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: kWhiteColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder:
//           (_) => Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 60,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: CommonImageView(
//                         url: model.planPhoto,
//                         height: 80,
//                         width: 120,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(
//                             text: model.title ?? "No Title",
//                             size: 18,
//                             weight: FontWeight.w600,
//                             color: kBlackColor,
//                             fontFamily: AppFonts.HelveticaNowDisplay,
//                           ),
//                           CustomText(
//                             paddingTop: 5,
//                             text: model.description ?? "No Description",
//                             size: 14,
//                             weight: FontWeight.w400,
//                             color: kBlackColor,
//                             fontFamily: AppFonts.HelveticaNowDisplay,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: kSecondaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     minimumSize: const Size(double.infinity, 45),
//                   ),
//                   onPressed: () {
//                     Get.back();
//                     Get.to(
//                       () => PlansDetailScreen(),
//                       arguments: {"data": model},
//                     );
//                   },
//                   child: const Text(
//                     "View Details",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//     );
//   }

//   // Center camera to my location
//   Future<void> _goToMyLocation() async {
//     if (currentPosition != null) {
//       mapController.animateCamera(
//         CameraUpdate.newLatLngZoom(currentPosition!, 12),
//       );
//       _setRadiusCircle(); // ✅ Re-draw circle when user taps button
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       appBar: AppBar(
//         backgroundColor: kWhiteColor,
//         title: const Text(
//           "Filtered Events on Map",
//           style: TextStyle(color: Colors.black),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black),
//         elevation: 0,
//       ),
//       body: GoogleMap(
//         myLocationEnabled: true,
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         onMapCreated: (controller) {
//           mapController = controller;
//           if (currentPosition != null) {
//             mapController.animateCamera(
//               CameraUpdate.newLatLngZoom(currentPosition!, 10),
//             );
//           }
//         },
//         initialCameraPosition: CameraPosition(
//           target: currentPosition ?? const LatLng(33.6844, 73.0479),
//           zoom: 6.5,
//         ),
//         markers: markers,
//         circles: circles, // ✅ Added circles here
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: kSecondaryColor,
//         onPressed: _goToMyLocation,
//         child: const Icon(Icons.my_location, color: Colors.white),
//       ),
//     );
//   }
// }

// ---------- FIlter Correct Plans -----------------

import 'dart:async';
import 'package:f2g/constants/app_colors.dart';
import 'package:f2g/controller/my_ctrl/plan_controller.dart';
import 'package:f2g/model/my_model/plan_model.dart';
import 'package:f2g/view/screens/Home/filter_bottomshett.dart';
import 'package:f2g/view/screens/plans/plan_details.dart';
import 'package:f2g/view/widget/Custom_text_widget.dart';
import 'package:f2g/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constants/app_fonts.dart';

class FilterScreenPage extends StatefulWidget {
  const FilterScreenPage({super.key});

  @override
  State<FilterScreenPage> createState() => _FilterScreenPageState();
}

class _FilterScreenPageState extends State<FilterScreenPage> {
  final PlanController planController = Get.find<PlanController>();
  final FilterController filterController = Get.find<FilterController>();

  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Circle> circles = {}; // ✅ Added Circle Set
  LatLng? currentPosition;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    planController.fetchPlans();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    await _applyFilters(); // ✅ unified filter+marker loading
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

  // Calculate distance in KM between two LatLngs
  double _calculateDistance(LatLng start, LatLng end) {
    return Geolocator.distanceBetween(
          start.latitude,
          start.longitude,
          end.latitude,
          end.longitude,
        ) /
        1000; // Convert to KM
  }

  // ✅ Main function to apply filters and refresh map markers
  Future<void> _applyFilters() async {
    if (currentPosition == null) return;

    final ageRange = filterController.ageRange.value;
    final peopleRange = filterController.peopleRange.value;
    final distanceRange = filterController.distanceRange.value;

    Set<Marker> newMarkers = {}; // ✅ use new Set
    Set<Circle> newCircles = {};

    for (var event in planController.plans) {
      try {
        if (event.location == null) continue;

        // Convert address to coordinates
        List<Location> locations = await locationFromAddress(event.location!);
        if (locations.isEmpty) continue;

        final loc = locations.first;
        final eventPos = LatLng(loc.latitude, loc.longitude);
        final distance = _calculateDistance(currentPosition!, eventPos);

        int eventAge = int.tryParse(event.age?.toString() ?? '0') ?? 0;
        int eventPeople =
            int.tryParse(event.maxMembers?.toString() ?? '0') ?? 0;

        final withinAge =
            eventAge >= ageRange.start && eventAge <= ageRange.end;
        final withinPeople =
            eventPeople >= peopleRange.start && eventPeople <= peopleRange.end;
        final withinDistance =
            distance >= distanceRange.start && distance <= distanceRange.end;

        if (withinAge && withinPeople && withinDistance) {
          newMarkers.add(
            Marker(
              markerId: MarkerId(event.id ?? event.title ?? ''),
              position: eventPos,
              infoWindow: InfoWindow(title: event.title),
              onTap: () => _showEventPopup(event),
            ),
          );
        }
      } catch (e) {
        debugPrint("Error filtering location: $e");
      }
    }

    // ✅ Add radius circle after filtering
    newCircles.add(
      Circle(
        circleId: const CircleId("search_radius"),
        center: currentPosition!,
        radius: distanceRange.end * 1000, // max distance (in meters)
        // fillColor: Colors.blue.withOpacity(0.15),
        fillColor: kSecondaryColor.withValues(alpha: 0.15),
        // strokeColor: Colors.blueAccent,
        strokeColor: kSecondaryColor,
        strokeWidth: 2,
      ),
    );

    // ✅ Update UI once at end (no partial setStates)
    setState(() {
      markers = newMarkers;
      circles = newCircles;
    });
  }

  // Show event details popup
  void _showEventPopup(PlanModel model) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kWhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.to(
                      () => PlansDetailScreen(),
                      arguments: {"data": model},
                    );
                  },
                  child: const Text(
                    "View Details",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
    );
  }

  // Center camera to my location
  Future<void> _goToMyLocation() async {
    if (currentPosition != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(currentPosition!, 12),
      );
      await _applyFilters(); // ✅ Reapply filters & redraw circle when pressed
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: CustomText(
          text: "Filter Plans",
          size: 16,
          weight: FontWeight.w500,
          color: kBlackColor,
          fontFamily: AppFonts.HelveticaNowDisplay,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: GoogleMap(
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
          target: currentPosition ?? const LatLng(33.6844, 73.0479),
          zoom: 6.5,
        ),
        markers: markers,
        circles: circles,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        onPressed: _goToMyLocation,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
