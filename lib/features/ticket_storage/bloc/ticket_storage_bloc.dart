import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_storage_event.dart';

part 'ticket_storage_state.dart';

class TicketStorageBloc extends Bloc<TicketStorageEvent, TicketStorageState> {
  TicketStorageBloc() : super(const TicketStorageState()) {}
}
