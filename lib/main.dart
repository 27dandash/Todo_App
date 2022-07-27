import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'home_layout.dart';
import 'features/constants/flutter_local_notifications.dart';
import 'features/cubit/bloc_observer.dart';
import 'features/cubit/cubit.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  NotificationService().requestIOSPermissions();
  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
      ));
    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatefulWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    setState(() {
      tz.initializeTimeZones();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: HomeLayout(),
        ),
    );
    },
  );
}
}