import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/loading_indicator.dart';
import '../cubits/google_maps_integration_cubit/google_maps_integration_cubit.dart';
import '../data/models/google_maps_platform_config.dart';
import 'google_maps_ui_utils.dart';

class GoogleMapsIntegrationBox extends StatelessWidget {
  const GoogleMapsIntegrationBox({super.key, required this.projectPath});

  final String projectPath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleMapsIntegrationCubit()..integrate(projectPath),
      child:
          BlocConsumer<GoogleMapsIntegrationCubit, GoogleMapsIntegrationState>(
            listener: (context, state) => handleStateUpdate(context, state),
            builder: (context, state) {
              if (state is GoogleMapsFailure) {
                return Text(state.error);
              }

              if (state is GoogleMapsSuccess) {
                return Text('Successfully integrated Google Maps SDK');
              }
              return LoadingIndicator();
            },
          ),
    );
  }

  void handleStateUpdate(
    BuildContext context,
    GoogleMapsIntegrationState state,
  ) async {
    if (state is GoogleMapsKeyNeeded) {
      final result = await GoogleMapsUiUtils.showApiKeyDialog(
        context,
        state.platform,
      );

      if ((result?.isNotEmpty ?? false) && context.mounted) {
        context
            .read<GoogleMapsIntegrationCubit>()
            .continueIntegrationWithPlatformApiKey(
              GoogleMapsPlatformConfig(
                apiKey: result!,
                platform: state.platform,
                path: projectPath,
              ),
            );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Couldn't integrate without API-KEY")),
        );
      }
    }
  }
}
