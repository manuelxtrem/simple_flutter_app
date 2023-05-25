import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_flutter_app/res/user_settings.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final UserCache userCache;

  WalletBloc(this.userCache) : super(WalletInitial()) {
    on<WalletEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
