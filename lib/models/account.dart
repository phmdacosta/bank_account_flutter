import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:bank_account/database/provider.dart';

class Account {
  int _id;
  String _number, _password;
  String _name, _age, _gender;
  String _address, _addressNumber, _complement, _zipcode, _city, _state;
  String _telephone, _cellphone;

//  set id(int value) => _id = value;
  int get id => _id;

  set number(String value) => _number = value;
  String get number => _number;

  set password(String value) => _password = value;
  String get password => _password;

  set name(String value) => _name = value;
  String get name => _name;

  set age(String value) => _age = value;
  String get age => _age;

  set gender(String value) => _gender = value;
  String get gender => _gender;

  set address(String value) => _address = value;
  String get address => _address;

  set addressNumber(String value) => _addressNumber = value;
  String get addressNumber => _addressNumber;

  set complement(String value) => _complement = value;
  String get complement => _complement;

  set zipcode(String value) => _zipcode = value;
  String get zipcode => _zipcode;

  set city(String value) => _city = value;
  String get city => _city;

  set state(String value) => _state = value;
  String get state => _state;

  set telephone(String value) => _telephone = value;
  String get telephone => _telephone;

  set cellphone(String value) => _cellphone = value;
  String get cellphone => _cellphone;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["number"] = _number;
    map["password"] = _password;
    map["name"] = _name;
    map["age"] = _age;
    map["gender"] = _gender;
    map["address"] = _address;
    map["address_number"] = _addressNumber;
    map["complement"] = _complement;
    map["zipcode"] = _zipcode;
    map["city"] = _city;
    map["state"] = _state;
    map["telephone"] = _telephone;
    map["cellphone"] = _cellphone;
    return map;
  }

  void fromMap(Map map) {
    _id = map["id"];
    _number = map["number"];
    _password = map["password"];
    _name = map["name"];
    _age = map["age"];
    _gender = map["gender"];
    _address = map["address"];
    _addressNumber = map["address_number"];
    _complement = map["complement"];
    _zipcode = map["zipcode"];
    _city = map["city"];
    _state = map["state"];
    _telephone = map["telephone"];
    _cellphone = map["cellphone"];
  }
}

class AccountProvider extends Provider {

  AccountProvider() : super();

  @override
  void onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE Account("
        "id INTEGER PRIMARY KEY, "
        "number TEXT, "
        "password TEXT, "
        "name TEXT, "
        "age TEXT, "
        "gender TEXT, "
        "address TEXT, "
        "address_number TEXT, "
        "complement TEXT, "
        "zipcode TEXT, "
        "city TEXT, "
        "state TEXT, "
        "telephone TEXT, "
        "cellphone TEXT)");
    print("Created tables");
  }

  Future<Account> saveAccount(Account account) async {
    var dbClient = await db;
    account._id = await dbClient.insert("Account", account.toMap());
    await dbClient.close();
    return account;
  }

  Future<Account> getAccount(String number, String password) async {
    print('############### getAccount($number, $password)');
    var dbClient = await db;
    List<Map> accountMapList = await dbClient.query(
        "Account", where: "number = ? AND password = ?",
        whereArgs: [number, password]);
    await dbClient.close();

    Account account;
    if (accountMapList.length > 0) {
      account = new Account()..fromMap(accountMapList.first);
    }
    return account;
  }

  Future<Account> getAccountById(int id) async {
    print('############### getAccountById($id)');
    var dbClient = await db;
    List<Map> accountMapList = await dbClient.query(
        "Account", where: "id = ?", whereArgs: [id]);
    await dbClient.close();

    Account account;
    if (accountMapList.length > 0) {
      account = new Account()..fromMap(accountMapList.first);
    }
    return account;
  }

  Future<bool> deleteAccount(int id) async {
    var dbClient = await db;
    int res = await dbClient.delete("Account", where: "id = ?", whereArgs: [id]);
    await dbClient.close();
    return res > 0;
  }
}