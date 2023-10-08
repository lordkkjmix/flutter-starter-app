import 'package:dartz/dartz.dart';
import 'package:flutter_starter_app/core/errors/exceptions.dart';
import 'package:flutter_starter_app/core/errors/failures.dart';

dynamic decodeDataSourceResponse<T>(
  dynamic response, {
  required T Function(dynamic item) decoder,
}) {
  try {
    switch (response.runtimeType) {
      case List:
        final List<T> dataList =
            response.map((e) => decoder(e)).toList().cast<T>();
        return dataList;
      case String:
        return response;
      default:
        return decoder(Map<String, dynamic>.from(response));
    }
  } catch (error) {
    rethrow;
  }
}

Future<Either<Failure, T>> implementRepository<T>(
    Future<T> implementation) async {
  try {
    final T result = await implementation;
    return Right(result);
  } on RequestException catch (e) {
    return Left(
      ServerFailure(statusCode: e.statusCode, message: e.message),
    );
  }
}
