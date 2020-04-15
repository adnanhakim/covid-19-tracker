import 'dart:collection';

import 'package:covid_19_tracker/models/history_response.dart';
import 'package:flutter/material.dart';

class HistoryResponseNotifier with ChangeNotifier {
  List<DataByDay> _historyStats = [];

  UnmodifiableListView<DataByDay> get historyStats =>
      UnmodifiableListView(_historyStats);

  void addHistoryStats(List<DataByDay> historyStats) {
    historyStats.forEach((stat) => _historyStats.add(stat));
    notifyListeners();
  }
}
