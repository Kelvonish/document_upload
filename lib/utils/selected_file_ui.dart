import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upload/provider/upload_file_provider.dart';
import 'package:upload/utils/text_styles.dart';

class SelectedFileUI extends StatelessWidget {
  final String fileName;
  final int option;
  const SelectedFileUI({Key? key, required this.fileName, required this.option})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 16,
      minLeadingWidth: 10,
      leading: Text(
        fileName,
        style: bodyStyleNormal,
      ),
      trailing: IconButton(
          onPressed: () {
            Provider.of<UploadFileProvider>(context, listen: false)
                .removeSelected(option);
          },
          icon: const Icon(Icons.close)),
    );
  }
}

class MultipleSelectedFileUi extends StatelessWidget {
  final List<String?> birthCertificatesNames;
  const MultipleSelectedFileUi({Key? key, required this.birthCertificatesNames})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: birthCertificatesNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            horizontalTitleGap: 16,
            minLeadingWidth: 10,
            leading: Text(
              birthCertificatesNames[index] ?? "",
              style: bodyStyleNormal,
            ),
            trailing: IconButton(
                onPressed: () {
                  Provider.of<UploadFileProvider>(context, listen: false)
                      .removeSingleItemInMultiple(index);
                },
                icon: const Icon(Icons.close)),
          );
        });
  }
}
