import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Quantidade de Água Diária',
    home: TelaInicial(),
    debugShowCheckedModeBanner: false,
  ));
}

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final _chaveFormulario = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  String resultado = ' ';

  void _calcular() {
    setState(() {
      double peso = double.parse(_pesoController.text);
      double ml = (peso * 35 / 1000);
      String mili = ml.toStringAsPrecision(3);

      resultado = "Você deve tomar $mili ml de água diariamente";
    });
  }

  void _resetar() {
    setState(() {
      _pesoController.text = '';
      resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Água Diária'),
          actions: [
            IconButton(
              onPressed: _resetar,
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Column(
            children: [
              Text(
                'Quantos litros de água devemos beber por dia?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.justify,
              ),
              Form(
                key: _chaveFormulario,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: TextFormField(
                        controller: _pesoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Qual é o seu peso?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (valor) {
                          if (valor!.isEmpty) {
                            return 'Informe seu peso';
                          } else if (valor.contains(' ')) {
                            return 'Não é permitido espaço';
                          } else if (valor.contains('-')) {
                            return 'Não é permitido hífens';
                          } else if (valor.contains(',')) {
                            return 'Não é permitido vírgulas';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_chaveFormulario.currentState!.validate()) {
                            _calcular();
                          }
                        },
                        color: Colors.indigo,
                        textColor: Colors.white,
                        child: Text(
                          'Calcular',
                          style: TextStyle(fontSize: 20),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  resultado,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
