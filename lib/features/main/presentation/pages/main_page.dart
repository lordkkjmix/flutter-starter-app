import 'package:flutter/material.dart';
import 'package:flutter_starter_app/core/providers/localization_provider.dart';
import 'package:flutter_starter_app/i18n/i18n.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Starter'),
        actions: [
          PopupMenuButton<Locale>(
              onSelected: (item) {
                LocalizationProvider.updateLocale(item);
              },
              itemBuilder: (context) => LocalizationProvider.supportedLocales
                  .map(
                    (e) => PopupMenuItem<Locale>(
                        value: e, child: Text(e.languageCode)),
                  )
                  .toList()),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:'.translate,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
