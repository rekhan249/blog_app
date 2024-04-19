// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:blogs_app/database_sqflite/database_sqflite.dart';
import 'package:blogs_app/models/blogs_model.dart';
import 'package:blogs_app/providers_controllers/gallery_image.dart';
import 'package:blogs_app/screens/blogs_screen.dart';
import 'package:blogs_app/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddNewBlogsScreen extends StatefulWidget {
  final String title;
  const AddNewBlogsScreen({super.key, required this.title});

  @override
  State<AddNewBlogsScreen> createState() => _AddNewBlogsScreenState();
}

class _AddNewBlogsScreenState extends State<AddNewBlogsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final manTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                                    title: const Text(
                                        'Press here and goto gallery'),
                                    onTap: () async {
                                      await gIP.uploadImage();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text(
                                        'Press here and goto Camera'),
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
                                padding: const EdgeInsets.all(20),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(80)),
                                    border: Border.all(
                                        width: 5,
                                        color: const Color.fromARGB(
                                                255, 1, 105, 91)
                                            .withOpacity(0.4))),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 50,
                                ),
                              )
                            : ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                child: Image.memory(
                                  gIP.profile!,
                                  height: 250,
                                  width: 340,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                    ),
                  ),
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
                      bool isValid = formKey.currentState!.validate();
                      FocusScope.of(context).unfocus();
                      if (!isValid) {
                        return;
                      }
                      formKey.currentState!.save();
                      await addDataInDatebase(
                          Provider.of<GalleryImageProvider>(context,
                                  listen: false)
                              .profile,
                          titleController.text,
                          manTextController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addDataInDatebase(Uint8List image, String title, String desc) async {
    Blogs blogs = Blogs(
        title: title,
        desc: desc,
        dateTime: DateTime.now().toIso8601String(),
        image: image);

    try {
      BlogsDatabase? blogsDatabase = BlogsDatabase.instance;
      blogsDatabase.create(blogs).whenComplete(() {
        Fluttertoast.showToast(msg: "Data save successfully");

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BlogScreen(),
            ));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong $e");
    }
  }
}
