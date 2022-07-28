import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/Charge_notifier/imc_charge_notifier_controller.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge_range.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcChargeNotifierPage extends StatefulWidget {
  const ImcChargeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ImcChargeNotifierPage> createState() => _ImcChargeNotifierPageState();
}

class _ImcChargeNotifierPageState extends State<ImcChargeNotifierPage> {
  final controller = ImcChargeNotifierController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC Changer Notifier'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return ImcGauge(imc: controller.imc);
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Peso'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso Obrigatório';
                    }
                  }),
              TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Altura'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura Obrigatório';
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  var formValid = formKey.currentState?.validate() ?? false;

                  if (formValid) {
                    var formatter = NumberFormat.simpleCurrency(
                        locale: 'pt_BR', decimalDigits: 2);

                    double peso = formatter.parse(pesoEC.text) as double;
                    double altura = formatter.parse(alturaEC.text) as double;

                    controller.calcularIMC(peso: peso, altura: altura);
                  }
                },
                child: Text('Calcular IMC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
