import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/services/authentication.dart';
import 'data/services/place.dart';
import 'data/services/sample.dart';
import 'logic/bloc/home/home_bloc.dart';
import 'logic/bloc/place/place_bloc.dart';
import 'logic/bloc/sample/sample_bloc.dart';
import 'presentation/router/app_router.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthenticationService()),
        RepositoryProvider(create: (context) => PlaceService()),
        RepositoryProvider(create: (context) => SampleService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => HomeBloc(
                  context.read<AuthenticationService>(),
                  context.read<PlaceService>(),
                  context.read<SampleService>())),
          BlocProvider(
              create: (context) => PlaceBloc(
                  context.read<PlaceService>(), context.read<SampleService>())),
          BlocProvider(
              create: (context) => SampleBloc(
                  context.read<PlaceService>(), context.read<SampleService>()))
        ],
        child: MaterialApp(
          title: 'RandomGen',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: _appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
