// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:blogs_app/database_sqflite/database_sqflite.dart';
import 'package:blogs_app/models/blogs_model.dart';
import 'package:blogs_app/screens/blogs_screen.dart';
import 'package:blogs_app/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditOldBlog extends StatefulWidget {
  final String title;
  const EditOldBlog({super.key, required this.title});

  @override
  State<EditOldBlog> createState() => _EditOldBlogState();
}

class _EditOldBlogState extends State<EditOldBlog> {
  BlogsDatabase blogsDatabase = BlogsDatabase.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final idController = TextEditingController();
    final titleController = TextEditingController();
    final dateTimeController = TextEditingController();
    final manTextController = TextEditingController();
    Provider.of<DateProvider>(context, listen: false);
    Provider.of<GalleryImageProvider>(context, listen: false);
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
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Consumer<GalleryImageProvider>(
                  builder: (context, gIP, child) => GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title:
                                      const Text('Press here and goto gallery'),
                                  onTap: () async {
                                    await gIP.uploadImage();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title:
                                      const Text('Press here and goto Camera'),
                                  onTap: () async {
                                    await gIP.uploadImage();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      child: gIP.profile == null
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              child:
                                  const Text("No Image yet Please Select one"),
                            )
                          : Container(
                              height: 300,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(gIP.profile!))),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                anyName: idController,
                textHint: "Enter id here",
                value: 1,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                anyName: titleController,
                textHint: "Enter title here",
                value: 1,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              Consumer<DateProvider>(
                builder: (context, dP, child) => TextFormField(
                  controller: dateTimeController,
                  readOnly: true,
                  onTap: () async {
                    dateTimeController.text = (await dP.selectDate(context))!;
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 1, 105, 91)
                          .withOpacity(0.4),
                      filled: true,
                      hintText: "Select Date",
                      hintStyle: const TextStyle(color: Colors.white),
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none)),
                ),
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
                  onPressed: () async {
                    await addDataInDatebase(
                        Provider.of<GalleryImageProvider>(context,
                                listen: false)
                            .profile,
                        titleController.text,
                        Provider.of<DateProvider>(context, listen: false)
                            .selectedDate,
                        manTextController.text,
                        idController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addDataInDatebase(image, String title, selectedDate, String desc, String id) {
    Blogs blogs = Blogs(
        id: int.parse(id),
        title: title,
        desc: desc,
        dateTime: DateTime.parse(selectedDate.toString()),
        image: image);

    try {
      BlogsDatabase? blogsDatabase = BlogsDatabase.instance;
      blogsDatabase.create(blogs);

      Fluttertoast.showToast(msg: "Update date Successfully");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BlogScreen(),
          ));
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong $e");
    }
  }
}

class GalleryImageProvider with ChangeNotifier {
  Uint8List? _profile;
  get profile => _profile;

  uploadImage() async {
    final XFile? imagePro = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imagePro != null) {
      _profile = await imagePro.readAsBytes();
    } else {
      _profile = null;
    }
    notifyListeners();
  }
}

class DateProvider with ChangeNotifier {
  DateTime? _selectedDate = DateTime.now();

  get selectedDate => _selectedDate;

  Future<String?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate!,
        firstDate: DateTime(1900),
        lastDate: DateTime(2099));

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      var dateValue = DateFormat("d/MM/yyyy HH:mm:ss").format(_selectedDate!);
      notifyListeners();
      return dateValue;
    }
    notifyListeners();
    return null;
  }
}
