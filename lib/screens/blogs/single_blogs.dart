import 'package:blogs_app/models/blogs_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleBlog extends StatefulWidget {
  final int id;
  final Blogs singleBlog;
  const SingleBlog({super.key, required this.id, required this.singleBlog});

  @override
  State<SingleBlog> createState() => _SingleBlogState();
}

class _SingleBlogState extends State<SingleBlog> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                                DateFormat("dd-MM-yyyy").format(DateTime.now()),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 25)),
                          ),
                        ),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.memory(
                            widget.singleBlog.image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 05),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(widget.singleBlog.title,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 25)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 05),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(widget.singleBlog.desc,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 16)),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
