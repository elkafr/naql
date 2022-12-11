

import 'package:dio/dio.dart';
import 'package:naql/networking/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';



class ApiProvider {

// next three lines makes this class a Singleton
  static ApiProvider _instance = new ApiProvider.internal();
  ApiProvider.internal();
  factory ApiProvider() => _instance;




  Future<dynamic> get(String url ,  {Map<String, String> headers}) async {
    var responseJson;
    try {
      final response = await http.get( url,headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<dynamic> post(String url, {body, Map<String, String> headers}) async {
    var responseJson;
    try {
      final response = await http.post( url,headers:
   headers ,body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


 Future<dynamic> getWithDio(String url,
      {Map<String, String> headers}) async {
        var responseJson;
   try{  
    final  response = await Dio().get(
      url,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers:headers,
    ));
    responseJson = _dioResponse(response);
   }
    on SocketException {
      throw FetchDataException('No Internet connection');
  }
  return responseJson;

}
  Future<dynamic> postWithDio(String url,
      {body, Map<String, String> headers}) async {
           var responseJson;
    try {
        final  response = await Dio().post(
      url,
         data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers:headers,
    ));
    responseJson = _dioResponse(response);
    }
        on SocketException {
      throw FetchDataException('No Internet connection');
        
  }
    return responseJson;
      }
  
     dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }


    dynamic _dioResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.data);
      case 401:
      case 403:
        throw UnauthorisedException(response.data);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}
