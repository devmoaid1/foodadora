import 'package:flutter/material.dart';
import 'package:foodadora/core/providers/connectivity/connectivity_service.dart';
import 'package:foodadora/core/widgets/noconnection_indicator.dart';
import 'package:provider/provider.dart';

class InternetConnectionWrapper extends StatelessWidget {
  final Widget screen;
  const InternetConnectionWrapper({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    if (!context.watch<ConnectivityService>().isConnected) {
      return const NoConnection();
    }

    return screen;
  }
}
