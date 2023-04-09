import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/view/ticket_storage_page.dart';

/// точка входа в экран “Хранения билетов”.
class TicketStorageFlow extends StatelessWidget {
  const TicketStorageFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<TicketStorageBloc>(
          create: (context) => TicketStorageBloc(),
        ),
      ],
      child: const TicketStoragePage(),
    );
  }
}
