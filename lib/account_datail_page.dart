import 'package:flutter/material.dart';
import 'components/app_container.dart';
import 'config/config_resources.dart';
import 'models/account.dart';
import 'components/session_manager.dart';
import 'components/page_navigator.dart';
import 'package:bank_account/styles/styles.dart';

class AccountDetailPage extends StatefulWidget {

  AccountDetailPage({Key key, this.account}) :super(key: key);

  final Account account;

  @override
  State<StatefulWidget> createState() => new _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {

  _doLogout(int accountId) {
    SessionManager.doLogout(accountId).then((result) {
      Navigator.pushNamedAndRemoveUntil(
          context, Pages.mainRoute, ModalRoute.withName(Pages.mainRoute));
    });
  }

  String _getGender(String genderData) {
    if (genderData.contains("M")) {
      return "Male";
    }
    return "Female";
  }

  String _getCompleteAddress(Account account) {
    String address = account.address;
    String number = account.addressNumber;
    String complement = account.complement;
    return "$address, $number - $complement";
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      title: "Account Detail",
      child: new Container(
        padding: new EdgeInsets.all(defaultPadding),
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Image(image: new AssetImage("graphics/profile.png")),
            ),

            new Container(
              padding: new EdgeInsets.only(top: bigPadding),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Expanded(
                    flex: 3,
                    child: new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text("Name", style: new LabelStyle()),
                          ),
                          new Container(
                            padding: new EdgeInsets.only(top: shortPadding),
                            child: new Text(
                                widget.account.name, style: new DefaultStyle()
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                  new Expanded(
                    flex: 1,
                    child: new Container(
                      padding: new EdgeInsets.only(left: bigPadding),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            child: new Text("Age", style: new LabelStyle()),
                          ),
                          new Container(
                            padding: new EdgeInsets.only(top: shortPadding),
                            child: new Text(
                              widget.account.age, style: new DefaultStyle(),
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                ],
              ),
            ),

            new Container(
              padding: new EdgeInsets.only(top: bigPadding),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    new Container(
                      child: new Text("Gender", style: new LabelStyle()),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: shortPadding),
                      child: new Text(
                          _getGender(widget.account.gender),
                          style: new DefaultStyle()
                      ),
                    )
                ],
              ),
            ),

            new Container(
              padding: new EdgeInsets.only(top: bigPadding),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: new Text("Address", style: new LabelStyle()),
                  ),
                  new Container(
                    padding: new EdgeInsets.only(top: shortPadding),
                    child: new Text(
                        _getCompleteAddress(widget.account),
                        style: new DefaultStyle()
                    ),
                  )
                ],
              ),
            ),

            new Container(
              padding: new EdgeInsets.only(top: bigPadding),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new Text("City", style: new LabelStyle()),
                              ),
                              new Container(
                                padding: new EdgeInsets.only(top: shortPadding),
                                child: new Text(
                                    widget.account.city, style: new DefaultStyle()
                                ),
                              ),
                            ],
                          )
                      )
                  ),
                  new Expanded(
                      child: new Container(
                          padding: new EdgeInsets.only(left: bigPadding),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new Text("State", style: new LabelStyle()),
                              ),
                              new Container(
                                padding: new EdgeInsets.only(top: shortPadding),
                                child: new Text(
                                  widget.account.state, style: new DefaultStyle(),
                                ),
                              ),
                            ],
                          )
                      )
                  ),
                ],
              ),
            ),

            new Container(
              padding: new EdgeInsets.only(top: bigPadding),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new Text("Telephone", style: new LabelStyle()),
                              ),
                              new Container(
                                padding: new EdgeInsets.only(top: shortPadding),
                                child: new Text(
                                    widget.account.telephone, style: new DefaultStyle()
                                ),
                              ),
                            ],
                          )
                      )
                  ),
                  new Expanded(
                      child: new Container(
                          padding: new EdgeInsets.only(left: bigPadding),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                child: new Text("Cellphone", style: new LabelStyle()),
                              ),
                              new Container(
                                padding: new EdgeInsets.only(top: shortPadding),
                                child: new Text(
                                  widget.account.cellphone, style: new DefaultStyle(),
                                ),
                              ),
                            ],
                          )
                      )
                  ),
                ],
              ),
            ),

            new Container(
              padding: new EdgeInsets.all(xxBigPadding),
              alignment: Alignment.center,
              child: new FlatButton(
                  onPressed: (){
                    _doLogout(widget.account.id);
                  },
                  child: new Text(
                    "Logout",
                    style: new TextStyle(color: Theme.of(context).accentColor),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}