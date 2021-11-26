import 'package:dio/dio.dart';
import 'package:newshop_app/shared/network/local/cache_helper.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': CacheHelper().getSavedData(key: 'token') ?? ''
        }));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> dataParameter,
  }) async {
    return await dio!.post(
      url,
      queryParameters: query,
      data: dataParameter,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> dataParameter,
  }) async {
    return await dio!.put(
      url,
      queryParameters: query,
      data: dataParameter,
    );
  }
}
