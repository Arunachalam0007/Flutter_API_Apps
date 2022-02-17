// Constants
import '../Utils/constants.dart';

class API {
  final String apiKey;
  static const String host = 'ncov2019-admin.firebaseapp.com';
  API({required this.apiKey});

  factory API.sandBox() => API(apiKey: ApiKey.nCovSandBox);
  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );
  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: paths[endpoint],
      );
}
