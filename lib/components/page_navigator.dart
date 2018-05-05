import 'package:flutter/material.dart';
import 'package:bank_account/login_page.dart';
import 'package:bank_account/create_account_page.dart';
import 'package:bank_account/menu_page.dart';
import 'package:bank_account/account_datail_page.dart';
import 'package:fluro/fluro.dart';
import 'package:bank_account/models/account.dart';

class Pages{
  static final routes = {
    loginPageRoute: (BuildContext context) => new LoginPage(),
    createAccountRoute: (BuildContext context) => new CreateAccountPage(),
    menuRoute: (BuildContext context) => new MenuPage(),
  };

  static final mainRoute = '/';
  static final loginPageRoute = '/login';
  static final createAccountRoute = '/createAccount';
  static final menuRoute = '/menu';

  static final Widget loginPage = new LoginPage();
  static final Widget createAccount = new CreateAccountPage();

  static void navigateToAccountDetail(BuildContext context, Account account) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new AccountDetailPage(account: account)
        ),
    );
  }

//  void navigateToAccountDetail(BuildContext context, Account account) {
//    Handler accountDetailHandler = new Handler(
//      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//      return new AccountDetailPage(account: account);
//    });
//    Router router = new Router()..define(
//        "/accountDetail/:account",
//        handler: accountDetailHandler
//    );
//  }
}

