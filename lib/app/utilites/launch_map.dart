import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:url_launcher/url_launcher.dart';

Future launchMap(GeoPoint location) async {
  final String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';
  final String appleUrl =
      'https://maps.apple.com/?q=${location.latitude},${location.longitude}';
  final String wazeUrl =
      'https://waze.com/ul?ll=${location.latitude},${location.longitude}';

  if (await canLaunch("comgooglemaps://")) {
    await launch(googleUrl);
  } else if (await canLaunch("http://maps.apple.com")) {
    await launch(appleUrl);
  } else if (await canLaunch("waze://")) {
    await launch(wazeUrl);
  } else if (await canLaunch("https://www.google.com/maps")) {
    await launch(googleUrl);
  } else {
    dialogService.showDialog(
      title: 'Error',
      description: 'Could not open in maps!',
    );
  }
}
