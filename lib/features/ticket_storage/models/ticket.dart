import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String url;
  final String name;

  const Ticket({
    required this.url,
    required this.name,
  });

  factory Ticket.fromUrl(String url) {
    return Ticket(
      url: url,
      name: url.substring(url.lastIndexOf('/') + 1),
    );
  }

  @override
  List<Object?> get props => [
        url,
        name,
      ];
}
