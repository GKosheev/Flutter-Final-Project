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
import 'mainpage_model.dart';
export 'mainpage_model.dart';

class MainpageWidget extends StatefulWidget {
  const MainpageWidget({Key? key}) : super(key: key);

  @override
  _MainpageWidgetState createState() => _MainpageWidgetState();
}

class _MainpageWidgetState extends State<MainpageWidget> {
  late MainpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainpageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<UsersRecord>>(
        stream: queryUsersRecord(
          queryBuilder: (usersRecord) => usersRecord
              .where('gender',
                  isEqualTo:
                      valueOrDefault(currentUserDocument?.desiredGender, ''))
              .whereNotIn(
                  'uid',
                  functions.combineLists(
                      (currentUserDocument?.matches?.toList() ?? []).toList(),
                      (currentUserDocument?.rejected?.toList() ?? [])
                          .toList())),
          singleRecord: true,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
            );
          }
          List<UsersRecord> mainpageUsersRecordList =
              snapshot.data!.where((u) => u.uid != currentUserUid).toList();
          final mainpageUsersRecord = mainpageUsersRecordList.isNotEmpty
              ? mainpageUsersRecordList.first
              : null;
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              title: Text(
                'Main Page',
                style: FlutterFlowTheme.of(context).headlineMedium,
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Stack(
              children: [
                if (mainpageUsersRecord != null)
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.network(
                              mainpageUsersRecord!.photoUrl!,
                              width: MediaQuery.of(context).size.width * 1.0,
                              height: 230.0,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 12.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  mainpageUsersRecord!.displayName!,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 4.0, 20.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  mainpageUsersRecord!.location!,
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  mainpageUsersRecord!.age!.toString(),
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 24.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final usersUpdateData = {
                                    'rejected': FieldValue.arrayUnion(
                                        [mainpageUsersRecord!.uid]),
                                  };
                                  await currentUserReference!
                                      .update(usersUpdateData);
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                      reverseDuration:
                                          Duration(milliseconds: 0),
                                      child:
                                          NavBarPage(initialPage: 'Mainpage'),
                                    ),
                                  );
                                },
                                text: 'REJECT',
                                options: FFButtonOptions(
                                  width: 100.0,
                                  height: 60.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0xFFFF0000),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 24.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final usersUpdateData = {
                                    'matches': FieldValue.arrayUnion(
                                        [mainpageUsersRecord!.uid]),
                                  };
                                  await currentUserReference!
                                      .update(usersUpdateData);
                                  if (mainpageUsersRecord!.matches!
                                      .toList()
                                      .contains(currentUserUid)) {
                                    final chatsCreateData = {
                                      ...createChatsRecordData(
                                        userA: mainpageUsersRecord!.reference,
                                        userB: currentUserReference,
                                        lastMessage: '\"\"',
                                        lastMessageTime: getCurrentTimestamp,
                                      ),
                                      'users': functions.createChatUserList(
                                          mainpageUsersRecord!.reference,
                                          currentUserReference!),
                                    };
                                    await ChatsRecord.collection
                                        .doc()
                                        .set(chatsCreateData);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Congratulations! You have a new match!',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: Color(0x00000000),
                                      ),
                                    );
                                    await Future.delayed(
                                        const Duration(milliseconds: 3000));
                                  }
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                      reverseDuration:
                                          Duration(milliseconds: 0),
                                      child:
                                          NavBarPage(initialPage: 'Mainpage'),
                                    ),
                                  );
                                },
                                text: 'MATCH',
                                options: FFButtonOptions(
                                  width: 100.0,
                                  height: 60.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0xFF057400),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (!(mainpageUsersRecord != null))
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: wrapWithModel(
                          model: _model.emptyMatchesModel,
                          updateCallback: () => setState(() {}),
                          child: EmptyMatchesWidget(),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
