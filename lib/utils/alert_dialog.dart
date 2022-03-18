import 'package:flutter/material.dart';
import 'package:upload/utils/text_styles.dart';

showErrorAlertDialog(BuildContext context, String message) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "OK",
      style: bodyStyleGreen,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/error.png",
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          message,
          style: bodyStyleNormal,
          maxLines: 3,
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSuccessAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Done",
      style: bodyStyleGreen,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    //title: Text("Error", style: bodyStyleBold),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "success.gif",
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Documents uploaded successfully.",
          style: bodyStyleNormal,
          maxLines: 3,
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
