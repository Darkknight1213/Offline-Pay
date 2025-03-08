import 'package:flutter/services.dart';

class USSDService {
  static const platform = MethodChannel('com.offlinepay/ussd');

  static Future<bool> makeUSSDPayment(String phone, String amount) async {
    try {
      await platform.invokeMethod('dialUSSD', {
        'ussdCode': '*99#',
        'phone': phone,
        'amount': amount,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
