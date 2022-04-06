import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'merchants_dao.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Merchants], daos: [MerchantsDao])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}

enum MerchantType { parent,child,viewable,unknown }

class Merchants extends Table {
  TextColumn get merchantLogin => text()();
  TextColumn get merchantFullName => text()();
  IntColumn get merchantType => intEnum<MerchantType>()();
}