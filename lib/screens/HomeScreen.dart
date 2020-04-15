import 'package:covid_19_tracker/models/HistoryResponse.dart';
import 'package:covid_19_tracker/models/StatsResponse.dart';
import 'package:covid_19_tracker/network/api_repository.dart';
import 'package:covid_19_tracker/notifiers/HistoryResponseNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<HistoryResponse> _historyFuture;
  ApiRepository _apiRepository;

  @override
  void initState() {
    super.initState();
    _apiRepository = ApiRepository();
    _historyFuture = _apiRepository.fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 40.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Current Outbreak',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'India',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Wed, 24 Mar 20',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF727693),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'COVID-19 Latest Update',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Theme.of(context).primaryColor,
                            size: 24.0,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.orange[200]],
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Confirmed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: <Widget>[],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<HistoryResponse>(
                future: _historyFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return Container(
                          height: 100.0,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case ConnectionState.done:
                        print('Done');
                        return TrendGraph(dataList: snapshot.data.data);
                    }
                  } else if (snapshot.hasError) {
                    return Container(
                      height: 100.0,
                      width: double.infinity,
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class StatsTable extends StatefulWidget {
//   @override
//   _StatsTableState createState() => _StatsTableState();
// }
//
// class _StatsTableState extends State<StatsTable> {
//   @override
//   Widget build(BuildContext context) {
//     StatsResponseNotifier _notifier =
//         Provider.of<StatsResponseNotifier>(context);

//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           columns: <DataColumn>[
//             DataColumn(
//               label: Text('State'),
//             ),
//             DataColumn(
//                 label: Text('Confirmed'),
//                 numeric: true,
//                 onSort: (index, boolean) {
//                   setState(() {
//                     _notifier.regionalData.sort(
//                         (a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
//                   });
//                 }),
//             DataColumn(
//                 label: Text('Deaths'),
//                 numeric: true,
//                 onSort: (index, boolean) {
//                   if (boolean) {
//                     setState(() {
//                       _notifier.regionalData
//                           .sort((a, b) => a.deaths.compareTo(b.deaths));
//                     });
//                   } else {
//                     setState(() {
//                       _notifier.regionalData
//                           .sort((a, b) => b.deaths.compareTo(a.deaths));
//                     });
//                   }
//                 }),
//             DataColumn(
//               label: Text('Recoveries'),
//               numeric: true,
//             ),
//           ],
//           rows: _notifier.regionalData
//               .map(
//                 (state) => DataRow(
//                   cells: [
//                     DataCell(
//                       Text(state.loc),
//                     ),
//                     DataCell(
//                       Text(state.totalConfirmed.toString()),
//                     ),
//                     DataCell(
//                       Text(state.deaths.toString()),
//                     ),
//                     DataCell(
//                       Text(state.discharged.toString()),
//                     ),
//                   ],
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }
// }

class TrendGraph extends StatefulWidget {
  final List<DataByDay> dataList;

  TrendGraph({this.dataList});

  @override
  _TrendGraphState createState() => _TrendGraphState();
}

class _TrendGraphState extends State<TrendGraph> {
  List<List<double>> _graphDataList = [];

  @override
  void initState() {
    super.initState();
    _graphDataList = _buildData();
  }

  List<List<double>> _buildData() {
    List<List<double>> list = [];
    List<double> confirmedData = [];
    List<double> deathData = [];
    List<double> recoveryData = [];
    for (int i = widget.dataList.length - 7; i < widget.dataList.length; i++) {
      HistorySummary today = widget.dataList[i].historySummary;
      HistorySummary yesterday = widget.dataList[i - 1].historySummary;
      confirmedData.add((today.total - yesterday.total).toDouble());
      deathData.add((today.deaths - yesterday.deaths).toDouble());
      recoveryData.add((today.discharged - yesterday.discharged).toDouble());
    }
    list.add(confirmedData);
    list.add(deathData);
    list.add(recoveryData);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Confirmed cases trend',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 150.0,
            child: Sparkline(
              data: _graphDataList[0],
              lineColor: Colors.orange,
              lineWidth: 4.0,
              fillMode: FillMode.below,
              fillGradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange, Colors.orange[100]],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Deaths trend',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 150.0,
            child: Sparkline(
              data: _graphDataList[1],
              lineColor: Theme.of(context).primaryColor,
              lineWidth: 4.0,
              fillMode: FillMode.below,
              fillGradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColor, Colors.transparent],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Recovery trend',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 150.0,
            child: Sparkline(
              data: _graphDataList[2],
              lineColor: Theme.of(context).primaryColor,
              lineWidth: 4.0,
              fillMode: FillMode.below,
              fillGradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColor, Colors.transparent],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
