import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_study_jam_2023/features/add_url/view/add_url_bottom_sheet_flow.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_bloc.dart';

/// Экран “Хранения билетов”.
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddUrlBottomSheet,
        label: const Text('Добавить'),
      ),
    );
  }

  Future<void> _openAddUrlBottomSheet() async {
    final bloc = context.read<TicketStorageBloc>();

    final url = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddUrlBottomSheetFlow(),
    );
  }
}
