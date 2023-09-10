import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:face_shape/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadProgressNotifier extends ValueNotifier<double> {
  UploadProgressNotifier() : super(0.0);

  void updateProgress(double progress) {
    value = progress;
  }
}

Future<dynamic> loadingProgress(BuildContext context, double progressUplaod) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Upload Progress'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              value: progressUplaod / 100,
            ),
            SizedBox(height: 16.0),
            Text('${progressUplaod.toStringAsFixed(2)}%'),
          ],
        ),
      );
    },
  );
}

AwesomeDialog successDialogue(BuildContext context) {
  return AwesomeDialog(
    context: context,
    title: 'Upload selesai',
    desc: 'File anda telah berhasil diunggah',
    dialogType: DialogType.success,
    btnOkOnPress: () {
      Get.toNamed(Routes.trainPreprocess);
    },
  )..show();
}
