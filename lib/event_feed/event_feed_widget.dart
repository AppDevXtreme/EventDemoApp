import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/bottom_sheet1_widget.dart';
import '../create_event/create_event_widget.dart';
import '../flutter_flow/flutter_flow_google_map.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EventFeedWidget extends StatefulWidget {
  const EventFeedWidget({Key key}) : super(key: key);

  @override
  _EventFeedWidgetState createState() => _EventFeedWidgetState();
}

class _EventFeedWidgetState extends State<EventFeedWidget> {
  LatLng currentUserLocationValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng googleMapsCenter;
  Completer<GoogleMapController> googleMapsController;
  List<EventpostsRecord> algoliaSearchResults1 = [];
  TextEditingController textController;
  List<EventpostsRecord> algoliaSearchResults2 = [];

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
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
    return FutureBuilder<List<EventpostsRecord>>(
      future: EventpostsRecord.search(
        term: '*',
        location: getCurrentUserLocation(
            defaultLocation: LatLng(37.4298229, -122.1735655)),
      ),
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
        List<EventpostsRecord> eventFeedEventpostsRecordList = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFEFEFEF),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('AddEvent pressed ...');
            },
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            elevation: 8,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 500),
                        reverseDuration: Duration(milliseconds: 500),
                        child: CreateEventWidget(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 108,
                    decoration: BoxDecoration(
                      color: Color(0xFF090F13),
                      shape: BoxShape.rectangle,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 45, 24, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: Text(
                                      'Hello',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 10, 0, 0),
                                    child: AuthUserStreamWidget(
                                      child: Text(
                                        currentUserDisplayName,
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .title2
                                            .override(
                                              fontFamily: 'Lexend Deca',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                            ),
                                      ),
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
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(),
                        child: FlutterFlowGoogleMap(
                          controller: googleMapsController,
                          onCameraIdle: (latLng) =>
                              setState(() => googleMapsCenter = latLng),
                          initialLocation: googleMapsCenter ??= functions
                              .getInitialMapLocation(currentUserLocationValue),
                          markers: (eventFeedEventpostsRecordList ?? [])
                              .map(
                                (eventFeedEventpostsRecord) =>
                                    FlutterFlowMarker(
                                  eventFeedEventpostsRecord.reference.path,
                                  eventFeedEventpostsRecord.location,
                                  () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Color(0xFF2E2E2E),
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: Container(
                                            height: 250,
                                            child: BottomSheet1Widget(
                                              eventPost:
                                                  eventFeedEventpostsRecord
                                                      .reference,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              )
                              .toList(),
                          markerColor: GoogleMarkerColor.violet,
                          mapType: MapType.normal,
                          style: GoogleMapStyle.standard,
                          initialZoom: 12,
                          allowInteraction: true,
                          allowZoom: true,
                          showZoomControls: false,
                          showLocation: true,
                          showCompass: false,
                          showMapToolbar: false,
                          showTraffic: false,
                          centerMapOnMarkerTap: true,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: Color(0x4E000000),
                                    offset: Offset(0, 4),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFEEEEEE),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: TextFormField(
                                          onFieldSubmitted: (_) async {
                                            currentUserLocationValue =
                                                await getCurrentUserLocation(
                                                    defaultLocation:
                                                        LatLng(0.0, 0.0));
                                            setState(() =>
                                                algoliaSearchResults1 = null);
                                            await EventpostsRecord.search(
                                              term: valueOrDefault<String>(
                                                textController.text,
                                                '*',
                                              ),
                                              location: getCurrentUserLocation(
                                                  defaultLocation: LatLng(
                                                      37.4298229,
                                                      -122.1735655)),
                                            )
                                                .then((r) =>
                                                    algoliaSearchResults1 = r)
                                                .onError((_, __) =>
                                                    algoliaSearchResults1 = [])
                                                .whenComplete(
                                                    () => setState(() {}));
                                          },
                                          controller: textController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Search events here...',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.95, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() =>
                                                algoliaSearchResults2 = null);
                                            await EventpostsRecord.search(
                                              term: textController.text,
                                            )
                                                .then((r) =>
                                                    algoliaSearchResults2 = r)
                                                .onError((_, __) =>
                                                    algoliaSearchResults2 = [])
                                                .whenComplete(
                                                    () => setState(() {}));
                                          },
                                          child: Icon(
                                            Icons.search_rounded,
                                            color: Color(0xFF95A1AC),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
