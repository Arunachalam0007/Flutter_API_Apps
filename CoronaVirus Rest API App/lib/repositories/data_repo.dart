// ignore_for_file: prefer_conditional_assignment

import 'package:coronavirus_status_tracker_app/Services/api_service.dart';
import 'package:coronavirus_status_tracker_app/Utils/constants.dart';
import 'package:coronavirus_status_tracker_app/models/endpoints_data.dart';
import 'package:http/http.dart';

class DataRepo {
  final APIService apiService;
  DataRepo({required this.apiService});
  String? _accessToken;

  Future<String?> getEndpointData(Endpoint endpoint) async {
    return await _getDataRefreshingToken<String>((token) =>
        apiService.getEndpointResults(tokenKey: token, endpoint: endpoint));
  }

  Future<EndpointsData?> getAllEndpointsData() async {
    var getAllEP = await _getDataRefreshingToken<EndpointsData>(
      (token) => _getAllEndpointData(),
    );
    return getAllEP;
  }

  Future<T?> _getDataRefreshingToken<T>(
      Future<T> Function(String token) onGetData) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData(_accessToken!);
      }
    } on Response catch (response) {
      if (response.statusCode == 404) {
        return await onGetData(_accessToken!);
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointData() async {
    List<String> endpointList = await Future.wait([
      apiService.getEndpointResults(
          tokenKey: _accessToken!, endpoint: Endpoint.cases),
      apiService.getEndpointResults(
          tokenKey: _accessToken!, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointResults(
          tokenKey: _accessToken!, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointResults(
          tokenKey: _accessToken!, endpoint: Endpoint.deaths),
      apiService.getEndpointResults(
          tokenKey: _accessToken!, endpoint: Endpoint.recovered),
    ]);
    return EndpointsData(endpointsVal: {
      Endpoint.cases: endpointList[0],
      Endpoint.casesConfirmed: endpointList[1],
      Endpoint.casesSuspected: endpointList[2],
      Endpoint.deaths: endpointList[3],
      Endpoint.recovered: endpointList[4],
    });
  }
}
