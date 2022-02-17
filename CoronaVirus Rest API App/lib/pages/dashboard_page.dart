import 'package:coronavirus_status_tracker_app/Services/api.dart';
import 'package:coronavirus_status_tracker_app/Services/api_service.dart';
import 'package:coronavirus_status_tracker_app/Utils/constants.dart';
import 'package:coronavirus_status_tracker_app/models/endpoints_data.dart';
import 'package:coronavirus_status_tracker_app/repositories/data_repo.dart';
import 'package:coronavirus_status_tracker_app/widgets/endpoint_card.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _count;
  EndpointsData? _endpointsData;

  Future<void> _updateCountVal() async {
    final dataRespo = DataRepo(apiService: APIService(api: API.sandBox()));
    // final count = await dataRespo.getEndpointData(Endpoint.cases);
    final endpointsData = await dataRespo.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointsData;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateCountVal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateCountVal,
        child: ListView.builder(
            itemCount: Endpoint.values.length,
            itemBuilder: (_context, int itemIndex) {
              var endPointKeyData = Endpoint.values[itemIndex];
              var endpointVal = _endpointsData?.endpointsVal[endPointKeyData];
              String? endpoint = paths[endPointKeyData];
              return EndpointCard(
                count: endpointVal ?? '',
                endpoint: endpoint ?? '',
              );
            }),
      ),
    );
  }
}
