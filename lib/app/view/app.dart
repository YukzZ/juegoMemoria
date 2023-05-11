import 'package:flutter/material.dart';
import 'package:juego_memoria/data/provider/cartas_provider.dart';
import 'package:juego_memoria/l10n/l10n.dart';
import 'package:juego_memoria/modules/home/view/home_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartasProvider()..loadPage(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
            backgroundColor:  const Color.fromARGB(255, 35,40,72)
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}
