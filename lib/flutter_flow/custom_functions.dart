import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

LatLng getInitialMapLocation(LatLng userLocation) {
  if (userLocation == null ||
      (userLocation.latitude == 0 && userLocation.longitude == 0)) {
    return const LatLng(18.0956097, -33.9142688);
  }
  return userLocation;
}

String getMapUrl(LatLng location) {
  return 'https://www.google.com/maps/search/?api=1&'
      'query=${location.latitude},${location.longitude}';
}

int likes(EventpostsRecord eventpost) {
  return eventpost.likes.length;
}

int follows(UsersRecord userfollows) {
  return userfollows.follows.length;
}

int following(UsersRecord userfollowing) {
  return userfollowing.following.length;
}

int eventfollows(EventpostsRecord followevent) {
  return followevent.eventfollows.length;
}

bool showEvent(bool visible) {
  return visible = false;
}
