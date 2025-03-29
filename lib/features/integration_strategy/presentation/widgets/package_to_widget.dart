import 'package:flutter/material.dart';

import '../../../../common/supported_package.dart';
import '../../../google_maps/presentation/google_maps_integration_box.dart';

class PackageToWidget extends StatelessWidget {
  const PackageToWidget({super.key, required this.package, required this.path});
  final SupportedPackage? package;
  final String path;

  @override
  Widget build(BuildContext context) {
    switch (package) {
      case SupportedPackage.googleMaps:
        return GoogleMapsIntegrationBox(projectPath: path);
      default:
        return SizedBox();
    }
  }
}
