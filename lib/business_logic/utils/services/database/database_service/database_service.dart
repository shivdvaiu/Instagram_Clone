import 'package:instagram_clone/business_logic/utils/service_locator/service_locator.dart';
import 'package:instagram_clone/business_logic/utils/strings/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class StorageServiceImpl {
  final  Logger _log = serviceLocator.get(instanceName: Strings.logger);

  SharedPreferences _preferences =
      serviceLocator.get(instanceName: Strings.sharedPreferences);

  dynamic _getFromDisk(String key) {
    final value = _preferences.get(key);

    _log.log(
        Level.debug, 'LocalStorageService: (Fetching) key: $key value: $value');

    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    _log.log(
        Level.debug, 'LocalStorageService: (Saving) key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
