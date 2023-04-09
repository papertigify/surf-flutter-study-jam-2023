import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/add_url/bloc/add_url_bloc.dart';
import 'package:surf_flutter_study_jam_2023/res/dimens.dart';

/// bottom sheet “Добавление ссылки”.
class AddUrlBottomSheet extends StatelessWidget {
  const AddUrlBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddUrlBloc, AddUrlState>(
          listenWhen: (p, c) => c.closeWithResult,
          listener: (context, state) => Navigator.of(context).pop(state.url),
        )
      ],
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.grid16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: Dimens.grid40),
                  BlocBuilder<AddUrlBloc, AddUrlState>(
                    buildWhen: (p, c) => p.isUrlValid != c.isUrlValid,
                    builder: (context, state) {
                      return TextField(
                        onChanged: (text) => context.read<AddUrlBloc>().add(UrlChanged(text)),
                        decoration: InputDecoration(
                          hintText: 'Введите url',
                          labelText: 'Введите url',
                          errorText: state.isUrlValid ? null : 'Введите корректный url',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.inputBorderRadius),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: Dimens.grid24),
                  BlocBuilder<AddUrlBloc, AddUrlState>(
                    buildWhen: (p, c) => p.isUrlValid != c.isUrlValid,
                    builder: (context, state) {
                      return FilledButton(
                        onPressed:
                            state.isUrlValid ? () => context.read<AddUrlBloc>().add(const AddBtnPressed()) : null,
                        child: const Text('Добавить'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
