import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  clear() async {
    _sharedPrefs.clear();
  }

  String get username => _sharedPrefs.getString(keyUsername) ?? "";

  set username(String value) {
    _sharedPrefs.setString(keyUsername, value);
  }

  String get uid => _sharedPrefs.getString(keyUID) ?? "";

  set uid(String value) {
    _sharedPrefs.setString(keyUID, value);
  }

  String get token => _sharedPrefs.getString(keyToken) ?? "";

  set token(String value) {
    _sharedPrefs.setString(keyToken, value);
  }

  String get email => _sharedPrefs.getString(keyEmail) ?? "";

  set email(String value) {
    _sharedPrefs.setString(keyEmail, value);
  }

  bool get isSeller => _sharedPrefs.getBool(keyIsSeller) ?? false;

  set isSeller(bool value) {
    _sharedPrefs.setBool(keyIsSeller, value);
  }

  String get name => _sharedPrefs.getString(keyName) ?? null;

  set name(String value) {
    _sharedPrefs.setString(keyName, value);
  }

  String get phone => _sharedPrefs.getString(keyPhone) ?? "";

  set phone(String value) {
    _sharedPrefs.setString(keyPhone, value);
  }

  String get subscriptionStart =>
      _sharedPrefs.getString(keySubscriptionStart) ?? "";

  set subscriptionStart(String value) {
    _sharedPrefs.setString(keySubscriptionStart, value);
  }

  String get subscriptionEnd =>
      _sharedPrefs.getString(keySubscriptionEnd) ?? "";

  set subscriptionEnd(String value) {
    _sharedPrefs.setString(keySubscriptionEnd, value);
  }

  int get tradeLicense => _sharedPrefs.getInt(keyTradeLicense) ?? "";

  set tradeLicense(int value) {
    _sharedPrefs.setInt(keyTradeLicense, value);
  }

  String get subscriptionMonths =>
      _sharedPrefs.getString(keySubscriptionMonths) ?? "";

  set subscriptionMonths(String value) {
    _sharedPrefs.setString(keySubscriptionMonths, value);
  }

  String get address => _sharedPrefs.getString(keyAddress) ?? "";

  set address(String value) {
    _sharedPrefs.setString(keyAddress, value);
  }

  String get city => _sharedPrefs.getString(keyCity) ?? "";

  set city(String value) {
    _sharedPrefs.setString(keyCity, value);
  }

  String get a => _sharedPrefs.getString(keyA) ?? "";

  set a(String value) {
    _sharedPrefs.setString(keyA, value);
  }

  String get shopPicture => _sharedPrefs.getString(keyShopPicture) ?? "";

  set shopPicture(String value) {
    _sharedPrefs.setString(shopPicture, value);
  }

  String get shopName => _sharedPrefs.getString(keyShopName) ?? "";

  set shopName(String value) {
    _sharedPrefs.setString(keyShopName, value);
  }

  bool get firstLaunch => _sharedPrefs.getBool(keyFirstLaunch) ?? true;

  set firstLaunch(bool value) {
    _sharedPrefs.setBool(keyFirstLaunch, value);
  }

  bool get referral => _sharedPrefs.getBool(keyReferral) ?? false;

  set referral(bool value) {
    _sharedPrefs.setBool(keyReferral, value);
  }

  bool get isGuest => _sharedPrefs.getBool(keyGuest) ?? false;

  set isGuest(bool value) {
    _sharedPrefs.setBool(keyGuest, value);
  }
}

final sharedPrefs = SharedPrefs();

const String keyUID = "key_uid";
const String keyUsername = "key_username";
const String keyToken = "key_token";
const String keyEmail = "key_email";
const String keyIsSeller = "key_is_seller";
const String keyName = "key_name";
const String keyPhone = "key_phone";
const String keyReferral = "key_referral";
const String keySubscriptionStart = "key_subscription_start";
const String keySubscriptionEnd = "key_subscription_end";
const String keyTradeLicense = "key_trade_license";
const String keySubscriptionMonths = "key_subscription_months";
const String keyAddress = "key_address";
const String keyCity = "key_city";
const String keyA = "key_a";
const String keyShopPicture = "key_shop_picture";
const String keyShopName = "key_shop_name";
const String keyFirstLaunch = "key_first_launch";
const String keyGuest = 'key_guest';
