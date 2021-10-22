import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';

LatLng getInitialMapLocation(LatLng userLocation) {
  if (userLocation == null ||
      (userLocation.latitude == 0 && userLocation.longitude == 0)) {
    return LatLng(18.0956097, -33.9142688);
  }
  return userLocation;
}

String getMapUrl(LatLng location) {
  return 'https://www.google.com/maps/search/?api=1&'
      'query=${location.latitude},${location.longitude}';
}
