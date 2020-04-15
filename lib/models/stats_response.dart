class StatsResponse {
  bool success;
  Data data;
  DateTime lastRefreshed;
  DateTime lastOriginUpdate;

  StatsResponse({
    this.success,
    this.data,
    this.lastRefreshed,
    this.lastOriginUpdate,
  });

  factory StatsResponse.fromJson(Map<String, dynamic> json) => StatsResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        lastRefreshed: DateTime.parse(json["lastRefreshed"]),
        lastOriginUpdate: DateTime.parse(json["lastOriginUpdate"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "lastRefreshed": lastRefreshed.toIso8601String(),
        "lastOriginUpdate": lastOriginUpdate.toIso8601String(),
      };
}

class Data {
  Summary summary;
  List<Regional> regional;

  Data({
    this.summary,
    this.regional,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        summary: Summary.fromJson(json["summary"]),
        regional: List<Regional>.from(
            json["regional"].map((x) => Regional.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary.toJson(),
        "regional": List<dynamic>.from(regional.map((x) => x.toJson())),
      };
}

class Regional {
  String loc;
  int confirmedCasesIndian;
  int discharged;
  int deaths;
  int confirmedCasesForeign;
  int totalConfirmed;

  Regional({
    this.loc,
    this.confirmedCasesIndian,
    this.discharged,
    this.deaths,
    this.confirmedCasesForeign,
    this.totalConfirmed,
  });

  factory Regional.fromJson(Map<String, dynamic> json) => Regional(
        loc: json["loc"],
        confirmedCasesIndian: json["confirmedCasesIndian"],
        discharged: json["discharged"],
        deaths: json["deaths"],
        confirmedCasesForeign: json["confirmedCasesForeign"],
        totalConfirmed: json["totalConfirmed"],
      );

  Map<String, dynamic> toJson() => {
        "loc": loc,
        "confirmedCasesIndian": confirmedCasesIndian,
        "discharged": discharged,
        "deaths": deaths,
        "confirmedCasesForeign": confirmedCasesForeign,
        "totalConfirmed": totalConfirmed,
      };
}

class Summary {
  int total;
  int confirmedCasesIndian;
  int confirmedCasesForeign;
  int discharged;
  int deaths;
  int confirmedButLocationUnidentified;

  Summary({
    this.total,
    this.confirmedCasesIndian,
    this.confirmedCasesForeign,
    this.discharged,
    this.deaths,
    this.confirmedButLocationUnidentified,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        total: json["total"],
        confirmedCasesIndian: json["confirmedCasesIndian"],
        confirmedCasesForeign: json["confirmedCasesForeign"],
        discharged: json["discharged"],
        deaths: json["deaths"],
        confirmedButLocationUnidentified:
            json["confirmedButLocationUnidentified"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "confirmedCasesIndian": confirmedCasesIndian,
        "confirmedCasesForeign": confirmedCasesForeign,
        "discharged": discharged,
        "deaths": deaths,
        "confirmedButLocationUnidentified": confirmedButLocationUnidentified,
      };
}
