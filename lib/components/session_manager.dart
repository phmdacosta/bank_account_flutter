import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bank_account/models/account.dart';

class SessionManager {
  static const String _accountIdKey = "account_logged_id";

  static void doLogin(int accountId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(_accountIdKey, accountId);
  }

  static Future<Account> getSessionAccount() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int accountId = sp.getInt(_accountIdKey);
    AccountProvider provider = new AccountProvider();
    Account account = await provider.getAccountById(accountId);
    return account;
  }

  static Future<bool> verifySessionLogged() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int accountId = sp.getInt(_accountIdKey);
    return (accountId != null && accountId > 0);
  }

  static Future<bool> doLogout(int accountId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.remove(_accountIdKey);
  }
}