import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovation/bloc/web_cubit.dart';
import 'package:sizer/sizer.dart';

import 'Constants/constants.dart';
import 'Navigation/navigate.dart';
import 'Navigation/routes.dart';
import 'bloc/cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<DataCubit>(
            create: (BuildContext context) => DataCubit(),
          ),
          BlocProvider<WebDataCubit>(
            create: (BuildContext context) => WebDataCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Interview',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor,),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          navigatorKey: Navigation.instance.navigatorKey,
          onGenerateRoute: generateRoute,
        ),
      );
    }
    );
  }
}