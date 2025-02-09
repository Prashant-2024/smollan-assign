import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smollan_assign/providers/profile_provider.dart';
import 'package:smollan_assign/providers/theme_provider.dart';
import 'package:smollan_assign/providers/feed_provider.dart';
import 'package:smollan_assign/views/FeedPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FeedProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),// Added FeedProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smollan Assignment',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const FeedPage(),
    );
  }
}
