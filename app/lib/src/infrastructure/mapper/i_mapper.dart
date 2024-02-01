import 'package:ld_app/src/domain/core/i_entity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

abstract interface class IMapper<TDomain extends IEntity,
    TDatasource extends TableBase> {
  TDomain toDomain(TDatasource dataSource);
  TDatasource toDatasource(TDomain domain);
}
