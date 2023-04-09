part of 'ticket_storage_bloc.dart';

abstract class TicketStorageEvent extends Equatable {
  const TicketStorageEvent();
}

class DownloadPressed extends TicketStorageEvent {
  final TicketState ticketState;

  const DownloadPressed(this.ticketState);

  @override
  List<Object?> get props => [ticketState];
}

abstract class PauseResumeEvent extends TicketStorageEvent {
  const PauseResumeEvent();
}

class PausePressed extends PauseResumeEvent {
  final TicketState ticketState;

  const PausePressed(this.ticketState);

  @override
  List<Object?> get props => [ticketState];
}

class ResumePressed extends PauseResumeEvent {
  final TicketState ticketState;

  const ResumePressed(this.ticketState);

  @override
  List<Object?> get props => [ticketState];
}

class NewUrlAdded extends TicketStorageEvent {
  final String newUrl;

  const NewUrlAdded(this.newUrl);

  @override
  List<Object?> get props => [newUrl];
}
