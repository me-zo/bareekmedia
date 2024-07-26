import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/core/dependency_registrar/dependencies.dart';
import 'package:bareekmedia/core/network/network_client.dart';
export 'package:bareekmedia/core/errors/failure_model.dart';
export 'package:bareekmedia/core/errors/error_handler.dart';
export 'package:bareekmedia/core/errors/errors.dart';

abstract class BaseRepo {
  final NetworkClient client = NetworkClient(config: sl<Configuration>());
}
