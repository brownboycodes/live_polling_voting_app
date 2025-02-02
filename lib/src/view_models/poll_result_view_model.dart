import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';

class PollResultViewModel {
  static final PollResultViewModel _singleton =
      PollResultViewModel._internal();

  factory PollResultViewModel() {
    return _singleton;
  }

  PollResultViewModel._internal();

  Future<void> takeScreenShot(GlobalKey screenshotArea, String fileName) async {
    final boundary = screenshotArea.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
      if(pngBytes!=null)  {
      final result = await Share.shareXFiles(
          [XFile.fromData(pngBytes, mimeType: 'image/png')],
          fileNameOverrides: ['$fileName.png']);
      if (result.status == ShareResultStatus.success) {
        if(kDebugMode) {
          debugPrint('sharing the picture');
        }
      } else if (result.status == ShareResultStatus.dismissed) {
       if(kDebugMode) {
          debugPrint('the picture could not be shared');
        }
      }
    }
  }
}