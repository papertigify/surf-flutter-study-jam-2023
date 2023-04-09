import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/file_download_repository.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/models/ticket.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/models/ticket_state.dart';

part 'ticket_storage_event.dart';

part 'ticket_storage_state.dart';

class TicketStorageBloc extends Bloc<TicketStorageEvent, TicketStorageState> {
  final IFileDownloadRepository _downloadRepository;

  TicketStorageBloc(
    this._downloadRepository,
  ) : super(TicketStorageState()) {
    on<DownloadPressed>(_onDownloadPressed);
    on<PauseResumeEvent>(_onPauseResumeEvent, transformer: droppable());
    on<NewUrlAdded>(_onNewUrlAdded);
  }

  Future<void> _onDownloadPressed(
    DownloadPressed event,
    Emitter<TicketStorageState> emit,
  ) async {
    final index = state.ticketStates.indexWhere((e) => e.ticket.url == event.ticketState.ticket.url);
    if (index == -1) return;

    final ticketState = state.ticketStates[index];

    emit(
      state.copyWith(
        ticketStates: List.of(state.ticketStates)
          ..removeAt(index)
          ..insert(index, ticketState.copyWith(status: TicketStatus.loading)),
      ),
    );

    final file = await _downloadRepository.download(
      url: ticketState.ticket.url,
      fileName: ticketState.ticket.name,
      onReceiveProgress: (count, total) {
        final ticketState = state.ticketStates[index];

        emit(
          state.copyWith(
            ticketStates: List.of(state.ticketStates)
              ..removeAt(index)
              ..insert(index, ticketState.copyWith(loadedBytes: count, totalBytes: total)),
          ),
        );
      },
    );

    emit(
      state.copyWith(
        ticketStates: List.of(state.ticketStates)
          ..removeAt(index)
          ..insert(index, state.ticketStates[index].copyWith(status: TicketStatus.loaded, downloadedFile: file)),
      ),
    );
  }

  Future<void> _onPauseResumeEvent(
    PauseResumeEvent event,
    Emitter<TicketStorageState> emit,
  ) async {
    if (event is PausePressed) {
      return _onPausePressed(event, emit);
    } else if (event is ResumePressed) {
      return _onResumePressed(event, emit);
    }
  }

  Future<void> _onPausePressed(
    PausePressed event,
    Emitter<TicketStorageState> emit,
  ) async {
    final index = state.ticketStates.indexWhere((e) => e.ticket.url == event.ticketState.ticket.url);
    if (index == -1) return;

    final ticketState = state.ticketStates[index];

    emit(
      state.copyWith(
        ticketStates: List.of(state.ticketStates)
          ..removeAt(index)
          ..insert(index, ticketState.copyWith(status: TicketStatus.paused)),
      ),
    );

    await _downloadRepository.pause(ticketState.ticket.url);
  }

  Future<void> _onResumePressed(
    ResumePressed event,
    Emitter<TicketStorageState> emit,
  ) async {
    final index = state.ticketStates.indexWhere((e) => e.ticket.url == event.ticketState.ticket.url);
    if (index == -1) return;

    final ticketState = state.ticketStates[index];

    emit(
      state.copyWith(
        ticketStates: List.of(state.ticketStates)
          ..removeAt(index)
          ..insert(index, ticketState.copyWith(status: TicketStatus.loading)),
      ),
    );

    await _downloadRepository.resume(ticketState.ticket.url);
  }

  Future<void> _onNewUrlAdded(
    NewUrlAdded event,
    Emitter<TicketStorageState> emit,
  ) async {
    if (state.urls.contains(event.newUrl)) return;

    emit(
      state.copyWith(
        ticketStates: List.of(state.ticketStates)
          ..add(
            TicketState(ticket: Ticket.fromUrl(event.newUrl)),
          ),
      ),
    );
  }
}
