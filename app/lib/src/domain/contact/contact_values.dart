import 'package:fpdart/src/either.dart';
import 'package:ld_app/src/domain/core/value_object.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart';

enum ReplyModes {
  khongTraLoi(0, 'Không trả lời'),
  demTinNhanDaXuLyThanhCong(1, 'Đếm tin đã xử lý thành công'),
  trichDanTinSauKhiXuLy(2, 'Trích dẫn tin sau khi xử lý'),
  trichDanNoiDungNhanDuoc(3, 'Trích dẫn nội dung nhận được');

  final String value;
  final int key;
  const ReplyModes(this.key, this.value);
  static ReplyModes? fromKey(int key) {
    return ReplyModes.values
        .firstWhere((e) => e.key == key, orElse: () => null as ReplyModes);
  }
}

class ReplyMode extends ValueObject<num, ValueEnteredNotMatch> {
  @override
  final Either<ValueEnteredNotMatch<num>, num> value;
  const ReplyMode._(this.value);
  factory ReplyMode(num value) {
    return (value >= 0 && value <= 3)
        ? ReplyMode._(Right(value))
        : ReplyMode._(Left(ValueEnteredNotMatch(value)));
  }
}
