import 'package:familyApp/model/user_repository.dart';
import 'package:familyApp/pages/home/familyChat/skype/provider/image_upload_provider.dart';
import 'package:familyApp/pages/home/familyChat/skype/provider/user_provider.dart';
import 'package:familyApp/pages/home/familyChat/skype/screens/search_screen.dart';
import 'package:familyApp/pages/home/masterList/addMasterNote.dart';
import 'package:familyApp/pages/home/personalList/addPersonalNote.dart';
import 'package:familyApp/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // builder: (_) => UserRepository.instance(),
      // create: (_)=> UserRepository.instance(),
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => UserRepository.instance()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        // theme: ThemeData(brightness: Brightness.dark),
        routes: {
          "/" : (_) => Wrapper(),
          "/addPersonalNote" : (_) => AddPersonalNote(),
          "/addMasterNote" : (_) => AddMasterNote(),
          '/search_screen': (context) => SearchScreen(),
        },
      ),
    );
  }
}
