import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bank_account/config/config_resources.dart';
import 'package:bank_account/components/app_container.dart';
import 'package:bank_account/components/page_navigator.dart';

void main() => runApp(new BankAccountApp());

class BankAccountApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: appColor,
      ),
      routes: Pages.routes,
      home: new MainHomePage(title: 'My Bank Account'),
    );
  }
}

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainHomePageState createState() => new _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return new AppContainer(
      title: widget.title,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(defaultPadding),
            child: new RaisedButton(
                child: new Padding(
                  padding: new EdgeInsets.all(bigPadding),
                  child: new Text(
                      'Sign in',
                      style: new TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                      )
                  ),
                ),
                color: Theme.of(context).accentColor,
                elevation: 5.0,
                splashColor: appColor[200],
                onPressed: (){
                  Navigator.pushNamed(context, Pages.loginPageRoute);
                }
            ),
          ),
          new Padding(
              padding: new EdgeInsets.all(defaultPadding),
              child: new Text('or')
          ),
          new Padding(
              padding: new EdgeInsets.all(defaultPadding),
              child: new FlatButton(
                  child: new Text(
                    'Create a Account',
                    style: new TextStyle(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Pages.createAccountRoute);
                  },
              ),
          )
//          new Padding(
//              padding: new EdgeInsets.all(paddingDefault),
//              child: new RichText(
//                  text: new TextSpan(
//                      text: 'Create a Account',
//                      style: new TextStyle(color: Theme.of(context).accentColor),
                      // .. servem para acessar atributos ou métodos de um objeto
                      // instanciado sem a necessidade de usar a variável onde
                      // está o objeto.
                      // Exemplo:
                      // ao invés de:
                      //    o = new Object()
                      //    o.set(x)
                      // faz isso:
                      //    o = new Object()..set(x)
//                      recognizer: new TapGestureRecognizer()..onTap = (){
//                        pushToPage(context, Pages.createAccount);
//                      }
//                  )
//              )
//          )
        ],
      ),
    );
  }
}
