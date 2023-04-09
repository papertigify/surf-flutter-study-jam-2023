import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/add_url/view/add_url_bottom_sheet_flow.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/view/widgets/ticket_card.dart';

/// Screen “Хранение билетов”.
class TicketStoragePage extends StatefulWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  @override
  State<TicketStoragePage> createState() => _TicketStoragePageState();
}

class _TicketStoragePageState extends State<TicketStoragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Хранение билетов'),
        centerTitle: false,
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<TicketStorageBloc, TicketStorageState>(
          /// We want to rebuild the whole list only if urls have been changed.
          /// Other rebuilds - scoped for each ticket card.
          buildWhen: (p, c) => !const DeepCollectionEquality().equals(p.urls, c.urls),
          builder: (context, state) {
            if (state.ticketStates.isEmpty) {
              return Center(
                child: Text(
                  'Здесь пока ничего нет',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              );
            }

            return ListView.builder(
              itemCount: state.ticketStates.length,
              itemBuilder: (context, index) {
                final ticketUrl = state.ticketStates[index].ticket.url;

                return BlocBuilder<TicketStorageBloc, TicketStorageState>(
                  key: ValueKey(ticketUrl),
                  buildWhen: (p, c) {
                    final pTicketState = p.ticketStates.firstWhereOrNull((e) => e.ticket.url == ticketUrl);
                    final cTicketState = c.ticketStates.firstWhereOrNull((e) => e.ticket.url == ticketUrl);

                    return pTicketState != cTicketState;
                  },
                  builder: (context, state) {
                    final ticketState = state.ticketStates[index];

                    return TicketCard(
                      ticketState: ticketState,
                      onDownloadPressed: () => context.read<TicketStorageBloc>().add(DownloadPressed(ticketState)),
                      onPausePressed: () => context.read<TicketStorageBloc>().add(PausePressed(ticketState)),
                      onResumePressed: () => context.read<TicketStorageBloc>().add(ResumePressed(ticketState)),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddUrlBottomSheet,
        label: const Text('Добавить'),
      ),
    );
  }

  Future<void> _openAddUrlBottomSheet() async {
    final url = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddUrlBottomSheetFlow(),
    );

    if (!mounted) return;

    if (url != null) {
      context.read<TicketStorageBloc>().add(NewUrlAdded(url));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ссылка успешно добавлена!')));
    }
  }
}
