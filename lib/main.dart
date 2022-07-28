import 'package:bukit_vista_flutter_assesment/models/provider/guest_provider.dart';
import 'package:bukit_vista_flutter_assesment/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GuestProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guest App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashFuturePage(),
      ),
    );
  }
}
