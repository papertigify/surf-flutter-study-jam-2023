import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/models/ticket.dart';
import 'package:surf_flutter_study_jam_2023/utils/extensions/int_x.dart';
import 'package:surf_flutter_study_jam_2023/utils/extensions/string_x.dart';

class TicketState extends Equatable {
  final TicketStatus status;
  final Ticket ticket;
  final int loadedBytes;
  final int totalBytes;
  final File? downloadedFile;

  const TicketState({
    this.status = TicketStatus.initial,
    required this.ticket,
    this.loadedBytes = 0,
    this.totalBytes = 0,
    this.downloadedFile,
  });

  TicketState copyWith({
    TicketStatus? status,
    Ticket? ticket,
    int? loadedBytes,
    int? totalBytes,
    File? downloadedFile,
  }) {
    return TicketState(
      status: status ?? this.status,
      ticket: ticket ?? this.ticket,
      loadedBytes: loadedBytes ?? this.loadedBytes,
      totalBytes: totalBytes ?? this.totalBytes,
      downloadedFile: downloadedFile ?? this.downloadedFile,
    );
  }

  @override
  List<Object?> get props => [
        status,
        ticket,
        loadedBytes,
        totalBytes,
        downloadedFile,
      ];
}

extension TicketStateX on TicketState {
  String get loadedMb => loadedBytes.toMegabytes().removeTrailingZeros;

  String get totalMb => totalBytes.toMegabytes().removeTrailingZeros;

  double get progress => totalBytes > 0 ? loadedBytes / totalBytes : 0;
}

enum TicketStatus {
  initial,
  loading,
  paused,
  loaded,
}

extension TicketStatusX on TicketStatus {
  bool get isInitial => this == TicketStatus.initial;

  bool get isLoading => this == TicketStatus.loading;

  bool get isPaused => this == TicketStatus.paused;

  bool get isLoaded => this == TicketStatus.loaded;
}
