import 'package:flutter/material.dart';
import 'package:bank_account/config/config_resources.dart';

class AppContainer extends StatelessWidget {

  const AppContainer({
    Key key,
    this.title,
    this.child
  }) :super(key: key);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    Widget _getLoadingPage() {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }

    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Padding(
          padding: new EdgeInsets.all(shortPadding),
          child: new Card(
            color: Colors.white,
            elevation: 4.0,
            child: new Container(
                alignment: Alignment.center,
                constraints: new BoxConstraints.expand(),
    //            margin: new EdgeInsets.all(10.0),
    //            color: Colors.white,
                child: child,
            ),
          ),
      ),
    );
  }
}