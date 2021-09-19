import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:json_class/json_class.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/digests/sha256.dart';

/// Represents an image from a test.
@immutable
class TestImage extends JsonClass {
  TestImage({
    int? captureTime,
    required this.goldenCompatible,
    String? hash,
    required this.id,
    Uint8List? image,
  })  : captureTime = captureTime ?? DateTime.now().millisecondsSinceEpoch,
        hash = hash ??
            hex.encode(
              SHA256Digest().process(image ?? Uint8List(0)),
            ),
        image = image;

  /// The time the image was captured in UTC Millis.
  final int captureTime;

  /// Set to [true] if this image can be saved as a golden image.  Set to
  /// [false] if it contains dynamic data that can't be automatically handled
  /// and is meant to be manually reviewed instead.
  final bool goldenCompatible;

  /// A sha256 hash of the image bytes
  final String hash;

  /// The identifier for the screenshot
  final String id;

  /// The actual bytes from the image.
  final Uint8List? image;

  static TestImage fromDynamic(dynamic map) {
    late TestImage result;

    if (map == null) {
      throw Exception('[TestImage.fromDynamic]: map is null');
    } else {
      result = TestImage(
        captureTime: JsonClass.parseInt(map['captureTime']),
        goldenCompatible: JsonClass.parseBool(map['goldenCompatible']),
        hash: map['hash'],
        id: map['id'],
        image: map['image'] == null ? null : base64.decode(map['image']),
      );
    }

    return result;
  }

  static List<Map<String, dynamic>>? toJsonList(
    List<TestImage>? images, [
    bool includeImageData = false,
  ]) {
    List<Map<String, dynamic>>? result;

    if (images != null) {
      result = <Map<String, dynamic>>[];

      for (var image in images) {
        result.add(image.toJson(includeImageData));
      }
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson([bool includeImageData = false]) => {
        'captureTime': captureTime,
        'goldenCompatible': goldenCompatible,
        'hash': hash,
        'id': id,
        if (includeImageData == true && image != null)
          'image': base64.encode(image ?? Uint8List(0)),
      };
}
