import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'photo_upload_job_widget.dart' show PhotoUploadJobWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhotoUploadJobModel extends FlutterFlowModel<PhotoUploadJobWidget> {
  ///  Local state fields for this component.

  List<FFUploadedFile> ploadedMedia = [];
  void addToPloadedMedia(FFUploadedFile item) => ploadedMedia.add(item);
  void removeFromPloadedMedia(FFUploadedFile item) => ploadedMedia.remove(item);
  void removeAtIndexFromPloadedMedia(int index) => ploadedMedia.removeAt(index);
  void insertAtIndexInPloadedMedia(int index, FFUploadedFile item) =>
      ploadedMedia.insert(index, item);
  void updatePloadedMediaAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      ploadedMedia[index] = updateFn(ploadedMedia[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
