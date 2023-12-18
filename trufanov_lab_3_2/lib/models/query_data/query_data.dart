import 'package:hive/hive.dart';

part 'query_data.g.dart';

@HiveType(typeId: 0)
class QueryData {
  @HiveField(0)
  final int foundedCharactersNumber;

  @HiveField(1)
  final DateTime queryExecuteDateTime;

  QueryData({
    required this.foundedCharactersNumber,
    required this.queryExecuteDateTime,
  });
}
