import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/add_url/data/url_validator.dart';

part 'add_url_event.dart';

part 'add_url_state.dart';

class AddUrlBloc extends Bloc<AddUrlEvent, AddUrlState> {
  final IUrlValidator _urlValidator;

  AddUrlBloc(this._urlValidator) : super(const AddUrlState()) {
    on<UrlChanged>(_onUrlChanged);
    on<AddBtnPressed>(_onAddBtnPressed);
  }

  Future<void> _onUrlChanged(
    UrlChanged event,
    Emitter<AddUrlState> emit,
  ) async {
    emit(state.copyWith(url: event.url, isUrlValid: true));
  }

  Future<void> _onAddBtnPressed(
    AddBtnPressed event,
    Emitter<AddUrlState> emit,
  ) async {
    final isValid = _urlValidator.isValid(state.url);

    emit(state.copyWith(isUrlValid: isValid, closeWithResult: isValid));
  }
}
