import 'dart:io';

import 'package:blogs_app/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlogsScreen extends StatefulWidget {
  const AddNewBlogsScreen({super.key});

  @override
  State<AddNewBlogsScreen> createState() => _AddNewBlogsScreenState();
}

class _AddNewBlogsScreenState extends State<AddNewBlogsScreen> {
  File? galleryFile;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final manTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 105, 91),
        title: const Text(
          "Add New Blog",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 1, 105, 91)
                            .withOpacity(0.3))),
                child: const Text(
                  'Select Image',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _showPicker(context: context);
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                anyName: titleController,
                textHint: "Enter title here",
                value: 1,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                anyName: manTextController,
                textHint: "Enter date here",
                value: 1,
                onTap: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                anyName: manTextController,
                textHint: "Enter main text here",
                value: 16,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 1, 105, 91)
                              .withOpacity(0.4))),
                  child: const Text(
                    'Add Blog',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Press here and goto gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Press here and goto Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource imageSource,
  ) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing has been selected')));
        }
      },
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
