import 'package:covid_19_tracker/models/StatsResponse.dart';
import 'package:covid_19_tracker/network/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                        colors: [Colors.deepOrange, Colors.orange],
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
                      DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text('State'),
                          ),
                        ],
                        rows: <DataRow>[],
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
    );
  }
}
