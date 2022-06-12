import 'package:freezed_annotation/freezed_annotation.dart';

part 'page.freezed.dart';
part 'page.g.dart';

@freezed
class TransactionSearchPage with _$TransactionSearchPage {
  const factory TransactionSearchPage({
    required int count,
    required int startIndex,
  }) = _TransactionSearchPage;

  factory TransactionSearchPage.fromJson(Map<String, dynamic> json) =>
      _$TransactionSearchPageFromJson(json);
}
