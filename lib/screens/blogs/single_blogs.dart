import 'package:blogs_app/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';

class SingleBlog extends StatefulWidget {
  const SingleBlog({super.key});

  @override
  State<SingleBlog> createState() => _SingleBlogState();
}

class _SingleBlogState extends State<SingleBlog> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final searchController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(children: [
                        CustomTextFormField(
                          anyName: searchController,
                          textHint: "Search here",
                          value: 1,
                          onTap: () {},
                        ),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('Hey Hi I am a Tester',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 25)),
                          ),
                        ),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 05),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Hey Hi I am a Tester',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25)),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 05),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                    "Occasionally.Hey Hi I am a Tester Hey Hi I am You can also check for any open issues on the Flutter GitHub repository.If the issue persists, you might need to share relevant portions of your code (especially where the RenderSliverPadding is used) so that more specific assistance can be provided. Additionally, checking the Flutter GitHub repository or forums for similar issues and solutions can be helpful. Occasionally, issues like this may be related to the Flutter framework itself. Ensure that you are using a stable version of Flutter and Dart. You can also check for any open",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16)),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
