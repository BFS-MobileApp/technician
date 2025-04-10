

abstract class ApiConsumer{

  Future<dynamic> get(String path , {Map<String , dynamic>? queryParams});

  Future<dynamic> post(String path , {Map<String , dynamic>? queryParams , dynamic body});

  Future<dynamic> put(String path , {Map<String , dynamic>? queryParams , Map<String , dynamic>? body});

  Future<dynamic> postFile(String path, {Map<String, dynamic>? queryParams, required Map<String, dynamic> files, Map<String, dynamic>? data});

  Future<dynamic> delete(String path, {Map<String, dynamic>? queryParams, dynamic body});

  Future<dynamic> patch(String path, {Map<String, dynamic>? queryParams, dynamic body});


}