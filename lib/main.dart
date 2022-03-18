import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:upload/provider/upload_file_provider.dart';
import 'package:upload/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UploadFileProvider>(
            create: (_) => UploadFileProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Documents Upload',
        theme: ThemeData(
            primarySwatch: Colors.green,
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45, width: 1.0),
              ),
            )),
        home: const HomePage(),
      ),
    );
  }
}
