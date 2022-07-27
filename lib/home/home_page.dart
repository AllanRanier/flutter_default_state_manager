import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('SetState'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('valueNotifier'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('ChargeNotiFier'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Bloc Pattern (Streams)'),
            ),
          ],
        ),
      ),
    );
  }
}
