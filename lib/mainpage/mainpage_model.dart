import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_matches_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/main.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainpageModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for emptyMatches component.
  late EmptyMatchesModel emptyMatchesModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    emptyMatchesModel = createModel(context, () => EmptyMatchesModel());
  }

  void dispose() {
    emptyMatchesModel.dispose();
  }

  /// Additional helper methods are added here.

}
