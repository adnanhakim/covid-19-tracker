import 'dart:collection';

import 'package:covid_19_tracker/models/data_response.dart';
import 'package:flutter/material.dart';

class DataResponseNotifier with ChangeNotifier {
  List<CasesTimeSeries> _casesTimeSeries = [];
  List<Statewise> _statewise = [];
  List<Tested> _tested = [];

  UnmodifiableListView<CasesTimeSeries> get casesTimeSeries =>
      UnmodifiableListView(_casesTimeSeries);

  UnmodifiableListView<Statewise> get statewise =>
      UnmodifiableListView(_statewise);

  UnmodifiableListView<Tested> get tested => UnmodifiableListView(_tested);

  void addCasesTimeSeries(List<CasesTimeSeries> casesTimeSeries) {
    casesTimeSeries.forEach((cases) => _casesTimeSeries.add(cases));
    notifyListeners();
  }

  void addStatewise(List<Statewise> stateWiseList) {
    stateWiseList.forEach((state) => _statewise.add(state));
    notifyListeners();
  }

  void addTested(List<Tested> testedList) {
    testedList.forEach((tested) => _tested.add(tested));
    notifyListeners();
  }
}
