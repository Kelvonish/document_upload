import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:upload/provider/upload_file_provider.dart';
import 'package:upload/utils/alert_dialog.dart';
import 'package:upload/utils/required_text_widget.dart';
import 'package:upload/utils/selected_file_ui.dart';
import 'package:upload/utils/text_styles.dart';
import 'package:upload/utils/validate_email.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Consumer<UploadFileProvider>(
            builder: (context, value, child) => Column(
              children: [
                Card(
                  margin: EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: screenSize < 700
                          ? 16
                          : MediaQuery.of(context).size.width * 0.2),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              "assets/safaricom_logo.svg",
                              height: MediaQuery.of(context).size.height * 0.15,
                            ),
                          ),
                          Image.asset(
                            "assets/success.gif",
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Text(
                              "Please upload the required document for onboarding",
                              style: screenSize > 700
                                  ? titleStyleBold
                                  : bodyStyleBold,
                            ),
                          ),
                          const Divider(
                            height: 64,
                          ),
                          Text(
                            "1. Personal Information",
                            style: bodyStyleBold,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const RequiredText(name: "Name"),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: ((value) => value!.isEmpty
                                ? "Please enter your name"
                                : null),
                            controller: _nameController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const RequiredText(name: "Email"),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) => validateEmail(value!)
                                ? null
                                : "Please enter a valid email",
                            controller: _emailController,
                          ),
                          // const SizedBox(
                          //   height: 24,
                          // ),
                          // const RequiredText(name: "Phone Number"),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          // InternationalPhoneNumberInput(
                          //   isEnabled: true,
                          //   initialValue:
                          //       PhoneNumber(dialCode: "254", isoCode: "KE"),
                          //   validator: (val) => val!.length < 8
                          //       ? "Please enter a valid number"
                          //       : null,
                          //   onInputChanged: (PhoneNumber number) {
                          //     setState(() {
                          //       phoneNumber = number.phoneNumber;
                          //       print(phoneNumber);
                          //     });
                          //   },
                          //   selectorConfig: const SelectorConfig(
                          //       selectorType: PhoneInputSelectorType.DIALOG,
                          //       setSelectorButtonAsPrefixIcon: true,
                          //       //useEmoji: true,
                          //       leadingPadding: 16.0),
                          //   ignoreBlank: false,
                          //   autoValidateMode: AutovalidateMode.disabled,
                          //   inputDecoration: InputDecoration(
                          //     enabledBorder: const OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.grey, width: 1.0)),
                          //     border: const OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.grey, width: 1.0)),
                          //     disabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.grey[400] ?? Colors.grey,
                          //             width: 0.5)),
                          //     errorBorder: const OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.red, width: 1.0)),
                          //   ),
                          //   formatInput: true,
                          //   keyboardType: const TextInputType.numberWithOptions(
                          //       signed: true, decimal: true),
                          //   inputBorder: const OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(color: Colors.grey, width: 1.0)),
                          // ),
                          const SizedBox(
                            height: 24,
                          ),
                          const RequiredText(name: "National ID"),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            color: Colors.grey[100],
                            child: value.id != null
                                ? SelectedFileUI(
                                    fileName: value.idName ?? "", option: 1)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.singleFilePicker(1);
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const RequiredText(name: "KRA Pin"),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            color: Colors.grey[100],
                            child: value.kraPin != null
                                ? SelectedFileUI(
                                    fileName: value.kraPinName ?? "", option: 2)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.singleFilePicker(2);
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const RequiredText(name: "NHIF"),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            color: Colors.grey[100],
                            child: value.nhif != null
                                ? SelectedFileUI(
                                    fileName: value.nhifName ?? "", option: 3)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.singleFilePicker(3);
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const RequiredText(name: "NSSF"),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            color: Colors.grey[100],
                            child: value.nssf != null
                                ? SelectedFileUI(
                                    fileName: value.nssfName ?? "", option: 4)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.singleFilePicker(4);
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const RequiredText(name: "Passport Image"),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            color: Colors.grey[100],
                            child: value.passport != null
                                ? SelectedFileUI(
                                    fileName: value.passportName ?? "",
                                    option: 5)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.singleFilePicker(5);
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),
                          const Divider(
                            height: 64,
                          ),
                          Text(
                            "2. Medical Insurance",
                            style: bodyStyleBold,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Marriage Certificate",
                            style: bodyStyleNormal,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            color: Colors.grey[100],
                            child: value.marriageCertificate != null
                                ? SelectedFileUI(
                                    fileName:
                                        value.marriageCertificateName ?? "",
                                    option: 6)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.singleFilePicker(6);
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Spouse ID",
                            style: bodyStyleNormal,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: 50,
                            color: Colors.grey[100],
                            child: value.spouseId != null
                                ? SelectedFileUI(
                                    fileName: value.spouseIdName ?? "",
                                    option: 7)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.singleFilePicker(7);
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),

                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Child Birth Certificate or Birth Notification ",
                                style: bodyStyleNormal,
                              ),
                              value.birthCertificates.isNotEmpty &&
                                      value.birthCertificatesNames.isNotEmpty
                                  ? OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          side: const BorderSide(
                                              color: Colors.green)),
                                      onPressed: () {
                                        value.pickMultipleFiles();
                                      },
                                      icon: const Icon(Icons.add),
                                      label: Text(
                                        "Add",
                                        style: bodyStyleGreen,
                                      ))
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            height: value.birthCertificates.isEmpty ? 50 : 150,
                            color: Colors.grey[100],
                            child: value.birthCertificates.isNotEmpty &&
                                    value.birthCertificatesNames.isNotEmpty
                                ? MultipleSelectedFileUi(
                                    birthCertificatesNames:
                                        value.birthCertificatesNames)
                                : TextButton.icon(
                                    onPressed: () {
                                      value.pickMultipleFiles();
                                    },
                                    icon: const Icon(
                                      Icons.attach_file_rounded,
                                      color: Colors.black,
                                    ),
                                    label: Text(
                                      "Attach file",
                                      style: bodyStyle14,
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "* For more than one child please select all their birth certificates",
                              style: supportingTextStyleBold,
                            ),
                          ),
                          const Divider(
                            height: 64,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(24),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (value.id == null ||
                                        value.kraPin == null ||
                                        value.nhif == null ||
                                        value.nssf == null ||
                                        value.passport == null) {
                                      showErrorAlertDialog(context,
                                          "Please upload all the required documents");
                                    } else {
                                      String filename = _nameController.text +
                                          "_" +
                                          _emailController.text +
                                          ".zip";
                                      value.uploadDocuments(context, filename);
                                      //value.generateZipFile();
                                    }
                                  }
                                },
                                child: value.uploadDocumentLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text("Submit", style: bodyStyleWhite)),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
