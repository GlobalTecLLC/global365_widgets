import 'dart:typed_data';

class MultiPartFileModel {
  Uint8List fileBytes;
  String fileName;
  String mimeType;

  MultiPartFileModel({required this.fileBytes, required this.fileName, required this.mimeType});
}
