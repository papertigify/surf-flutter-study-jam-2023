import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/view/ticket_storage_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: const TicketStorageFlow(),
    );
  }
}
