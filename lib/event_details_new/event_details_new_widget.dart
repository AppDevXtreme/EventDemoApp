import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../chat_details/chat_details_widget.dart';
import '../components/post_edit_delete_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../r_s_v_p_succes/r_s_v_p_succes_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailsNewWidget extends StatefulWidget {
  const EventDetailsNewWidget({
    Key key,
    this.eventDetails,
    this.chatUser,
  }) : super(key: key);

  final DocumentReference eventDetails;
  final UsersRecord chatUser;

  @override
  _EventDetailsNewWidgetState createState() => _EventDetailsNewWidgetState();
}

class _EventDetailsNewWidgetState extends State<EventDetailsNewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EventpostsRecord>(
      stream: EventpostsRecord.getDocument(widget.eventDetails),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
          );
        }
        final eventDetailsNewEventpostsRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFF090F13),
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            title: Text(
              'Event Details',
              style: FlutterFlowTheme.title2.override(
                fontFamily: 'Lexend Deca',
                color: FlutterFlowTheme.primaryColor,
              ),
            ),
            actions: [
              Visibility(
                visible: (eventDetailsNewEventpostsRecord.userID) ==
                    (currentUserUid),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                  child: InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              height: 250,
                              child: PostEditDeleteWidget(
                                eventPostEdit: eventDetailsNewEventpostsRecord,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.mode_edit,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: Color(0xFF262D34),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: eventDetailsNewEventpostsRecord
                                          .coverimage,
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 12, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ToggleIcon(
                                        onPressed: () async {
                                          final likesElement =
                                              currentUserReference;
                                          final likesUpdate =
                                              eventDetailsNewEventpostsRecord
                                                      .likes
                                                      .toList()
                                                      .contains(likesElement)
                                                  ? FieldValue.arrayRemove(
                                                      [likesElement])
                                                  : FieldValue.arrayUnion(
                                                      [likesElement]);
                                          final eventpostsUpdateData = {
                                            'likes': likesUpdate,
                                          };
                                          await eventDetailsNewEventpostsRecord
                                              .reference
                                              .update(eventpostsUpdateData);
                                        },
                                        value: eventDetailsNewEventpostsRecord
                                            .likes
                                            .toList()
                                            .contains(currentUserReference),
                                        onIcon: Icon(
                                          Icons.star_sharp,
                                          color: FlutterFlowTheme.primaryColor,
                                          size: 25,
                                        ),
                                        offIcon: Icon(
                                          Icons.star_outline,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 0),
                                        child: Text(
                                          functions
                                              .likes(
                                                  eventDetailsNewEventpostsRecord)
                                              .toString(),
                                          style: FlutterFlowTheme.bodyText1,
                                        ),
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.commentDots,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 20, 0),
                                        child: Text(
                                          eventDetailsNewEventpostsRecord
                                              .comments
                                              .toString(),
                                          style: FlutterFlowTheme.bodyText1,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 25, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                reverseDuration:
                                                    Duration(milliseconds: 500),
                                                child: ChatDetailsWidget(
                                                  chatUser: widget.chatUser,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.mark_chat_unread,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 20, 0),
                                        child: FaIcon(
                                          FontAwesomeIcons.shareAlt,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 12, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 10),
                                          child: Text(
                                            eventDetailsNewEventpostsRecord
                                                .eventname,
                                            style: FlutterFlowTheme.title2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 4, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hosted By:',
                                        textAlign: TextAlign.start,
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          eventDetailsNewEventpostsRecord
                                              .hostedBy,
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFFDBE2E7),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Start Date:',
                                        textAlign: TextAlign.start,
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          dateTimeFormat(
                                              'yMMMd',
                                              eventDetailsNewEventpostsRecord
                                                  .date),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFFDBE2E7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Time:',
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          dateTimeFormat(
                                              'jm',
                                              eventDetailsNewEventpostsRecord
                                                  .date),
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFFDBE2E7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'End Date:',
                                        textAlign: TextAlign.start,
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: Text(
                                          dateTimeFormat(
                                              'yMMMd',
                                              eventDetailsNewEventpostsRecord
                                                  .endDate),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.subtitle2
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFFDBE2E7),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Location:',
                                        textAlign: TextAlign.start,
                                        style:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await launchURL(functions.getMapUrl(
                                                eventDetailsNewEventpostsRecord
                                                    .location));
                                          },
                                          child: Text(
                                            eventDetailsNewEventpostsRecord
                                                .locationName,
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFFDBE2E7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 12, 20, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 15, 0, 15),
                                          child: Text(
                                            eventDetailsNewEventpostsRecord
                                                .description,
                                            style: FlutterFlowTheme.bodyText2
                                                .override(
                                              fontFamily: 'Lexend Deca',
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 24),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      final bookedEventsCreateData =
                                          createBookedEventsRecordData(
                                        eventName:
                                            eventDetailsNewEventpostsRecord
                                                .eventname,
                                        eventDescription:
                                            eventDetailsNewEventpostsRecord
                                                .description,
                                        eventhosted:
                                            eventDetailsNewEventpostsRecord
                                                .hostedBy,
                                        eventDate:
                                            eventDetailsNewEventpostsRecord
                                                .date,
                                        bookedUID: currentUserUid,
                                      );
                                      await BookedEventsRecord.collection
                                          .doc()
                                          .set(bookedEventsCreateData);
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 500),
                                          reverseDuration:
                                              Duration(milliseconds: 500),
                                          child: RSVPSuccesWidget(),
                                        ),
                                      );
                                    },
                                    text: 'RSVP',
                                    options: FFButtonOptions(
                                      width: 300,
                                      height: 60,
                                      color: FlutterFlowTheme.primaryColor,
                                      textStyle:
                                          FlutterFlowTheme.title3.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
