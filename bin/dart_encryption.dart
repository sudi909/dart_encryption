import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';

String stringEncryption(String action, String string, String secretKey, String secretIv) {
  final key = Key.fromUtf8(sha256.convert(utf8.encode(secretKey)).toString().substring(0, 32));
  final iv = IV.fromUtf8(sha256.convert(utf8.encode(secretIv)).toString().substring(0, 16));

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  if (action == 'encrypt') {
    final encrypted = encrypter.encrypt(string, iv: iv);
    return encrypted.base64;
  } else if (action == 'decrypt') {
    final decrypted = encrypter.decrypt64(string, iv: iv);
    return decrypted;
  } else {
    return 'Invalid action';
  }
}

void main(List<String> arguments) {
  if (arguments.length < 4) {
    print('Usage: dart run encryption_example <encrypt|decrypt> <string> <secretKey> <secretIv>');
    return;
  }

  String action = arguments[0];
  String inputString = arguments[1];
  String secretKey = arguments[2];
  String secretIv = arguments[3];

  String result = stringEncryption(action, inputString, secretKey, secretIv);
  print('Result: $result');
}
