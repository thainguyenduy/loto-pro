import 'package:ld_app/src/domain/core/i_entity.dart';

abstract interface class IMapper<T extends IEntity> {
  T toDomain(Map<String, Object?> data);
  Map<String, Object?> toDatasource(T domain);
}
