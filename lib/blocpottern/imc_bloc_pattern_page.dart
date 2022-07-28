import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/blocpottern/imc_bloc_pattern_controller.dart';
import 'package:flutter_default_state_manager/blocpottern/imc_state.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  State<ImcBlocPatternPage> createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final controller = ImcBlocPatternController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC Bloc pattern'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              StreamBuilder<ImcState>(
                stream: controller.imcOut,
                builder: ((context, snapshot) {
                  var imc = snapshot.data?.imc ?? 0;
                  ;

                  return ImcGauge(imc: imc);
                }),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<ImcState>(
                stream: controller.imcOut,
                builder: ((context, snapshot) {
                  var dataValue = snapshot.data;

                  if (dataValue is ImcStateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (dataValue is ImcStateError) {
                    return Text(dataValue.message);
                  }

                  return SizedBox.shrink();
                }),
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

                    controller.calcularImc(peso: peso, altura: altura);
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
