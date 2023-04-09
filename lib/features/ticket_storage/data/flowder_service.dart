import 'dart:io';

import 'package:flowder/flowder.dart' hide ProgressCallback;
import 'package:flutter/foundation.dart';
import 'file_download_repository.dart';

/// Flowder package wrapper
class FlowderService {
  const FlowderService();

  Future<DownloaderCore> download({
    required String url,
    required String savePath,
    required ProgressCallback onReceiveProgress,
    required VoidCallback onDone,
  }) async {
    final downloaderUtils = DownloaderUtils(
      progressCallback: onReceiveProgress,
      file: File(savePath),
      progress: ProgressImplementation(),
      onDone: onDone,
      deleteOnCancel: true,
    );

    final core = await Flowder.download(url, downloaderUtils);

    return core;
  }

  Future<void> pause(DownloaderCore core) async => core.pause();

  Future<void> resume(DownloaderCore core) async => core.resume();

  Future<void> cancel(DownloaderCore core) async => core.cancel();
}
