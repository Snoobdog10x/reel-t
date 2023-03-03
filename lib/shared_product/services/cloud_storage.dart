import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

enum File_Type { IMAGE, VIDEO }

class CloudStorage {
  Future<String> uploadFile(File_Type type, File file, String fileName) async {
    var refPath = _getRefPathFromFileType(type);
    final storageRef = FirebaseStorage.instance.ref(refPath);
    final fileRef = storageRef.child(fileName);
    fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }

  String _getRefPathFromFileType(File_Type file_type) {
    var fileTypeName = file_type.name.toLowerCase();
    return "${fileTypeName}s";
  }
}
