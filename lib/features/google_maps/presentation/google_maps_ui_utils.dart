import 'package:flutter/material.dart';

import '../cubits/google_maps_integration_cubit/google_maps_integration_cubit.dart';

class GoogleMapsUiUtils {
  const GoogleMapsUiUtils._();

  static Future<String?> showApiKeyDialog(
    BuildContext context,
    PlatformConfig platform,
  ) async {
    TextEditingController controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Google Maps API Key for ${platform.name}'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter API Key',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter API-KEY')),
                  );
                  return;
                }
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
