import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../login/login_widget.dart';
import '../../register/register_widget.dart';
import '../../complete_profile/complete_profile_widget.dart';
import '../../forgot_password/forgot_password_widget.dart';
import '../../chat_details/chat_details_widget.dart';
import '../../edit_profile/edit_profile_widget.dart';
import '../../my_profil_details/my_profil_details_widget.dart';
import '../../change_password/change_password_widget.dart';
import '../../create_event/create_event_widget.dart';
import '../../event_post_success/event_post_success_widget.dart';
import '../../my_events/my_events_widget.dart';
import '../../event_details_new/event_details_new_widget.dart';
import '../../event_category/event_category_widget.dart';
import '../../edit_event/edit_event_widget.dart';
import '../../event_post_update_success/event_post_update_success_widget.dart';
import '../../r_s_v_p_succes/r_s_v_p_succes_widget.dart';

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler(
      {Key key, this.handlePushNotification, this.child})
      : super(key: key);

  final Function(BuildContext) handlePushNotification;
  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    setState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Center(
            child: Builder(
              builder: (context) => Image.asset(
                'assets/images/splash.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                fit: BoxFit.fill,
              ),
            ),
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'Login': (data) async => LoginWidget(),
  'Register': (data) async => RegisterWidget(),
  'completeProfile': (data) async => CompleteProfileWidget(),
  'forgotPassword': (data) async => ForgotPasswordWidget(),
  'MyFriends': (data) async => NavBarPage(initialPage: 'MyFriendsWidget'),
  'chatMain': (data) async => NavBarPage(initialPage: 'ChatMainWidget'),
  'chatDetails': (data) async => ChatDetailsWidget(
        chatUser: await getDocumentParameter(
            data, 'chatUser', UsersRecord.serializer),
        chatRef: getParameter(data, 'chatRef'),
      ),
  'myProfile': (data) async => NavBarPage(initialPage: 'MyProfileWidget'),
  'editProfile': (data) async => EditProfileWidget(
        userEmail: await getDocumentParameter(
            data, 'userEmail', UsersRecord.serializer),
        userDisplay: await getDocumentParameter(
            data, 'userDisplay', UsersRecord.serializer),
        userPhoto: getParameter(data, 'userPhoto'),
      ),
  'myProfilDetails': (data) async => MyProfilDetailsWidget(
        userDetails: getParameter(data, 'userDetails'),
      ),
  'changePassword': (data) async => ChangePasswordWidget(),
  'createEvent': (data) async => CreateEventWidget(
        userinfo: await getDocumentParameter(
            data, 'userinfo', UsersRecord.serializer),
      ),
  'eventPostSuccess': (data) async => EventPostSuccessWidget(),
  'MyEvents': (data) async => MyEventsWidget(),
  'eventDetailsNew': (data) async => EventDetailsNewWidget(
        eventDetails: getParameter(data, 'eventDetails'),
        chatUser: await getDocumentParameter(
            data, 'chatUser', UsersRecord.serializer),
      ),
  'EventCategory': (data) async => EventCategoryWidget(),
  'EditEvent': (data) async => EditEventWidget(
        eventDetails: getParameter(data, 'eventDetails'),
      ),
  'eventPostUpdateSuccess': (data) async => EventPostUpdateSuccessWidget(),
  'RSVPSucces': (data) async => RSVPSuccesWidget(),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
