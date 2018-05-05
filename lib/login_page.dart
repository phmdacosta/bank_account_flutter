import 'package:flutter/material.dart';
import 'package:bank_account/components/app_container.dart';
import 'package:bank_account/config/config_resources.dart';
import 'package:bank_account/models/account.dart';
import 'package:bank_account/components/session_manager.dart';
import 'components/page_navigator.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final _numberFieldController = new TextEditingController();
  final _passFieldController = new TextEditingController();
  String _accountNumber;
  String _accountPass;

  login() async {
//    final form = formKey.currentState;
//    form.save();

    AccountProvider provider = new AccountProvider();
    Account account = await provider.getAccount(
        _numberFieldController.text, _passFieldController.text);

    if (account == null) {
      AlertDialog dialog = new AlertDialog(
        content: new Text("Account number or password are incorrect"),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              }
          )
        ],
      );
      showDialog(context: context, child: dialog);
    } else {
      SessionManager.doLogin(account.id);
      Navigator.pushNamedAndRemoveUntil(
          context, Pages.menuRoute, ModalRoute.withName(Pages.mainRoute));
    }
  }

  @override
  void initState() {
    _numberFieldController.text = '91120';
    _passFieldController.text = '5601';
    super.initState();
  }

  @override
  void dispose() {
    _numberFieldController.dispose();
    _passFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AppContainer(
      title: 'Login',
      child: new Padding(
          padding: new EdgeInsets.all(bigPadding),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.all(shortPadding),
                    child: new TextFormField(
                      controller: _numberFieldController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: 'Account Number',
                      ),
                      autofocus: true,
                      maxLength: 5,
//                      onSaved: (value){
//                        _accountNumber = value;
//                      },
                    ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(shortPadding),
                  child: new TextFormField(
                    controller: _passFieldController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Password',
                    ),
                    autofocus: true,
                    maxLength: 4,
//                    onSaved: (value){
//                      _accountPass = value;
//                    },
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(shortPadding),
                  child: new RaisedButton(
                      child: new Text(
                          'Login',
                          style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          )
                      ),
                      color: Theme.of(context).accentColor,
                      elevation: 5.0,
                      splashColor: appColor[200],
                      onPressed: login,
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}