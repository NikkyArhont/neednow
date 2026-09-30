import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_image_model.dart';
export 'profile_image_model.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({super.key});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  late ProfileImageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileImageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: 160.0,
      height: 160.0,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          if ((currentUserDisplayName == null ||
                  currentUserDisplayName == '') &&
              (currentUserPhoto == null || currentUserPhoto == ''))
            AuthUserStreamWidget(
              builder: (context) => Container(
                width: 160.0,
                height: 160.0,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/EmptyPhoto.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (currentUserPhoto != null && currentUserPhoto != '')
            AuthUserStreamWidget(
              builder: (context) => Container(
                width: 160.0,
                height: 160.0,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  currentUserPhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if ((currentUserDisplayName != null &&
                  currentUserDisplayName != '') &&
              (currentUserPhoto == null || currentUserPhoto == ''))
            AuthUserStreamWidget(
              builder: (context) => Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                  color: FFAppConstants.avatarcolor
                      .elementAtOrNull(FFAppState().colorNumber),
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      functions.firstCharacter(currentUserDisplayName),
                      'E',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).bodyMediumFamily,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          fontSize: 120.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                        ),
                  ),
                ),
              ),
            ),
          Align(
            alignment: AlignmentDirectional(1.0, 1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 4.0),
              child: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 32.0,
                fillColor: FlutterFlowTheme.of(context).primary,
                icon: Icon(
                  FFIcons.kedit,
                  color: FlutterFlowTheme.of(context).info,
                  size: 20.0,
                ),
                onPressed: () async {
                  final selectedMedia = await selectMedia(
                    maxWidth: 1920.00,
                    maxHeight: 1080.00,
                    imageQuality: 60,
                    includeDimensions: true,
                    mediaSource: MediaSource.photoGallery,
                    multiImage: false,
                  );
                  if (selectedMedia != null &&
                      selectedMedia.every(
                          (m) => validateFileFormat(m.storagePath, context))) {
                    safeSetState(
                        () => _model.isDataUploading_uploadDataUz9 = true);
                    var selectedUploadedFiles = <FFUploadedFile>[];

                    var downloadUrls = <String>[];
                    try {
                      selectedUploadedFiles = selectedMedia
                          .map((m) => FFUploadedFile(
                                name: m.storagePath.split('/').last,
                                bytes: m.bytes,
                                height: m.dimensions?.height,
                                width: m.dimensions?.width,
                                blurHash: m.blurHash,
                              ))
                          .toList();

                      downloadUrls = (await Future.wait(
                        selectedMedia.map(
                          (m) async => await uploadData(m.storagePath, m.bytes),
                        ),
                      ))
                          .where((u) => u != null)
                          .map((u) => u!)
                          .toList();
                    } finally {
                      _model.isDataUploading_uploadDataUz9 = false;
                    }
                    if (selectedUploadedFiles.length == selectedMedia.length &&
                        downloadUrls.length == selectedMedia.length) {
                      safeSetState(() {
                        _model.uploadedLocalFile_uploadDataUz9 =
                            selectedUploadedFiles.first;
                        _model.uploadedFileUrl_uploadDataUz9 =
                            downloadUrls.first;
                      });
                    } else {
                      safeSetState(() {});
                      return;
                    }
                  }

                  await currentUserReference!.update(createUserRecordData(
                    photoUrl: _model.uploadedFileUrl_uploadDataUz9,
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
