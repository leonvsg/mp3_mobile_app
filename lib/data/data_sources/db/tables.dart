import 'package:drift/drift.dart';

@DataClassName('MerchantCurrency')
class MerchantCurrencies extends Table {
  IntColumn get merchant => integer().references(Merchants, #id)();
  IntColumn get currency => integer().references(Currencies, #id)();

  @override
  Set<Column> get primaryKey => {merchant,currency};
}

class MerchantPermissions extends Table {
  IntColumn get merchant => integer().references(Merchants, #id)();
  TextColumn get permission => text()();

  @override
  Set<Column> get primaryKey => {merchant,permission};
}

@DataClassName('MerchantLocal')
class MerchantLocales extends Table {
  IntColumn get merchant => integer().references(Merchants, #id)();
  IntColumn get local => integer()();

  @override
  Set<Column> get primaryKey => {merchant,local};
}

class MerchantTerms extends Table {
  IntColumn get merchant => integer().references(Merchants, #id)();
  IntColumn get term => integer()();
}

class AccessibleMerchants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get merchantLogin => text()();
  TextColumn get merchantFullName => text()();
  TextColumn get merchantType => text()();
  IntColumn get session => integer().references(Sessions, #id)();
}

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tokenHash => text()();
  TextColumn get userLogin => text()();
  IntColumn get merchant => integer().references(Merchants, #id)();
  DateTimeColumn get registerTime => dateTime()();

  @override
  List<String> get customConstraints => [
    'UNIQUE (tokenHash)',
  ];
}

class Merchants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get login => text()();
  TextColumn get fullName => text()();
  TextColumn get openIdToken => text().nullable()();
  IntColumn get defaultCurrency => integer().references(Currencies, #id)();
  IntColumn get sessionTimeoutMinutes => integer()();
  TextColumn get email => text().nullable()();
  TextColumn get mainUrl => text().nullable()();
  TextColumn get knp => text().nullable()();
}

@DataClassName('Currency')
class Currencies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get alphabeticCode => text()();
  IntColumn get minorUnit => integer()();
  TextColumn get numericCode => text()();
  TextColumn get name => text().nullable()();

  @override
  List<String> get customConstraints => [
        'UNIQUE (numericCode)',
        'UNIQUE (alphabeticCode)',
      ];
}