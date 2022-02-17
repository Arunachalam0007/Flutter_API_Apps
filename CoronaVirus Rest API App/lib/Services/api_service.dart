// packages

import 'dart:convert';

import 'package:coronavirus_status_tracker_app/Utils/constants.dart';
import 'package:http/http.dart' as http;

// API
import 'api.dart';

class APIService {
  final API api;
  APIService({required this.api});

  Future<String> getAccessToken() async {
    final response = await http.post(
        //   Uri.parse('https://ncov2019-admin.firebaseapp.com/token'),
        api.tokenUri(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      final accessToken = data['access_token'];
      return accessToken;
    }
    throw response;
  }

  Future<String> getEndpointResults({
    required String tokenKey,
    required Endpoint endpoint,
  }) async {
    final response = await http.get(api.endpointUri(endpoint),
        headers: {'Authorization': 'Bearer $tokenKey'});

    List<dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      if (data.isNotEmpty) {
        final resultJson = data[0] as Map<String, dynamic>;
        String _responsePath = Endpoint.cases == endpoint ? 'cases' : 'data';
        //int result = resultJson[_responsePath] as int;
        return (resultJson[_responsePath] as int).toString();
      } else {
        return '';
      }
    }
    print('Token URL: ${api.tokenUri()}.  statusCode: ${response.statusCode}');
    throw response;
  }
}
