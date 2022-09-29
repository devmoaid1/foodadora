// ignore_for_file: file_names

abstract class RestApiProvider {
  Future<dynamic> get(String path, {Map<String, dynamic> queryParams});

  Future<dynamic> post(String path,
      {Map<String, dynamic> queryParams, Map<String, dynamic> body});

  Future<dynamic> put(String path,
      {Map<String, dynamic> queryParams, Map<String, dynamic> body});

  Future<dynamic> delete(String path, {Map<String, dynamic> queryParams});
}
