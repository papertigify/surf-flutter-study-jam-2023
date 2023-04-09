part of 'add_url_bloc.dart';

abstract class AddUrlEvent extends Equatable {
  const AddUrlEvent();
}

class UrlChanged extends AddUrlEvent {
  final String url;

  const UrlChanged(this.url);

  @override
  List<Object?> get props => [url];
}

class AddBtnPressed extends AddUrlEvent {
  const AddBtnPressed();

  @override
  List<Object?> get props => [];
}
