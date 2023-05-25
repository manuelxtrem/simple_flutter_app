import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static bool isEmptyOrNull(dynamic obj) {
    // return true if obj is null
    if (obj == null) {
      return true;
    }

    // if its a number and is zero
    if (obj is int || obj is double) {
      return obj == 0;
    }

    // if its an empty string
    if (obj is String) {
      return obj.trim() == '';
    }

    // if its an empty array
    if (obj is Iterable) {
      return obj.isEmpty;
    }

    return false;
  }

  static T isEmptyOrNullOtherwise<T>(T? obj, T otherObj) {
    if (isEmptyOrNull(obj)) return otherObj;
    return obj!;
  }

  static String timeRemaining(Duration duration) {
    // final hours = (duration.inSeconds / 3600).floor();
    final mins = (duration.inSeconds / 60).floor();
    final secs = (duration.inSeconds % 60).floor();
    final minsText = mins.toString().padLeft(2, '0');
    final secsText = secs.toString().padLeft(2, '0');
    return '$minsText:$secsText';
  }

  static String timeRemainingWithHour(Duration duration) {
    final hours = (duration.inSeconds / 3600).floor();
    final mins = (duration.inSeconds / 60).floor();
    final secs = (duration.inSeconds % 60).floor();
    final hoursText = hours.toString().padLeft(2, '0');
    final minsText = mins.toString().padLeft(2, '0');
    final secsText = secs.toString().padLeft(2, '0');
    return '$hoursText:$minsText:$secsText';
  }

  static void log(Object? obj) {
    dev.log(obj?.toString() ?? 'null');
  }

  static generateRandomChar(int length) {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final rnd = math.Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  static String generateMD5(String input) {
    var bytes = utf8.encode(input); // Convert the input string to bytes
    var md5Hash = md5.convert(bytes); // Compute the MD5 hash
    return md5Hash.toString(); // Return the hashed value as a string
  }

  static String getSha1Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  static pageRoute(Widget page) {
    return MaterialPageRoute(builder: (context) => page);
  }

  static bool validateEmail(String email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  static String detectExceptionMessage(dynamic e) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          return 'The request timed out. Please try again';
        case DioErrorType.cancel:
          return 'The request has been cancelled';
        default:
          break;
      }
    }
    return 'An error occurred';
  }

  static String formatMoney(double? money, String? currency,
      {bool hideCurency = false}) {
    final currencyFormat = NumberFormat("#,##0.00", "en_US");
    if (hideCurency) {
      return currencyFormat.format(money);
    }
    return "$currency ${currencyFormat.format(money)}";
  }
}

extension EnumToString on Object {
  String toStringShort() {
    return describeEnum(this).split('.').last;
  }
}
