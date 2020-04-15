import 'dart:collection';

import 'package:covid_19_tracker/models/StatsResponse.dart';
import 'package:flutter/material.dart';

class StatsResponseNotifier with ChangeNotifier {
  Summary _summary;
  List<Regional> _regionalStats = [];

  UnmodifiableListView<Regional> get regionalData =>
      UnmodifiableListView(_regionalStats);
  Summary get summary => _summary;

  void addRegionalStats(List<Regional> regionalStats) {
    regionalStats.forEach((stat) => _regionalStats.add(stat));
    notifyListeners();
  }

  void addSummary(Summary summary) {
    _summary = summary;
    notifyListeners();
  }
}
