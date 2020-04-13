import 'package:covid_19_tracker/models/StatsResponse.dart';

import 'api_base_helper.dart';

class ApiRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<StatsResponse> fetchStats() async {
    final response = await _helper.get('stats/latest');
    return StatsResponse.fromJson(response);
  }
}
