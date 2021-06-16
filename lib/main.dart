import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
    path: 'assets/langs',
    fallbackLocale: Locale('en', 'US'),
//    saveLocale: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ezContext = EasyLocalization.of(context)!;
    return MaterialApp(
      title: 'Change Lang App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _ezContext.delegate,
      ],
      supportedLocales: _ezContext.supportedLocales,
      locale: _ezContext.locale,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Change Lang App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _switchLang(Locale locale) async {
    await context.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            TextButton(
              //supportedLocalesをcontextからとってこれる
              onPressed: () => _switchLang(context.supportedLocales[0]),
              child: Text('en'),
            ),
            TextButton(
              onPressed: () => _switchLang(context.supportedLocales[1]),
              child: Text('ar'),
            ),
            const SizedBox(height: 100),
            Text(tr('title')),
            //context.localeで現在のlocaleが取得できる
            Text(context.locale.toString())
          ],
        ),
      ),
    );
  }
}
