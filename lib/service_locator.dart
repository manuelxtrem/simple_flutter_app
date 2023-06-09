import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_flutter_app/res/user_settings.dart';

GetIt get sl => GetIt.instance;

Future<bool> initServices() async {
  sl.registerSingleton(Dio());
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingletonAsync(() async => UserCache(prefs));

  // if (kDebugMode) {
  //   try {
  //     FirebaseDatabase.instance.useDatabaseEmulator(Constants.firebaseEmulator, 9000);
  //     await FirebaseStorage.instance.useStorageEmulator(Constants.firebaseEmulator, 9199);
  //     // await FirebaseAuth.instance.useAuthEmulator(Constants.firebaseEmulator, 9099);
  //   } catch (e) {
  //     Utils.log(e);
  //   }
  // }
  
  return true;
}
