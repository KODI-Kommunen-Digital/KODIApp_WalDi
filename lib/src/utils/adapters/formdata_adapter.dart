import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class FormDataAdapter extends TypeAdapter<FormData> {
  @override
  final int typeId = 2;

  @override
  FormData read(BinaryReader reader) {
    final jsonString = reader.readString();
    final jsonData = jsonDecode(jsonString);
    final formData = FormData();

    jsonData.forEach((key, value) {
      if (value is XFile) {
        final file = MultipartFile.fromFileSync(value.path);
        formData.files.add(MapEntry(key, file));
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    return formData;
  }

  @override
  void write(BinaryWriter writer, FormData obj) {
    final jsonData = {};

    for (var entry in obj.fields) {
      jsonData[entry.key] = entry.value;
    }

    final jsonString = jsonEncode(jsonData);
    writer.writeString(jsonString);
  }
}
