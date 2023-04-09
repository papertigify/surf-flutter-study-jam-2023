import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/directory_provider.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/file_download_repository.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/flowder_service.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/view/ticket_storage_page.dart';

/// entry point for screen “Хранение билетов”.
class TicketStorageFlow extends StatelessWidget {
  const TicketStorageFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IDirectoryProvider>(create: (context) => const DirectoryProvider()),
        Provider<FlowderService>(create: (context) => const FlowderService()),
        Provider<IFileDownloadRepository>(
          create: (context) => FileDownloadRepository(
            context.read<FlowderService>(),
            context.read<IDirectoryProvider>(),
          ),
        ),
        BlocProvider<TicketStorageBloc>(
          create: (context) => TicketStorageBloc(context.read<IFileDownloadRepository>()),
        ),
      ],
      child: const TicketStoragePage(),
    );
  }
}
