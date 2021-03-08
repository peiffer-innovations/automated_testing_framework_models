import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/export.dart';

/// Helper class to generate signatures for use by test drivers as well as
/// driven devices.
class DriverSignatureHelper {
  factory DriverSignatureHelper() => _singleton;
  DriverSignatureHelper._internal();

  static final DriverSignatureHelper _singleton =
      DriverSignatureHelper._internal();

  final Random random = Random.secure();

  /// Returns a HEX encode HMAC-256 signature for the list of [args] using the
  /// given [secret] key.
  String createSignature(String secret, List<String> args) {
    // for HMAC SHA-256, block length must be 64
    final hmac = HMac(SHA256Digest(), 64)
      ..init(KeyParameter(Uint8List.fromList(utf8.encode(secret))));

    var data = utf8.encode(args.join('|'));

    return hex.encode(hmac.process(Uint8List.fromList(data)));
  }

  /// Creates secure random HEX encoded string containing the given number of
  /// bytes seeding the string.
  String createSalt([int size = 2048]) {
    assert(size > 0);
    var bits = <int>[];
    for (var i = 0; i < size; i++) {
      bits.add(random.nextInt(256));
    }
    var salt = hex.encode(bits);

    return salt;
  }
}
