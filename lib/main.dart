import 'package:familyApp/model/user_repository.dart';
import 'package:familyApp/pages/widgets/addMasterNote.dart';
import 'package:familyApp/pages/widgets/addPersonalNote.dart';
import 'package:familyApp/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // builder: (_) => UserRepository.instance(),
      create: (_)=> UserRepository.instance(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/" : (_) => Wrapper(),
          "/addPersonalNote" : (_) => AddPersonalNote(),
          "/addMasterNote" : (_) => AddMasterNote(),
        },
      ),
    );
  }
}
