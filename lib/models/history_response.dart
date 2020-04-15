class HistoryResponse {
  bool success;
  List<DataByDay> data;
  DateTime lastRefreshed;
  DateTime lastOriginUpdate;

  HistoryResponse({
    this.success,
    this.data,
    this.lastRefreshed,
    this.lastOriginUpdate,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      HistoryResponse(
        success: json["success"],
        data: List<DataByDay>.from(
            json["data"].map((x) => DataByDay.fromJson(x))),
        lastRefreshed: DateTime.parse(json["lastRefreshed"]),
        lastOriginUpdate: DateTime.parse(json["lastOriginUpdate"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "lastRefreshed": lastRefreshed.toIso8601String(),
        "lastOriginUpdate": lastOriginUpdate.toIso8601String(),
      };
}

class DataByDay {
  DateTime day;
  HistorySummary historySummary;
  List<Regional> regional;

  DataByDay({
    this.day,
    this.historySummary,
    this.regional,
  });

  factory DataByDay.fromJson(Map<String, dynamic> json) => DataByDay(
        day: DateTime.parse(json["day"]),
        historySummary: HistorySummary.fromJson(json["summary"]),
        regional: List<Regional>.from(
            json["regional"].map((x) => Regional.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "day":
            "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
        "summary": historySummary.toJson(),
        "regional": List<dynamic>.from(regional.map((x) => x.toJson())),
      };
}

class Regional {
  String loc;
  int confirmedCasesIndian;
  int confirmedCasesForeign;
  int discharged;
  int deaths;
  int totalConfirmed;

  Regional({
    this.loc,
    this.confirmedCasesIndian,
    this.confirmedCasesForeign,
    this.discharged,
    this.deaths,
    this.totalConfirmed,
  });

  factory Regional.fromJson(Map<String, dynamic> json) => Regional(
        loc: json["loc"],
        confirmedCasesIndian: json["confirmedCasesIndian"],
        confirmedCasesForeign: json["confirmedCasesForeign"],
        discharged: json["discharged"],
        deaths: json["deaths"],
        totalConfirmed: json["totalConfirmed"],
      );

  Map<String, dynamic> toJson() => {
        "loc": loc,
        "confirmedCasesIndian": confirmedCasesIndian,
        "confirmedCasesForeign": confirmedCasesForeign,
        "discharged": discharged,
        "deaths": deaths,
        "totalConfirmed": totalConfirmed,
      };
}

class HistorySummary {
  int total;
  int confirmedCasesIndian;
  int confirmedCasesForeign;
  int discharged;
  int deaths;
  int confirmedButLocationUnidentified;

  HistorySummary({
    this.total,
    this.confirmedCasesIndian,
    this.confirmedCasesForeign,
    this.discharged,
    this.deaths,
    this.confirmedButLocationUnidentified,
  });

  factory HistorySummary.fromJson(Map<String, dynamic> json) => HistorySummary(
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
