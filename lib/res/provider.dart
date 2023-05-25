import 'enums.dart';

class ProviderState {
  final ProviderStatus status;
  final ProviderModes mode;
  final String? message;

  ProviderState({required this.status, required this.mode, this.message});
}
