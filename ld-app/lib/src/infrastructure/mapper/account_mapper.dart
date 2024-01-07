import 'package:ld_app/src/domain/account/account.dart';
import 'package:ld_app/src/infrastructure/mapper/i_mapper.dart';

class AccountMapper implements IMapper<IAccount> {
  @override
  IAccount toDomain(Map<String, Object?> data) {
    // TODO: implement domainFromDatasource
    throw UnimplementedError();
  }

  @override
  Map<String, Object?> toDatasource(IAccount domain) {
    // TODO: implement prepareForDatasource
    throw UnimplementedError();
  }
}
