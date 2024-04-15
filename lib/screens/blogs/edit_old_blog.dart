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

class EditOldBlog extends StatefulWidget {
  final String title;
  final int id;
  const EditOldBlog({super.key, required this.title, required this.id});

  @override
  State<EditOldBlog> createState() => _EditOldBlogState();
}

class _EditOldBlogState extends State<EditOldBlog> {
  BlogsDatabase blogsDatabase = BlogsDatabase.instance;
  final titleController = TextEditingController();
  final manTextController = TextEditingController();

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  getAllData() async {
    Blogs? blogs = await blogsDatabase.getSingleBlog(widget.id);
    titleController.text = blogs!.title;
    manTextController.text = blogs.desc;
    Provider.of<GalleryImageProvider>(context, listen: false)
        .oldImage(blogs.image);
  }

  @override
  void dispose() {
    titleController.dispose();
    manTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: gIP.profile!.isNotEmpty
                          ? Container(
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              child: const Icon(Icons.camera),
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
                    await addDataInDatebase(
                        Provider.of<GalleryImageProvider>(context,
                                listen: false)
                            .profile,
                        titleController.text,
                        manTextController.text,
                        widget.id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addDataInDatebase(image, String title, String desc, int id) async {
    Blogs blogs = Blogs(
        title: title,
        desc: desc,
        dateTime: DateTime.now().toIso8601String(),
        image: image);

    try {
      BlogsDatabase? blogsDatabase = BlogsDatabase.instance;
      blogsDatabase.update(blogs, id).whenComplete(() {
        Fluttertoast.showToast(msg: "Update data Successfully");
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
