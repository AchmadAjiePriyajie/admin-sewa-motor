import 'dart:io';

import 'package:admin_sewa_motor/Services/motor_service.dart';
import 'package:admin_sewa_motor/components/my_button.dart';
import 'package:admin_sewa_motor/components/my_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormMotorPage extends StatefulWidget {
  final String? docID;
  const FormMotorPage({
    super.key,
    this.docID,
  });

  @override
  State<FormMotorPage> createState() => _FormMotorPageState();
}

class _FormMotorPageState extends State<FormMotorPage> {
  TextEditingController namaMotorController = TextEditingController();

  TextEditingController imagePathController = TextEditingController();

  TextEditingController merkController = TextEditingController();

  TextEditingController hargaController = TextEditingController();

  List<String> listMerk = ['Yamaha', 'Honda', 'Vespa'];

  late String selectedMerk = listMerk.first;

  File? selectedImage;

  Widget _textField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MyTextField(
          obscureText: false,
          hintText: '',
          controller: controller,
        ),
      ],
    );
  }

  void addMotor() {
    if (namaMotorController.text.isNotEmpty &&
        selectedMerk.isNotEmpty &&
        hargaController.text.isNotEmpty &&
        selectedImage.toString().isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah anda yakin ingin menyimpan data ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  var imageName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  var storageRef = FirebaseStorage.instance
                      .ref()
                      .child('images/motor/$imageName.jpg');
                  var uploadTask = storageRef.putFile(selectedImage!);
                  var downloadUrl =
                      await (await uploadTask).ref.getDownloadURL();

                  MotorService().addMotor(
                    namaMotorController.text,
                    int.parse(hargaController.text),
                    selectedMerk,
                    downloadUrl,
                  );
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, '/add_motor_page');
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void updateMotor() {
    if (namaMotorController.text.isNotEmpty &&
        selectedMerk.isNotEmpty &&
        hargaController.text.isNotEmpty &&
        selectedImage != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah anda yakin ingin menyimpan data ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  var imageName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  var storageRef = FirebaseStorage.instance
                      .ref()
                      .child('images/motor/$imageName.jpg');
                  var uploadTask = storageRef.putFile(selectedImage!);
                  var downloadUrl =
                      await (await uploadTask).ref.getDownloadURL();

                  MotorService().addMotor(
                    namaMotorController.text,
                    int.parse(hargaController.text),
                    selectedMerk,
                    downloadUrl,
                  );
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, '/add_motor_page');
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[600],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.lightBlue[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Input Motor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Input Nama Motor
                  _textField('Nama Motor', namaMotorController),
                  SizedBox(
                    height: 10,
                  ),

                  _textField('Harga', hargaController),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Merk'),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    value: selectedMerk,
                    items: listMerk
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMerk = newValue!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Foto Motor'),
                  SizedBox(
                    height: 10,
                  ),

                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: Text(
                          'Upload Gambar',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.grey[200]!),
                        ),
                      ),
                      selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              height: 50,
                            )
                          : Text('Anda belum memasukkan gambar')
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  widget.docID == null
                      ? MyButton(
                          text: 'Simpan',
                          fontSize: 15,
                          onTap: addMotor,
                        )
                      : MyButton(
                          text: 'Update',
                          fontSize: 15,
                          onTap: updateMotor,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
