import 'package:covid_19_tracker/models/DataResponse.dart';

import 'api_base_helper.dart';

class ApiRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<DataResponse> fetchData() async {
    final response = await _helper.get('data.json');
    return DataResponse.fromJson(response);
  }
}
