/* import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/core/value_object.dart';
import 'package:ld_app/src/domain/core/value_objects/value_failures.dart'; */

import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'code')
enum ReplyMode {
  khongTraLoi(0, 'Không trả lời'),
  demTinNhanDaXuLyThanhCong(1, 'Đếm tin đã xử lý thành công'),
  trichDanTinSauKhiXuLy(2, 'Trích dẫn tin sau khi xử lý'),
  trichDanNoiDungNhanDuoc(3, 'Trích dẫn nội dung nhận được'),
  khongXacDinh(-1, 'Không xác định');

  final String label;
  final int code;
  const ReplyMode(this.code, this.label);
  static ReplyMode fromKey(int code) {
    return ReplyMode.values.firstWhere((e) => e.code == code,
        orElse: () => ReplyMode.khongXacDinh);
  }
}

@JsonEnum(valueField: 'code')
enum DebtReminderMode {
  baoKemNoCuChiTiet(0, 'Báo kèm nợ cũ chi tiết'),
  khongXacDinh(-1, 'Không xác định');

  final String label;
  final int code;
  const DebtReminderMode(this.code, this.label);
  static DebtReminderMode fromKey(int code) {
    return DebtReminderMode.values.firstWhere((e) => e.code == code,
        orElse: () => DebtReminderMode.khongXacDinh);
  }
}
/* class ReplyMode extends ValueObject<num, ValueEnteredNotMatch> {
  static const num minValue = 0;
  static const num maxValue = 3;
  @override
  final Either<ValueEnteredNotMatch<num>, num> value;
  const ReplyMode._(this.value);
  factory ReplyMode(num value) {
    return ReplyMode._(ReplyMode.checkValue(value));
  }

  static Either<ValueEnteredNotMatch<num>, num> checkValue(num value) {
    return (value >= minValue && value <= maxValue)
        ? Right(value)
        : Left(ValueEnteredNotMatch(value));
  }
}

class DebtReminderMode extends ValueObject<num, ValueEnteredNotMatch> {
  static const num minValue = 0;
  static const num maxValue = 0;
  @override
  final Either<ValueEnteredNotMatch<num>, num> value;
  const DebtReminderMode._(this.value);
  factory DebtReminderMode(num value) {
    return DebtReminderMode._(DebtReminderMode.checkValue(value));
  }

  static Either<ValueEnteredNotMatch<num>, num> checkValue(num value) {
    return (value >= minValue && value <= maxValue)
        ? Right(value)
        : Left(ValueEnteredNotMatch(value));
  }
} */
