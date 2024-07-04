import 'base/json_convert_content.dart';


class BaseResponseEntity<T> {

  T? data;
	int? errorCode;
	String? errorMsg;

	BaseResponseEntity.fromJson(dynamic result){
		if(result is Map){
			errorCode = 0;//没有状态码 默认请求是map， 就视为成功
			// errorMsg = result['errorMsg'];
			data = JsonConvert.fromJsonAsT(result);
		}
	}

	bool isOk(){
		return errorCode == 0;
	}



}