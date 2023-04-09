import 'dart:async';
import 'dart:io';

import 'package:flowder/flowder.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/directory_provider.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/flowder_service.dart';
import 'package:path/path.dart' as p;

typedef ProgressCallback = void Function(int count, int total);

abstract class IFileDownloadRepository {
  Future<File?> download({
    required String url,
    required String fileName,
    required ProgressCallback onReceiveProgress,
  });

  Future<void> pause(String url);

  Future<void> resume(String url);

  Future<void> cancel(String url);
}

/// IFileDownloadRepository implementation using Flowder package
class FileDownloadRepository implements IFileDownloadRepository {
  final FlowderService _downloadService;
  final IDirectoryProvider _directoryProvider;

  final Map<String, DownloaderCore> _activeDownloads;

  FileDownloadRepository(
    this._downloadService,
    this._directoryProvider,
  ) : _activeDownloads = <String, DownloaderCore>{};

  @override
  Future<File?> download({
    required String url,
    required String fileName,
    required ProgressCallback onReceiveProgress,
  }) async {
    final dir = await _directoryProvider.filesDownloadDirectory();
    if (dir == null) return null;

    final savePath = p.join(dir.path, fileName);

    final completer = Completer<File?>();

    final core = await _downloadService.download(
      url: url,
      savePath: savePath,
      onReceiveProgress: onReceiveProgress,
      onDone: () async {
        final file = File(savePath);
        completer.complete(await file.exists() ? file : null);
      },
    );

    _activeDownloads.putIfAbsent(url, () => core);

    return completer.future;
  }

  @override
  Future<void> pause(String url) async {
    return _activeDownloads[url]?.pause();
  }

  @override
  Future<void> resume(String url) async {
    return _activeDownloads[url]?.resume();
  }

  @override
  Future<void> cancel(String url) async {
    final core = _activeDownloads[url];
    _activeDownloads.remove(url);

    return core?.cancel();
  }
}
