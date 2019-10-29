// import 'dart:convert';
// import 'package:http/http.dart';

// class Api {
//   final String apiURL;
//   final Client client;

//   Api({this.apiURL}) : client = Client();

//   Future<dynamic> getClient(
//     String pathURL, {
//     Map<String, String> queryParameters,
//   }) async {
//     Uri uri = Uri.http(apiURL, pathURL, queryParameters);
//     Response res = await client.get(uri);
//     return json.decode(res.body);
//   }

//   Future<dynamic> postClient(
//     String pathURL, {
//     Map<String, String> queryParameters,
//     Map<String, dynamic> body,
//   }) async {
//     Uri uri = Uri.http(apiURL, pathURL, queryParameters);
//     Response res = await client.post(uri, body: body);
//     return json.decode(res.body);
//   }
// }
