import 'package:flutter/widgets.dart';
import 'app_colors.dart';

double h(BuildContext context, double value) {
  return MediaQuery.of(context).size.height * value * 0.0013;
}

double w(BuildContext context, double value) {
  return MediaQuery.of(context).size.width * value * 0.00255;
}

EdgeInsets symmetric(
  BuildContext context, {
  double vertical = 0,
  double horizontal = 0,
}) {
  return EdgeInsets.symmetric(
    vertical: h(context, vertical),
    horizontal: w(context, horizontal),
  );
}

EdgeInsets all(BuildContext context, double value) {
  return EdgeInsets.all(w(context, value));
}

EdgeInsets only(
  BuildContext context, {
  double top = 0,
  double right = 0,
  double bottom = 0,
  double left = 0,
}) {
  return EdgeInsets.fromLTRB(
    w(context, left),
    h(context, top),
    w(context, right),
    h(context, bottom),
  );
}

double f(BuildContext context, double value) {
  return MediaQuery.of(context).size.shortestSide * value * 0.0025;
}

BoxDecoration navBarDecoration({Color color = kPrimaryColor}) {
  return BoxDecoration(
    color: color,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );
}

// class AppStyling {
//   BoxDecoration navBarDecoration({Color color = kTertiaryColor}) {
//     return BoxDecoration(
//       color: color,
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//     );
//   }
// }
