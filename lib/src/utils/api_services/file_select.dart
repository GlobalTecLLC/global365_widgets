// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:file_picker/file_picker.dart';

// class FileSelectService {
//   static Future<String?> selectFiletoBase64() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: false,
//      // allowedExtensions: ['jpg', 'jpeg', 'png'],
//     );

//     if (result != null) {
//       Uint8List? bytes = result.files.single.bytes;

//       // Handle platforms where bytes are not directly available (e.g., macOS and Windows)
//       if (bytes == null && result.files.single.path != null) {
//         try {
//           final file = File(result.files.single.path!);
//           bytes = await file.readAsBytes();
//         } catch (e) {
//           print("Error reading file bytes: $e");
//           return null;
//         }
//       }

//       if (bytes != null) {
//         String img64 = "data:image/${result.files.single.extension};base64,${base64Encode(bytes)}";
//         return img64;
//       }
//     }

//     return null;
//   }
// }
