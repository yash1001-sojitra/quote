import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/Bloc/Quotes/Repo/quote_repo.dart';
import 'package:quote/Screens/HomeScreen/home_screen.dart';
import 'Bloc/Quotes/bloc/quotes_bloc.dart';
import 'Bloc/favourite/bloc/favourite_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuotesBloc(QuotesRepo())),
        BlocProvider(create: (context) => FavouriteBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quote Mobile App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Homepage()),
    );
  }
}
