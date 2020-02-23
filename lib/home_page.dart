import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _ctrPeso = new TextEditingController();
  var _ctrAltura = new TextEditingController();
  String _retorno = '';
  Color _corTexto = Colors.green;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: limpar,
          )
        ],
        title: Center(
          child: Text(
            'CÁLCULO DE IMC',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 120,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  child: TextFormField(
                    controller: _ctrPeso,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe seu Peso';
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  child: TextFormField(
                    controller: _ctrAltura,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe sua Altura';
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          calculaImc();
                        }
                      },
                      child: Text('CALCULAR'),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    _retorno,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _corTexto,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  limpar() {
    setState(() {
      _ctrPeso = new TextEditingController();
      _ctrAltura = new TextEditingController();
      _retorno = '';
    });
  }

  calculaImc() {
    var peso = double.parse(_ctrPeso.text.replaceAll(',', ''));
    var altura = double.parse(_ctrAltura.text.replaceAll(',', '')) / 100;
    var result = peso / (altura * altura);
    var labelResult = result.toStringAsFixed(1);

    setState(() {
      if (result < 18.5) {
        _retorno = '($labelResult) MAGRO';
      } else if (result >= 18.5 && result <= 24.9) {
        _retorno = '($labelResult) NORMAL';
        _corTexto = Colors.green;
      } else if (result >= 25 && result <= 29.9) {
        _retorno = '($labelResult) SOBREPESO';
        _corTexto = Colors.amber;
      } else if (result >= 30 && result <= 39.9) {
        _retorno = '($labelResult) OBESIDADE';
        _corTexto = Colors.orange;
      } else if (result >= 40) {
        _retorno = '($labelResult) OBESIDADE GRAVE';
        _corTexto = Colors.red;
      }
    });
  }
}
