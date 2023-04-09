part of 'add_url_bloc.dart';

class AddUrlState extends Equatable {
  final String url;
  final bool isUrlValid;
  final bool closeWithResult;

  const AddUrlState({
    this.url = '',
    this.isUrlValid = true,
    this.closeWithResult = false,
  });

  AddUrlState copyWith({
    String? url,
    bool? isUrlValid,
    bool? closeWithResult,
  }) {
    return AddUrlState(
      url: url ?? this.url,
      isUrlValid: isUrlValid ?? this.isUrlValid,
      closeWithResult: closeWithResult ?? this.closeWithResult,
    );
  }

  @override
  List<Object> get props => [
        url,
        isUrlValid,
        closeWithResult,
      ];
}
