import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/Charge_notifier/imc_charge_notifier_page.dart';

import 'package:flutter_default_state_manager/setState/imc_setstate_page.dart';
import 'package:flutter_default_state_manager/value_notifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page,)
    );
  }

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
              onPressed: () => _goToPage(context, ImcSetstatePage()),
              child: Text('SetState'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, ValueNotifierPage()),
              child: Text('valueNotifier'),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, ImcChargeNotifierPage()),
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
