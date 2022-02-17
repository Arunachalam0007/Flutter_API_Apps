enum Endpoint { cases, casesSuspected, casesConfirmed, deaths, recovered }

class ApiKey {
  static String nCovSandBox =
      '5093bd82a97a6257f7d3fe95dcb39cf5dd6ea106d7b3d0c82f212791c517b6e4';
}

final Map<Endpoint, dynamic> paths = {
  Endpoint.cases: 'cases',
  Endpoint.casesSuspected: 'casesSuspected',
  Endpoint.casesConfirmed: 'casesConfirmed',
  Endpoint.deaths: 'deaths',
  Endpoint.recovered: 'recovered',
};
