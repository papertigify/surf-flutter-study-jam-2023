import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:surf_flutter_study_jam_2023/features/add_url/bloc/add_url_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/add_url/data/url_validator.dart';
import 'package:surf_flutter_study_jam_2023/features/add_url/view/add_url_bottom_sheet.dart';

/// точка входа в "Добавление ссылки".
class AddUrlBottomSheetFlow extends StatelessWidget {
  const AddUrlBottomSheetFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IUrlValidator>(create: (context) => const UrlValidator()),
        BlocProvider<AddUrlBloc>(
          create: (context) => AddUrlBloc(context.read<IUrlValidator>()),
        ),
      ],
      child: const AddUrlBottomSheet(),
    );
  }
}