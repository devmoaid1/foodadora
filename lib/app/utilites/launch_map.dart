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

  if (await canLaunchUrl(Uri.parse("comgooglemaps://"))) {
    await launchUrl(Uri.parse(googleUrl));
  } else if (await canLaunchUrl(Uri.parse("http://maps.apple.com"))) {
    await launchUrl(Uri.parse(appleUrl));
  } else if (await canLaunchUrl(Uri.parse("waze://"))) {
    await launchUrl(Uri.parse(wazeUrl));
  } else if (await canLaunchUrl(Uri.parse("https://www.google.com/maps"))) {
    await launchUrl(Uri.parse(googleUrl));
  } else {
    dialogService.showDialog(
      title: 'Error',
      description: 'Could not open in maps!',
    );
  }
}
