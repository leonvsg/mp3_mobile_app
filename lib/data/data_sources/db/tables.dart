import 'package:drift/drift.dart';

@DataClassName('MerchantCurrency')
class MerchantCurrencies extends Table {
  TextColumn get merchant => text().references(Merchants, #login)();
  TextColumn get currency => text().references(Currencies, #alphabeticCode)();

  @override
  Set<Column> get primaryKey => {merchant,currency};
}

class MerchantPermissions extends Table {
  TextColumn get merchant => text().references(Merchants, #login)();
  TextColumn get permission => text()();

  @override
  Set<Column> get primaryKey => {merchant,permission};
}

@DataClassName('MerchantLocal')
class MerchantLocales extends Table {
  TextColumn get merchant => text().references(Merchants, #login)();
  IntColumn get local => integer()();

  @override
  Set<Column> get primaryKey => {merchant,local};
}

class MerchantTerms extends Table {
  TextColumn get merchant => text().references(Merchants, #login)();
  IntColumn get term => integer()();
}

class AccessibleMerchants extends Table {
  TextColumn get merchantLogin => text()();
  TextColumn get merchantFullName => text()();
  TextColumn get merchantType => text()();
  TextColumn get session => text().references(Sessions, #tokenHash)();

  @override
  Set<Column> get primaryKey => {merchantLogin,session};
}

class Sessions extends Table {
  TextColumn get tokenHash => text()();
  TextColumn get userLogin => text()();
  TextColumn get merchant => text().references(Merchants, #login)();
  DateTimeColumn get registerTime => dateTime()();
  BoolColumn get active => boolean()();

  @override
  Set<Column> get primaryKey => {tokenHash};
}

class Merchants extends Table {
  TextColumn get login => text()();
  TextColumn get fullName => text()();
  TextColumn get openIdToken => text().nullable()();
  TextColumn get defaultCurrency => text().references(Currencies, #alphabeticCode)();
  IntColumn get sessionTimeoutMinutes => integer()();
  TextColumn get email => text().nullable()();
  TextColumn get mainUrl => text().nullable()();
  TextColumn get knp => text().nullable()();

  @override
  Set<Column> get primaryKey => {login};
}

@DataClassName('Currency')
class Currencies extends Table {
  TextColumn get alphabeticCode => text()();
  IntColumn get minorUnit => integer()();
  TextColumn get numericCode => text()();
  TextColumn get name => text().nullable()();

  @override
  Set<Column> get primaryKey => {alphabeticCode};

  @override
  List<String> get customConstraints => [
        'UNIQUE (numeric_code)',
      ];
}