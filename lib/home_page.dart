import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_scan/HmsScanLibrary.dart';

import 'package:simple_example_scanner_huawi/gialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String permissionState = "Permissions Are Not Granted. click to generate";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Text("CallScanner"),
            onPressed: () {
              showScanner();
            },
          ),
          TextButton(
            child: Text(permissionState),
            onPressed: () {
              permissionRequest();
            },
          ),
        ],
      )),
    );
  }

  @override
  void initState() {
    //for first check permition
    permissionRequest();
    super.initState();
  }

  ///check and show permission dialogs
  permissionRequest() async {
    bool permissionResult =
        await HmsScanPermissions.hasCameraAndStoragePermission();
    if (permissionResult == false) {
      await HmsScanPermissions.requestCameraAndStoragePermissions();
    } else {
      setState(() {
        permissionState = "All Permissions Are Granted";
      });
    }
  }

  ///call Scanner
  showScanner() async {
    try {
      DefaultViewRequest request = new DefaultViewRequest(
          scanType: HmsScanTypes.AllScanType); //int request
      //call scanner whit pass request and wait for result
      //response show in dialog
      await HmsScanUtils.startDefaultView(request).then((value) {
        ScanResponse response = value;
        DialogBoxes db = new DialogBoxes(
            success: true,
            title: response.scanTypeForm.toString(),
            des: response.originalValue);
        db.showMyDialog(context);
      });
    } on PlatformException catch (err) {
      if (err.code == HmsScanErrors.scanUtilNoCameraPermission.errorCode) {
        DialogBoxes db = new DialogBoxes(
            success: true,
            title: "خطا",
            des: HmsScanErrors.scanUtilNoCameraPermission.errorMessage);
        db.showMyDialog(context);
      }
    }
  }
}
