import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upload/storage/access_token_preference.dart';
import 'package:upload/utils/alert_dialog.dart';
import 'package:upload/utils/snackbars.dart';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;
import 'package:upload/web_services/upload_web_service.dart';
import 'dart:html' as html;

class UploadFileProvider extends ChangeNotifier {
  final UploadWebService _uploadWebService = UploadWebService();
  final AccessTokenStorage _accessTokenStorage = AccessTokenStorage();
  bool uploadDocumentLoading = false;
  Uint8List? kraPin, id, nssf, nhif, passport, marriageCertificate, spouseId;
  String? kraPinName,
      idName,
      nssfName,
      nhifName,
      passportName,
      marriageCertificateName,
      spouseIdName;
  List<Uint8List?> birthCertificates = [];
  List<String?> birthCertificatesNames = [];
  singleFilePicker(int option) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    Uint8List? fileBytes = result!.files.first.bytes;
    String fileName = result.files.first.name;
    if (result != null) {
      if (option == 1) {
        id = result.files.single.bytes;
        idName = result.files.single.name;
        notifyListeners();
      } else if (option == 2) {
        kraPin = result.files.single.bytes;
        kraPinName = result.files.single.name;
        notifyListeners();
      } else if (option == 3) {
        nhif = result.files.single.bytes;
        nhifName = result.files.single.name;
        notifyListeners();
      } else if (option == 4) {
        nssf = result.files.single.bytes;
        nssfName = result.files.single.name;
        notifyListeners();
      } else if (option == 5) {
        passport = result.files.single.bytes;
        passportName = result.files.single.name;
        notifyListeners();
      } else if (option == 6) {
        marriageCertificate = result.files.single.bytes;
        marriageCertificateName = result.files.single.name;
        notifyListeners();
      } else if (option == 7) {
        spouseId = result.files.single.bytes;
        spouseIdName = result.files.single.name;
        notifyListeners();
      }
    } else {
      // User canceled the picker
      Fluttertoast.showToast(msg: "No file selected");
      failureSnackBar("No file selected");
    }
  }

  removeSelected(int option) {
    if (option == 1) {
      id = null;
      idName = null;
      notifyListeners();
    } else if (option == 2) {
      kraPin = null;
      kraPinName = null;
      notifyListeners();
    } else if (option == 3) {
      nhif = null;
      nhifName = null;
      notifyListeners();
    } else if (option == 4) {
      nssf = null;
      nssfName = null;
      notifyListeners();
    } else if (option == 5) {
      passport = null;
      passportName = null;
      notifyListeners();
    } else if (option == 6) {
      marriageCertificate = null;
      marriageCertificateName = null;
      notifyListeners();
    } else if (option == 7) {
      spouseId = null;
      spouseIdName = null;
      notifyListeners();
    }
  }

  pickMultipleFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      for (var element in result.files) {
        birthCertificates.add(element.bytes);
        birthCertificatesNames.add(element.name);
      }

      //birthCertificates = result.files.map((path) => path.bytes).toList();
      //birthCertificatesNames = result.files.map((path) => path.name).toList();
      notifyListeners();
    } else {
      // User canceled the picker
      Fluttertoast.showToast(msg: "No file selected");
      failureSnackBar("No file selected");
    }
  }

  removeSingleItemInMultiple(int index) {
    birthCertificates.removeAt(index);
    birthCertificatesNames.removeAt(index);
    notifyListeners();
  }

  resetAllSelected() {
    kraPin = null;
    id = null;
    nssf = null;
    nhif = null;
    passport = null;
    marriageCertificate = null;
    spouseId = null;
    birthCertificates = [];
    kraPinName = null;
    idName = null;
    nssfName = null;
    nhifName = null;
    passportName = null;
    marriageCertificateName = null;
    spouseIdName = null;
    birthCertificatesNames = [];
    birthCertificates = [];
    notifyListeners();
  }

  generateAccessToken() async {
    String? token = await _uploadWebService.getAccessToken();
    if (token != null) {
      _accessTokenStorage.saveAccessToken(token);
      return token;
    } else {
      //failureSnackBar("error getting tokens");
      log("Error getting token");
    }
  }

  Future<Uint8List?> generateZipFile() async {
    try {
      var encoder = ZipEncoder();
      var archive = Archive();
      // ArchiveFile archiveFiles = ArchiveFile.stream(
      //     filenames.toString(), files.lengthInBytes, files.buffer.asByteData());
      // print(archiveFiles);
      //archive.addFile(archiveFiles);
      archive.addFile(ArchiveFile(idName!, id!.length, id!));

      archive.addFile(ArchiveFile(kraPinName!, kraPin!.length, kraPin!));

      archive.addFile(ArchiveFile(nhifName!, nhif!.length, nhif!));

      archive.addFile(ArchiveFile(nssfName!, nssf!.length, nssf!));

      archive.addFile(ArchiveFile(passportName!, passport!.length, passport!));

      marriageCertificate != null
          ? archive.addFile(ArchiveFile(marriageCertificateName!,
              marriageCertificate!.length, marriageCertificate))
          : log("skipped marriage cert");
      ;
      spouseId != null
          ? archive
              .addFile(ArchiveFile(spouseIdName!, spouseId!.length, spouseId))
          : log("skipped spouse id");
      ;
      if (birthCertificates.isNotEmpty && birthCertificatesNames.isNotEmpty) {
        for (int i = 0; i < birthCertificates.length; i++) {
          archive.addFile(ArchiveFile(birthCertificatesNames[i]!,
              birthCertificates[i]!.length, birthCertificates[i]));
        }
      }
      log("past for loop");
      var outputStream = OutputStream(
        byteOrder: LITTLE_ENDIAN,
      );

      var bytes = encoder.encode(archive,
          level: Deflate.BEST_COMPRESSION, output: outputStream);

      return Uint8List.fromList(bytes!);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      failureSnackBar(e.toString());
      return null;
    }
  }

  uploadDocuments(BuildContext context, String filename) async {
    uploadDocumentLoading = true;
    notifyListeners();
    //String? token = await _accessTokenStorage.getAccessToken();
    //token ??= await generateAccessToken();
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImpTMVhvMU9XRGpfNTJ2YndHTmd2UU8yVnpNYyIsImtpZCI6ImpTMVhvMU9XRGpfNTJ2YndHTmd2UU8yVnpNYyJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvc2FmYXJpY29tbzM2NS5zaGFyZXBvaW50LmNvbUAxOWE0ZGIwNy02MDdkLTQ3NWYtYTUxOC0wZTNiNjk5YWM3ZDAiLCJpc3MiOiIwMDAwMDAwMS0wMDAwLTAwMDAtYzAwMC0wMDAwMDAwMDAwMDBAMTlhNGRiMDctNjA3ZC00NzVmLWE1MTgtMGUzYjY5OWFjN2QwIiwiaWF0IjoxNjQ3ODQyMDYzLCJuYmYiOjE2NDc4NDIwNjMsImV4cCI6MTY0NzkyODc2MywiaWRlbnRpdHlwcm92aWRlciI6IjAwMDAwMDAxLTAwMDAtMDAwMC1jMDAwLTAwMDAwMDAwMDAwMEAxOWE0ZGIwNy02MDdkLTQ3NWYtYTUxOC0wZTNiNjk5YWM3ZDAiLCJuYW1laWQiOiJkNDc2MmNmOS1lNjU0LTRhMTUtYWRkNS1kNjA3NmE3MWMxZTdAMTlhNGRiMDctNjA3ZC00NzVmLWE1MTgtMGUzYjY5OWFjN2QwIiwib2lkIjoiZjFiNjJlNzAtOGQ5MS00MTAzLWIyNWUtOWEyNGQ0YTg5MDYxIiwic3ViIjoiZjFiNjJlNzAtOGQ5MS00MTAzLWIyNWUtOWEyNGQ0YTg5MDYxIiwidHJ1c3RlZGZvcmRlbGVnYXRpb24iOiJmYWxzZSJ9.B490gm_wdhrEN01oiHc3hlQViDQRt507zkSTBaIsc8MUArPRd71wpjNNzNfdiuviXlmgv7inzN_MwKAndkOwCdc58s7Bn0apCDCaZ5ahE44pZGW5_GW7Fyk-E3emX4_irMGyEpjIb3cVSOl_YL1193YlRfuMXd-393tw4edbQrSlN0RiQCbWZppNIunEQIZ9KZBL6Pm8JkZBatkVY-_mcJUnmgir7aNg_jg0KFlMpOG0jzMfVN5uL50WdBfl2OBeFqYtdFizQHSNizlQqPrGwTFegwvn_ZWsQhiZDMeTdUFi8jnIc_Q1phydchpED7eAsXhnJplzoCOrvYIQgBfJ6A";
    Uint8List? uploadZip = await generateZipFile();
    if (uploadZip != null) {
      bool state =
          await _uploadWebService.uploadDocuments(token, uploadZip, filename);
      if (state) {
        resetAllSelected();
        showSuccessAlertDialog(context);
        uploadDocumentLoading = false;
        notifyListeners();
      } else {
        showErrorAlertDialog(
            context, "Something went wrong! Could not upload the documents");
        uploadDocumentLoading = false;
        notifyListeners();
      }
    }
    uploadDocumentLoading = false;
    notifyListeners();
  }
}
