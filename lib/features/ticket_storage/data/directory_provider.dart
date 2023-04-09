import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class IDirectoryProvider {
  Future<Directory?> filesDownloadDirectory();
}

class DirectoryProvider implements IDirectoryProvider {
  const DirectoryProvider();

  @override
  Future<Directory?> filesDownloadDirectory() async {
    final downloadDir = await _downloadDirectory();
    if (downloadDir == null) return null;

    return Directory(downloadDir.path).create(recursive: true);
  }

  Future<Directory?> _downloadDirectory() async =>
      (Platform.isAndroid ? getExternalStorageDirectory() : getApplicationDocumentsDirectory());
}
