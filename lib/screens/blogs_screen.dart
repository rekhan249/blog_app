// ignore_for_file: prefer_is_empty
import 'package:blogs_app/database_sqflite/database_sqflite.dart';
import 'package:blogs_app/models/blogs_model.dart';
import 'package:blogs_app/providers_controllers/gallery_image.dart';
import 'package:blogs_app/providers_controllers/remove_blogs.dart';
import 'package:blogs_app/screens/blogs/add_new_blog.dart';
import 'package:blogs_app/screens/blogs/edit_old_blog.dart';
import 'package:blogs_app/screens/blogs/single_blogs.dart';
import 'package:blogs_app/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  BlogsDatabase blogsDatabase = BlogsDatabase.instance;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var searchQuery = Provider.of<SearchProvider>(context, listen: false);
    Provider.of<MultiSelectProvider>(context, listen: false);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Text('All Blogs',
              style: TextStyle(
                  color: Color.fromARGB(255, 1, 105, 91),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Consumer<SearchProvider>(
                builder: (context, searchPro, child) => CustomTextFormField(
                  anyName: searchController,
                  textHint: "Search here",
                  value: 1,
                  onChange: (value) {
                    searchPro.searchingQuery(value);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(),
                child: FutureBuilder<List<Blogs?>?>(
                    future: blogsDatabase.searchBlogs(searchQuery.searchQuery),
                    builder: (context, AsyncSnapshot<List<Blogs?>?> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<Blogs?> blogList = snapshot.data!
                          .map((e) => Blogs.fromMap(e!.toMap()))
                          .toList();

                      return blogList.isEmpty
                          ? const Center(child: Text("No Blogs yet right now"))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              reverse: false,
                              itemCount: blogList.length,
                              itemBuilder: (context, index) {
                                final singleBlogs = blogList[index];

                                return Dismissible(
                                  onDismissed: (direction) async {
                                    await blogsDatabase.deleteData(index);
                                    await blogsDatabase.searchBlogs();
                                  },
                                  key: UniqueKey(),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SingleBlog(
                                                  id: index,
                                                  singleBlog: singleBlogs)));
                                    },
                                    child: Card(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Stack(children: [
                                            singleBlogs!.image.isEmpty
                                                ? ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20)),
                                                    child: Image.network(
                                                      "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg",
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20)),
                                                    child: Image.memory(
                                                      singleBlogs.image,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                margin: const EdgeInsets.only(
                                                    top: 5, right: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    color: Colors.black
                                                        .withOpacity(0.3)),
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditOldBlog(
                                                                      title:
                                                                          "Edit Old Blog",
                                                                      id: index)));
                                                    },
                                                    icon: const Icon(Icons.edit,
                                                        size: 18,
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                margin: const EdgeInsets.only(
                                                    top: 5, left: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    color: Colors.black
                                                        .withOpacity(0.3)),
                                                child: Consumer<
                                                    MultiSelectProvider>(
                                                  builder: (context, multiPro,
                                                          child) =>
                                                      GestureDetector(
                                                    onTap: () {
                                                      multiPro
                                                          .selectOrRemoveObjectToAndFrom(
                                                              index,
                                                              singleBlogs,
                                                              blogList);
                                                    },
                                                    child: blogList[index]!
                                                            .isSelected
                                                        ? const Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color: Colors.white,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .check_box_rounded,
                                                            color: Colors.white,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Text(singleBlogs.title,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Text(singleBlogs.desc,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const AddNewBlogsScreen(title: "Add New Blog")));
        },
        backgroundColor: const Color.fromARGB(255, 1, 105, 91).withOpacity(0.6),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
