import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// Returns messages in a chat. The messages are returned in a reverse
/// chronological order (i.e., in order of decreasing message_id). For optimal
/// performance, the number of returned messages is chosen by TDLib. This is
/// an offline request if only_local is true
/// Returns [Messages]
@immutable
class GetHistory extends TdFunction {
  const GetHistory({
    required this.inputPeer,
    required this.offsetId,
    required this.offsetDate,
    required this.addOffset,
    required this.limit,
    required this.maxId,
    required this.minId,
    required this.hash
  });

  /// [peer] Target peer
  final InputPeer inputPeer;

  /// [offsetId] Only return messages starting from the specified message ID
  final int offsetId;

  /// [offsetDate] Only return messages sent before the specified date
  final int offsetDate;

  /// [addOffset] Number of list elements to be skipped, negative values are also accepted.
  final int addOffset;

  /// [limit] Number of results to return
  final int limit;

  /// [maxId] If a positive value was transferred, the method will return only messages with IDs less than max_id
  final int maxId;

  /// [minId] If a positive value was transferred, the method will return only messages with IDs more than min_id
  final int minId;

  /// [hash] Result hash
  final int hash;

  static const String constructor = 'getHistory';

  @override
  String getConstructor() => constructor;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'peer': inputPeer,
        'offset_id': offsetId,
        'offset_date': offsetDate,
        'add_offset': addOffset,
        'limit': limit,
        'hash': hash,
        '@type': constructor,
      };

  @override
  bool operator ==(Object other) => overriddenEquality(other);

  @override
  int get hashCode => overriddenHashCode;
}
