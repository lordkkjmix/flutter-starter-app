import 'package:flutter_starter_app/core/errors/exceptions.dart';
import 'package:flutter_starter_app/core/providers/injection_provider.dart';
import 'package:hive/hive.dart';

abstract class StorageProvider {
  Future<void> save(String boxKey, String itemKey,
      String value); //Convert your data in string before save
  Future<String?> get(
    String boxKey,
    String itemKey,
  ); //Get string and format after
  Future<void> delete(String boxKey, String itemKey);
  Future<void> deleteAll();
}

class StorageProviderImpl implements StorageProvider {
  @override
  Future<void> delete(String boxKey, String itemKey) {
    try {
      var box = sl<HiveInterface>().box(boxKey);
      return box.delete(itemKey);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      sl<HiveInterface>().deleteFromDisk();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<String?> get(String boxKey, String itemKey) async {
    try {
      var box = sl<HiveInterface>().box(boxKey);
      return box.get(itemKey);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> save(String boxKey, String itemKey, String value) async {
    try {
      var box = sl<HiveInterface>().box(boxKey);
      box.put(itemKey, value);
    } catch (e) {
      throw CacheException();
    }
  }
}
