import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/models/ticket_state.dart';
import 'package:surf_flutter_study_jam_2023/res/dimens.dart';

class TicketCard extends StatelessWidget {
  final TicketState ticketState;
  final VoidCallback onDownloadPressed;
  final VoidCallback onPausePressed;
  final VoidCallback onResumePressed;

  const TicketCard({
    Key? key,
    required this.ticketState,
    required this.onDownloadPressed,
    required this.onPausePressed,
    required this.onResumePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.airplane_ticket),
      title: Padding(
        padding: const EdgeInsets.only(bottom: Dimens.grid4),
        child: Text(ticketState.ticket.name),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(value: ticketState.progress),
          const SizedBox(height: Dimens.grid4),
          Text(_statusText()),
        ],
      ),
      trailing: IconButton(
        onPressed: _statusCallback(),
        icon: Icon(
          _statusIcon(),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  String _statusText() {
    switch (ticketState.status) {
      case TicketStatus.initial:
        return 'Ожидает начала загрузки';
      case TicketStatus.loading:
        return 'Загружается ${ticketState.loadedMb} из ${ticketState.totalMb}';
      case TicketStatus.paused:
        return 'Пауза, загружено ${ticketState.loadedMb} из ${ticketState.totalMb}';
      case TicketStatus.loaded:
        return 'Файл загружен';
    }
  }

  IconData _statusIcon() {
    switch (ticketState.status) {
      case TicketStatus.initial:
        return Icons.cloud_download_outlined;
      case TicketStatus.loading:
        return Icons.pause;
      case TicketStatus.paused:
        return Icons.play_arrow;
      case TicketStatus.loaded:
        return Icons.cloud_done_outlined;
    }
  }

  VoidCallback? _statusCallback() {
    switch (ticketState.status) {
      case TicketStatus.initial:
        return onDownloadPressed;
      case TicketStatus.loading:
        return onPausePressed;
      case TicketStatus.paused:
        return onResumePressed;
      case TicketStatus.loaded:
        return null;
    }
  }
}
