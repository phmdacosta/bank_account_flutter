import 'package:bank_account/database/provider.dart';
import 'package:flutter/material.dart';
import 'package:bank_account/components/app_container.dart';
import 'package:bank_account/config/config_resources.dart';
import 'models/account.dart';
import 'dart:math';

TextStyle fieldStyle = new TextStyle(color: Colors.grey);

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => new _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final formKey = new GlobalKey<FormState>();
  final _nameController = new TextEditingController();
  final _ageController = new TextEditingController();
  final _addressController = new TextEditingController();
  final _addressNumberController = new TextEditingController();
  final _complementController = new TextEditingController();
  final _zipcodeController = new TextEditingController();
  final _cityController = new TextEditingController();
  final _stateController = new TextEditingController();
  final _telephoneController = new TextEditingController();
  final _cellphoneController = new TextEditingController();
  String _gender;

  void onSelectRadio(String value) {
    setState(() {
      _gender = value;
    });
  }

  bool _fieldEmpty(String value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  String _validateEmptyField(String value) {
    if (_fieldEmpty(value))
      return 'Preencha o campo';

    return null;
  }

  String getRandomAccountNumber() {
    int newNumber = new Random().nextInt(99999);
    String sNumber = "$newNumber";

    if (sNumber.length >= 5)
      return sNumber;

    String zeros;
    for (int i = 0; i < (5 - sNumber.length); i++) {
      zeros = "0$zeros";
    }

    return "$zeros$sNumber";
  }

  String getRandomAccountPass() {
    int newPass = 0;
    do {
      newPass = new Random().nextInt(9999);
    } while (newPass < 1000);

    return "$newPass";
  }

  void submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
//      form.save();

      Account account = new Account();
      String newNumber = getRandomAccountNumber();
      String newPassword = getRandomAccountPass();
      account.number = newNumber;
      account.password = newPassword;
      account.name = _nameController.text;
      account.age = _ageController.text;
      account.gender = _gender;
      account.address = _addressController.text;
      account.addressNumber = _addressNumberController.text;
      account.complement = _complementController.text;
      account.zipcode = _zipcodeController.text;
      account.city = _cityController.text;
      account.state = _stateController.text;
      account.telephone = _telephoneController.text;
      account.cellphone = _cellphoneController.text;

      AccountProvider provider = new AccountProvider();
      account = await provider.saveAccount(account);
      List<Text> mensagensAlert;
      if (account.id > 0) {
        mensagensAlert = <Text>[
          new Text("Cadastro efetuado!"),
          new Text("O número de sua conta é: $newNumber"),
          new Text("Sua senha é: $newPassword")
        ];
      } else {
        mensagensAlert = <Text>[new Text("Ocorreu um erro no cadastro")];
      }

      AlertDialog dialog = new AlertDialog(
        content: new SingleChildScrollView(
          child: new ListBody(
            children: mensagensAlert,
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              }
          )
        ],
      );
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return dialog;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new AppContainer(
      title: 'Create Account',
      child: new Padding(
          padding: new EdgeInsets.all(bigPadding),
          child: new Form(
              key: formKey,
              // Usei ListView ao invés de Column, pois o Column estava dando
              // o seguinte erro: Bottom Overflowed By X Pixels.
              child: new ListView(
                children: <Widget>[
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        // Utrilizando o widget Flexible, pois o Row precisa que
                        // seus filhos possuam um tamanho intrísico definido
                        // (pois ele se adapta ao filho).
                        // Como o TextField possui o tamanho máximo de seu pai,
                        // então é lançada uma exception.
                        // Definindo o TextField como flexible ou expanded é dada
                        // uma dimensão a ele, evitando a exceção.
                        new Expanded(
                          // O atributo flex define o tamanho ocupada pelo widget
                          // dentro de um espaço. (parecido com weight)
                          flex: 3,
                          child: new Container(
                            child: new TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                labelText: 'Name*',
                                labelStyle: fieldStyle
                              ),
                              autofocus: true,
                              validator: (value) => _validateEmptyField(value),
//                              onSaved: (value){
//                                widget._name = value;
//                              },
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            padding: new EdgeInsets.only(left: shortPadding),
                            child: new TextFormField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: 'Age*',
                                labelStyle: fieldStyle
                              ),
                              validator: (value) => _validateEmptyField(value),
//                              onSaved: (value){
//                                widget._age = value;
//                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.only(top: shortPadding),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Expanded(
                          flex: 20,
                          child: new Container(
                            child: new Text(
                                'Gender*:',
                                style: fieldStyle,
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 38,
                          child: new Container(
                            child: new RadioListTile<String>(
                              title: new Text(
                                  'Male',
                                  style: fieldStyle,
                              ),
                              value: 'M',
                              groupValue: _gender,
                              onChanged: onSelectRadio,
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 42,
                          child: new Container(
                            child: new RadioListTile<String>(
                                title: new Text(
                                    'Female',
                                    style: fieldStyle,
                                ),
                                value: 'F',
                                groupValue: _gender,
                                onChanged: onSelectRadio
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.only(top: shortPadding),
                    child: new TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        labelText: 'Address*',
                        labelStyle: fieldStyle
                      ),
                      validator: _validateEmptyField,
//                      onSaved: (value){
//                        widget._address = value;
//                      },
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.only(top: shortPadding),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new TextFormField(
                              controller: _addressNumberController,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: 'Number*',
                                labelStyle: fieldStyle
                              ),
                              validator: _validateEmptyField,
//                              onSaved: (value){
//                                widget._addressNumber = value;
//                              },
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 2,
                          child: new Container(
                            padding: new EdgeInsets.only(left: shortPadding),
                            child: new TextFormField(
                              controller: _complementController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                labelText: 'Complement',
                                labelStyle: fieldStyle
                              ),
//                              onSaved: (value){
//                                widget._complement = value;
//                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.only(top: shortPadding),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            child: new TextFormField(
                              controller: _cityController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                labelText: 'City*',
                                labelStyle: fieldStyle
                              ),
                              validator: _validateEmptyField,
//                              onSaved: (value){
//                                widget._city = value;
//                              },
                            ),
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            padding: new EdgeInsets.only(left: shortPadding),
                            child: new TextFormField(
                              controller: _stateController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                labelText: 'State*',
                                labelStyle: fieldStyle
                              ),
                              validator: _validateEmptyField,
//                              onSaved: (value){
//                                widget._state = value;
//                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.only(top: shortPadding),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            child: new TextFormField(
                              controller: _telephoneController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                labelText: 'Telephone*',
                                labelStyle: fieldStyle
                              ),
                              validator: _validateEmptyField,
//                              onSaved: (value){
//                                widget._telephone = value;
//                              },
                            ),
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            padding: new EdgeInsets.only(left: shortPadding),
                            child: new TextFormField(
                              controller: _cellphoneController,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                labelText: 'Cellphone*',
                                labelStyle: fieldStyle
                              ),
                              validator: _validateEmptyField,
//                              onSaved: (value){
//                                widget._cellphone = value;
//                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.only(top: bigPadding),
                    alignment: Alignment.center,
                    child: new RaisedButton(
                        child: new Text(
                            'Create',
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )
                        ),
                        color: Theme.of(context).accentColor,
                        elevation: 5.0,
                        splashColor: appColor[200],
                        onPressed: submit
                    ),
                  )
                ],
              ),
          ),
      ),
    );
  }
}