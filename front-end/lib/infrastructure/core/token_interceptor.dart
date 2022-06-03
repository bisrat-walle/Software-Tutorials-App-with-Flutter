import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      data.headers["Content-Type"] = "application/json";
      data.headers["Authorization"] = "Bearer "+prefs.get("token").toString();
      data.headers["Accept"] = '*/*';
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}