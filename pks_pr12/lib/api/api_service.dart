import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  final String baseUrl = 'http://192.168.1.2:8080';
}