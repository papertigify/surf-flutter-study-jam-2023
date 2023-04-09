part of 'ticket_storage_bloc.dart';

class TicketStorageState extends Equatable {
  final List<TicketState> ticketStates;
  late final urls = ticketStates.map((e) => e.ticket.url).toList();

  TicketStorageState({
    this.ticketStates = const <TicketState>[],
  });

  TicketStorageState copyWith({
    List<TicketState>? ticketStates,
  }) {
    return TicketStorageState(
      ticketStates: ticketStates ?? this.ticketStates,
    );
  }

  @override
  List<Object> get props => [ticketStates];
}
