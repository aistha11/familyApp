
import 'package:familyApp/pages/home/familyChat/search_screen.dart';
import 'package:familyApp/pages/home/masterList/addMasterNote.dart';
import 'package:familyApp/pages/home/personalList/addPersonalNote.dart';
import 'package:familyApp/pages/home/profile/profile.dart';
import 'package:familyApp/pages/wrapper.dart';
import 'package:familyApp/provider/image_upload_provider.dart';
import 'package:familyApp/provider/user_provider.dart';
import 'package:familyApp/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
        ChangeNotifierProvider(create: (_) => AuthMethods.instance()),
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
          "/profile":(_)=>Profile(),
        },
      ),
    );
  }
}
