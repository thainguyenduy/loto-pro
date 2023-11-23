import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:ld_app/src/infrastructure/notification.service.dart';
import 'package:ld_app/src/screens/router/router.dart';

@module
abstract class AppModule {
  // You can register named preemptive types like follows
  @Named("BaseUrl")
  String get baseUrl => dotenv.env['BASEURL']!;

  // url here will be injected
  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));

  @injectable
  AppRouter get appRouter => AppRouter();

  @preResolve
  Future<NotificationService> get notificationService =>
      NotificationService.init();
}
