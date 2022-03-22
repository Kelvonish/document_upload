import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:upload/utils/constants.dart';
import 'package:upload/utils/snackbars.dart';
import 'package:http_parser/http_parser.dart';

class UploadWebService {
  Future<String?> getAccessToken() async {
    try {
      log("Starting to get token");
      var map = {
        "client_id": "$CLIENT_ID@$TENANT_ID",
        "client_secret": CLIENT_SECRET,
        "grant_type": GRANT_TYPE,
        "resource": RESOURCE,
        "tenant_id": TENANT_ID
      };

      final response = await http.post(
        Uri.parse(ACCESS_TOKEN_URL),
        body: json.encode(map),
      );
      log("Gotten response");
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      if (response.statusCode == 200) {
        return responseJson['access_token'];
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      failureSnackBar(e.toString());
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> uploadDocuments(
      String token, Uint8List file, String name) async {
    try {
      var postUri = Uri.parse(UPLOAD_URL + "add(url='$name',overwrite=true)");
      print(postUri);
      log("parsed url");
      http.MultipartRequest request = http.MultipartRequest("POST", postUri);
      log("defined request");
      http.MultipartFile multipartFile =
          http.MultipartFile.fromBytes("data", file.toList());
      log("loaded bytes");
      Map<String, String> headers = {
        "Authorization":
            "Bearer $token", //"Content-Type": "application/x-www-form-urlencoded",
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      };
      request.headers.addAll(headers);
      request.files.add(multipartFile);

      http.StreamedResponse response = await request.send();
      //var responseJson = json.decode(response.body.toString());
      inspect(response);
      //print(responseJson);
      log("returned response");
      print(response.statusCode);
      log("Gotten response");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      failureSnackBar(e.toString());
      debugPrint(e.toString());
      return false;
    }
  }
}
