import 'package:covid_19_tracker/models/history_response.dart';
import 'package:covid_19_tracker/models/stats_response.dart';

import 'api_base_helper.dart';

class ApiRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<StatsResponse> fetchStats() async {
    final response = await _helper.get('stats/latest');
    return StatsResponse.fromJson(response);
  }

  Future<HistoryResponse> fetchHistory() async {
    final response = await _helper.get('stats/history');
    return HistoryResponse.fromJson(response);
  }
}
