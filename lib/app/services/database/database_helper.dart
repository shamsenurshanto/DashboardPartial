import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:sqflite/sqflite.dart';
import '../../shared/utils/app_logger.dart';
import 'database_constants.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory databaseDirectory = Directory('/storage/emulated/0/storage/nirupon');
    String path = join(databaseDirectory.path, 'pos.db');
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    int sdkVersion = allInfo["version"]["sdkInt"];
    if (sdkVersion >= 30) {
      if (!await Permission.manageExternalStorage.status.isGranted) {
        if (!await Permission.manageExternalStorage
            .request()
            .isGranted) {
          _closeApp();
        }
      }
    } else {
      if (!await Permission.storage.status.isGranted) {
        if (!await Permission.storage
            .request()
            .isGranted) {
          _closeApp();
        }
      }
    }
    return await _openDatabase(path);
  }

  _closeApp() {
    Fluttertoast.showToast(
        msg: "Permission is Required to run this app",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Future.delayed(const Duration(milliseconds: 2000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
    return null;
  }

  Future<Database> _openDatabase(String path) async {
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade
    );
  }

  void _onCreate(db, version) async {
    try {
      await createBasicInfo(db);
      await insertBasicInfo(db);
      await createOutletInfo(db);
      await createUserInfo(db);
      await createProduct(db);
      await createProductCategory(db);
      await createAttribute(db);
      await createCartMaster(db);
      await createCartItem(db);
      await createOrderMaster(db);
      await createOrderItem(db);
    } catch (e) {
      AppLogger.instance.logger.e(e);
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    AppLogger.instance.logger.d("Updating database from version $oldVersion to $newVersion");
    try {
      // if (oldVersion < 13) {
      //   await createMonthlyReturnInfo(db);
      // }
    } catch (e) {
      AppLogger.instance.logger.e(e);
    }
  }

  Future<void> createBasicInfo(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableBasicInfo} (
      ${DatabaseConstants.columnAccessToken} TEXT,
      ${DatabaseConstants.columnRefreshToken} TEXT,
      ${DatabaseConstants.columnBusinessType} TEXT,
      ${DatabaseConstants.columnBinNo} TEXT,
      ${DatabaseConstants.columnBinHolderName} TEXT,
      ${DatabaseConstants.columnBinHolderAddress} TEXT,
      ${DatabaseConstants.columnBinHolderPhone} TEXT,
      ${DatabaseConstants.columnBinHolderEmail} TEXT,
      ${DatabaseConstants.columnLastLoginTime} TEXT
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<Map<String, dynamic>?> getBasicInfo() async {
    Database db = await DatabaseHelper.instance.database;
    var v = await db.query(DatabaseConstants.tableBasicInfo);
    AppLogger.instance.logger.d(v.toString());
    return v.isEmpty ? null : v.last;
  }

  Future<bool> insertBasicInfo(Database db, {Map<String, dynamic>? row}) async {
    Map<String, dynamic> initialValues = {
      DatabaseConstants.columnAccessToken: "",
      DatabaseConstants.columnRefreshToken: "",
      DatabaseConstants.columnBinNo: "",
      DatabaseConstants.columnBinHolderName: "",
      DatabaseConstants.columnBinHolderAddress: "",
      DatabaseConstants.columnBinHolderPhone: "",
      DatabaseConstants.columnBinHolderEmail: "",
      DatabaseConstants.columnLastLoginTime: ""
    };
    int id = await db.insert(DatabaseConstants.tableBasicInfo, row ?? initialValues);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateBasicInfo({
    required Map<String, dynamic> row
  }) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableBasicInfo,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createOutletInfo(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableOutletInfo} (
      ${DatabaseConstants.columnOutletId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.columnOutletStatus} TEXT,
      ${DatabaseConstants.columnOutletNameEn} TEXT,
      ${DatabaseConstants.columnOutletNameBn} TEXT,
      ${DatabaseConstants.columnOutletDistrict} TEXT,
      ${DatabaseConstants.columnOutletThana} TEXT,
      ${DatabaseConstants.columnOutletCity} TEXT,
      ${DatabaseConstants.columnOutletMarketArea} TEXT,
      ${DatabaseConstants.columnOutletAddressLine1} TEXT,
      ${DatabaseConstants.columnOutletAddressLine2} TEXT,
      ${DatabaseConstants.columnOutletLatitude} TEXT,
      ${DatabaseConstants.columnOutletLongitude} TEXT,
      ${DatabaseConstants.columnOutletWeekend} TEXT,
      ${DatabaseConstants.columnOutletPhone} TEXT,
      ${DatabaseConstants.columnOutletEmail} TEXT,
      ${DatabaseConstants.columnOutletOpeningTime} TEXT,
      ${DatabaseConstants.columnOutletClosingTime} TEXT
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertOutletInfo(Database db, Map<String, dynamic> row) async {
    int id = await db.insert(DatabaseConstants.tableOutletInfo, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateOutletInfo({
    required Map<String, dynamic> row
  }) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableOutletInfo,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createUserInfo(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableUserInfo} (
      ${DatabaseConstants.columnUsername} TEXT,
      ${DatabaseConstants.columnPassword} TEXT,
      ${DatabaseConstants.columnUserRole} TEXT,
      ${DatabaseConstants.columnIsLoggedIn} INT
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    Database db = await DatabaseHelper.instance.database;
    var v = await db.query(
        DatabaseConstants.tableUserInfo,
        where: '${DatabaseConstants.columnUsername} = ?',
        whereArgs: [username]
    );
    AppLogger.instance.logger.d(v.toString());
    return v.isNotEmpty ? v.first : null;
  }

  Future<List<Map<String, dynamic>>> getLoggedInUserList() async {
    Database db = await DatabaseHelper.instance.database;
    var v = await db.query(
      DatabaseConstants.tableUserInfo,
      where: '${DatabaseConstants.columnIsLoggedIn} = ?',
      whereArgs: [1]
    );
    AppLogger.instance.logger.d(v.toString());
    return v;
  }

  Future<List<Map<String, Object?>>> getUserInfo() async {
    Database db = await DatabaseHelper.instance.database;
    var v = await db.query(DatabaseConstants.tableUserInfo);
    AppLogger.instance.logger.d(v.toString());
    return v;
  }

  Future<bool> insertUserInfo({
    required Map<String, dynamic> row
  }) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableUserInfo, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateUserInfo({
    required Map<String, dynamic> row,
    required String username
  }) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableUserInfo,
      row,
      where: "${DatabaseConstants.columnUsername} = ?",
      whereArgs: [username]
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<bool> updateAllUserInfo({
    required Map<String, dynamic> row
  }) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
        DatabaseConstants.tableUserInfo,
        row
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createProduct(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableProduct} (
      ${DatabaseConstants.columnProductId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.columnProductName} TEXT,
      ${DatabaseConstants.columnProductPrice} DOUBLE,
      ${DatabaseConstants.columnProductUnit} TEXT,
      ${DatabaseConstants.columnProductCategory} TEXT,
      ${DatabaseConstants.columnProductImage} TEXT,
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertProduct(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableProduct, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateProduct({required Map<String, dynamic> row}) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableProduct,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createProductCategory(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableProductCategory} (
      ${DatabaseConstants.columnProductCategoryId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.columnProductCategoryName} TEXT,
      ${DatabaseConstants.columnProductCategoryStatus} TEXT,
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertProductCategory(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableProductCategory, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateProductCategory({required Map<String, dynamic> row}) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableProductCategory,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createAttribute(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableAttribute} (
      ${DatabaseConstants.columnAttributeId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.columnAttributeName} TEXT,
      ${DatabaseConstants.columnAttributeValues} TEXT,
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertAttribute(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableAttribute, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateAttribute({required Map<String, dynamic> row}) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableAttribute,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createCartMaster(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableCartMaster} (
      ${DatabaseConstants.columnCartMasterId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.columnCartMasterTotalPrice} DOUBLE,
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertCartMaster(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableCartMaster, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateCartMaster({required Map<String, dynamic> row}) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableCartMaster,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createCartItem(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableCartItem} (
      ${DatabaseConstants.columnCartId} INTEGER,
      ${DatabaseConstants.columnCartProductId} INTEGER,
      ${DatabaseConstants.columnCartProductQuantity} DOUBLE,
      ${DatabaseConstants.columnCartProductAttribute} TEXT,
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertCartItem(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableCartItem, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateCartItem({required Map<String, dynamic> row}) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableCartItem,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createOrderMaster(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableOrderMaster} (
      ${DatabaseConstants.columnOrderMasterId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseConstants.columnOrderMasterTotalPrice} DOUBLE,
      ${DatabaseConstants.columnOrderMasterStatus} TEXT,
      ${DatabaseConstants.columnOrderMasterPaidAmountCash} DOUBLE,
      ${DatabaseConstants.columnOrderMasterPaidAmountCard} DOUBLE,
      ${DatabaseConstants.columnOrderMasterPaidAmountMfs} DOUBLE,
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertOrderMaster(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableOrderMaster, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateOrderMaster({required Map<String, dynamic> row}) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableOrderMaster,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }

  Future<void> createOrderItem(Database db) async {
    String query = '''CREATE TABLE IF NOT EXISTS ${DatabaseConstants.tableOrderItem} (
      ${DatabaseConstants.columnOrderId} INTEGER,
      ${DatabaseConstants.columnOrderProductId} INTEGER,
      ${DatabaseConstants.columnOrderProductQuantity} DOUBLE,
      ${DatabaseConstants.columnOrderProductAttribute} TEXT,
      ${DatabaseConstants.columnOrderProductDiscount} DOUBLE,
    )''';
    var v = await db.rawQuery(query);
    AppLogger.instance.logger.d(v.toString());
  }

  Future<bool> insertOrderItem(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(DatabaseConstants.tableCartItem, row);
    AppLogger.instance.logger.d(id);
    return id >= 0;
  }

  Future<bool> updateOrderItem({required Map<String, dynamic> row}) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(
      DatabaseConstants.tableCartItem,
      row,
    );
    AppLogger.instance.logger.d(count);
    return count > 0;
  }
}
