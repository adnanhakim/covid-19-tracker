import 'package:covid_19_tracker/models/stats_response.dart';
import 'package:covid_19_tracker/network/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<StatsResponse> _statsFuture;
  ApiRepository _apiRepository;

  @override
  void initState() {
    super.initState();
    _apiRepository = ApiRepository();
    _statsFuture = _apiRepository.fetchStats();
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
                padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                      iconSize: 20.0,
                    ),
                    Text(
                      'Detailed Overview',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<StatsResponse>(
                future: _statsFuture,
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
                        return StateStats(
                          summary: snapshot.data.data.summary,
                          stateList: snapshot.data.data.regional,
                        );
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

class StateStats extends StatefulWidget {
  final Summary summary;
  final List<Regional> stateList;

  StateStats({this.summary, this.stateList});

  @override
  StateStatsState createState() => StateStatsState();
}

class StateStatsState extends State<StateStats> {
  @override
  void initState() {
    super.initState();
    widget.stateList
        .sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: widget.stateList
              .map((state) => Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    padding: EdgeInsets.all(20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.loc.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Wrap(
                          children: <Widget>[
                            Text(
                              state.totalConfirmed
                                      .toString()
                                      .replaceAllMapped(reg, mathFunc) +
                                  ' cases',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Text(
                                ((state.totalConfirmed / widget.summary.total) *
                                            100)
                                        .toStringAsFixed(2) +
                                    '% of total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.orange[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Wrap(
                          children: <Widget>[
                            Text(
                              state.deaths
                                      .toString()
                                      .replaceAllMapped(reg, mathFunc) +
                                  ' deaths',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Text(
                                ((state.deaths / state.totalConfirmed) * 100)
                                        .toStringAsFixed(2) +
                                    '% death rate',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.red[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Wrap(
                          children: <Widget>[
                            Text(
                              state.discharged
                                      .toString()
                                      .replaceAllMapped(reg, mathFunc) +
                                  ' recovered',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Text(
                                ((state.discharged /
                                                (state.discharged +
                                                    state.deaths)) *
                                            100)
                                        .toStringAsFixed(2) +
                                    '% recovery rate',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
