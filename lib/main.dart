import 'package:blogs_app/providers_controllers/gallery_image.dart';
import 'package:blogs_app/screens/blogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GalleryImageProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blogs App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
          useMaterial3: true,
        ),
        home: const BlogScreen(),
      ),
    );
  }
}
