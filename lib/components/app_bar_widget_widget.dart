import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidgetWidget extends StatefulWidget {
  const AppBarWidgetWidget({Key key}) : super(key: key);

  @override
  _AppBarWidgetWidgetState createState() => _AppBarWidgetWidgetState();
}

class _AppBarWidgetWidgetState extends State<AppBarWidgetWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        'EVENT DETAILS',
        style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Lexend Deca',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: Icon(
            Icons.mode_edit,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
      centerTitle: true,
      elevation: 0,
    );
  }
}
