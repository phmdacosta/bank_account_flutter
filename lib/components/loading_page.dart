import 'package:flutter/material.dart';
import 'app_container.dart';

abstract class LoadingPage extends StatefulWidget {
  const LoadingPage({Key key}) : super(key: key);
}

abstract class LoadingPageState extends State<LoadingPage> {
  bool isLoading = true;

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    Widget _getLoadingPage() {
      return new AppContainer(
        title: 'My Bank Account',
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      );
    }

    return isLoading ? _getLoadingPage() : buildPage(context);
  }
}