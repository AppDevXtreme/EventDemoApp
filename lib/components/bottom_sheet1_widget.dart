import '../backend/backend.dart';
import '../event_details_new/event_details_new_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheet1Widget extends StatefulWidget {
  const BottomSheet1Widget({
    Key key,
    this.eventPost,
  }) : super(key: key);

  final DocumentReference eventPost;

  @override
  _BottomSheet1WidgetState createState() => _BottomSheet1WidgetState();
}

class _BottomSheet1WidgetState extends State<BottomSheet1Widget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        StreamBuilder<EventpostsRecord>(
          stream: EventpostsRecord.getDocument(widget.eventPost),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
              );
            }
            final containerEventpostsRecord = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).dark900,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0x6E090F13),
                    offset: Offset(0, -4),
                    spreadRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.circular(0),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: StreamBuilder<EventpostsRecord>(
                      stream: EventpostsRecord.getDocument(
                          containerEventpostsRecord.reference),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }
                        final rowEventpostsRecord = snapshot.data;
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    containerEventpostsRecord.profileimage,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                containerEventpostsRecord.eventname,
                                style: FlutterFlowTheme.of(context).title2,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              containerEventpostsRecord.description,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color:
                                        FlutterFlowTheme.of(context).grayIcon,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: FlutterFlowTheme.of(context).grayIcon,
                          size: 24,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: Text(
                            functions
                                .likes(containerEventpostsRecord)
                                .toString(),
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: 'Reject',
                          options: FFButtonOptions(
                            width: 130,
                            height: 50,
                            color: FlutterFlowTheme.of(context).background,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 8,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 500),
                                reverseDuration: Duration(milliseconds: 500),
                                child: EventDetailsNewWidget(
                                  eventDetails:
                                      containerEventpostsRecord.reference,
                                ),
                              ),
                            );
                          },
                          text: 'View',
                          options: FFButtonOptions(
                            width: 130,
                            height: 50,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
