import 'package:flutter/material.dart';
import 'package:bank_account/components/app_container.dart';
import 'package:bank_account/config/config_resources.dart';
import 'package:bank_account/models/account.dart';
import 'package:bank_account/components/session_manager.dart';
import 'package:bank_account/components/page_navigator.dart';
import 'components/loading_page.dart';

const List<String> menu = const [
  'Ver Saldo',
  'Extrato',
  'Saque',
  'Depósito',
  'Transferência',
  'Trocar de usuário',
];

class MenuPage extends LoadingPage {
  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends LoadingPageState {
  Account _account;

  _goToAccountDetail() {
    Pages.navigateToAccountDetail(context, _account);
  }

  void _getSessionInformation() {
    SessionManager.verifySessionLogged().then((logged) {
      if(logged) {
        SessionManager.getSessionAccount().then((result) {
          setState(() {
            _account = result;
            isLoading = false;
          });
        });
      } else {
        AlertDialog dialog = new AlertDialog(
          content: new Text('Ocorreu um erro. Tente novamente mais tarde.'),
          actions: <Widget>[
            new FlatButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      Pages.mainRoute,
                      ModalRoute.withName(Pages.mainRoute));
                },
                child: new Text('Ok')
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
    });
  }

  Widget _buildRow(String itemMenu) {
    return new ListTile(
      title: new Text(
        itemMenu,
        style: new TextStyle(fontSize: 18.0),
      ),
    );
  }

  @override
  void initState() {
    _getSessionInformation();
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return new AppContainer(
      title: 'My Bank Account',
      child: new Column(
        children: <Widget>[
          new GestureDetector(
            onTap: _goToAccountDetail,
            child: new Container(
              padding: new EdgeInsets.symmetric(
                  vertical: bigPadding, horizontal: defaultPadding
              ),
              child: new ListBody(
                children: <Widget>[
                  new Text(
                    'Welcome,',
                    style: new TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 2,
                        child: new Container(
                            alignment: Alignment.centerRight,
                            child: new Text(
                              _account.name,
                              style: new TextStyle(
                                fontSize: 24.0,
                              ),
                            )
                        ),
                      ),
                      new Expanded(
                          flex: 1,
                          child: new Container(
                            alignment: Alignment.centerRight,
                            child: new Text(
                              _account.number,
                              style: new TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          new Divider(
            height: 1.0,
            color: Colors.black,
          ),

          new Expanded(
              child: new Container(
                  child: ListView.builder(
                      itemCount: menu.length,
                      itemBuilder: (context, i) {
                        return _buildRow(menu[i]);
                      }
                  )
              )
          ),
        ],
      ),
    );
  }
}