import 'package:blogs_app/database_sqflite/database_sqflite.dart';
import 'package:blogs_app/models/blogs_model.dart';
import 'package:blogs_app/screens/blogs/add_new_blog.dart';
import 'package:blogs_app/screens/blogs/edit_old_blog.dart';
import 'package:blogs_app/screens/blogs/single_blogs.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  BlogsDatabase blogsDatabase = BlogsDatabase.instance;
  @override
  void initState() {
    getAllData();
    super.initState();
  }

  getAllData() async {
    await blogsDatabase.readAllreadBlogs();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    BlogsDatabase blogsDatabase = BlogsDatabase.instance;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 10),
                child: Text('All Blogs',
                    style: TextStyle(
                        color: Color.fromARGB(255, 1, 105, 91),
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(),
                  child: FutureBuilder<List<Blogs>>(
                      future: blogsDatabase.readAllreadBlogs(),
                      builder: (context, AsyncSnapshot<List<Blogs>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SingleBlog()));
                                },
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Stack(children: [
                                        snapshot.data![index].image.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(
                                                                20)),
                                                child: Image.memory(
                                                  snapshot.data![index].image,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(
                                                                20)),
                                                child: Image.network(
                                                  "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg",
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            margin: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30)),
                                                color: Colors.white),
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const EditOldBlog(
                                                                  title:
                                                                      "Edit Old Blog")));
                                                },
                                                icon: const Icon(Icons.edit,
                                                    size: 16,
                                                    color: Colors.black)),
                                          ),
                                        ),
                                      ]),
                                      const SizedBox(height: 05),
                                      const Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                              "snapshot.data![index].title",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Text(
                                            "snapshot.data![index].desc",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    ],
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
