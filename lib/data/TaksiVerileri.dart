import 'package:intl/intl.dart';

class TaksiVerileri {
  List<Veriler> veriler;
  List<Lokasyonlar> lokasyonlar;

  TaksiVerileri({this.veriler, this.lokasyonlar});

  TaksiVerileri.fromJson(Map<String, dynamic> json) {
    if (json['veriler'] != null) {
      veriler = new List<Veriler>();
      json['veriler'].forEach((v) {
        veriler.add(new Veriler.fromJson(v));
      });
    }
    if (json['lokasyonlar'] != null) {
      lokasyonlar = new List<Lokasyonlar>();
      json['lokasyonlar'].forEach((v) {
        lokasyonlar.add(new Lokasyonlar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.veriler != null) {
      data['veriler'] = this.veriler.map((v) => v.toJson()).toList();
    }
    if (this.lokasyonlar != null) {
      data['lokasyonlar'] = this.lokasyonlar.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Veriler {
  String vendorID;
  String tpepPickupDatetime;
  String tpepDropoffDatetime;
  int passengerCount;
  double tripDistance;
  String pULocationID;
  String dOLocationID;
  double totalAmount;

  Veriler(
      {this.vendorID,
      this.tpepPickupDatetime,
      this.tpepDropoffDatetime,
      this.passengerCount,
      this.tripDistance,
      this.pULocationID,
      this.dOLocationID,
      this.totalAmount});

  Veriler.fromJson(Map<String, dynamic> json) {
    vendorID = json['VendorID'];
    tpepPickupDatetime = json['tpep_pickup_datetime'].toString();
    tpepDropoffDatetime = json['tpep_dropoff_datetime'].toString();
    passengerCount = json['passenger_count'];
    tripDistance = ((json['trip_distance'] as num) ?? 0.0).toDouble();
    pULocationID = json['PULocationID'];
    dOLocationID = json['DOLocationID'];
    totalAmount = json['total_amount'];
  }

  Veriler.fromJsonFormattedDate(Map<String, dynamic> json) {
    final formattedDate = new DateFormat('dd/MM/yyyy');

    vendorID = json['VendorID'];
    tpepPickupDatetime = formattedDate.format(
        DateTime.fromMicrosecondsSinceEpoch(
            json['tpep_pickup_datetime'] * 1000000));
    tpepDropoffDatetime = formattedDate.format(
        DateTime.fromMicrosecondsSinceEpoch(
            json['tpep_dropoff_datetime'] * 1000000));
    passengerCount = json['passenger_count'];
    tripDistance = ((json['trip_distance'] as num) ?? 0.0).toDouble();
    pULocationID = json['PULocationID'];
    dOLocationID = json['DOLocationID'];
    totalAmount = ((json['total_amount'] as num) ?? 0.0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VendorID'] = this.vendorID;
    data['tpep_pickup_datetime'] = this.tpepPickupDatetime;
    data['tpep_dropoff_datetime'] = this.tpepDropoffDatetime;
    data['passenger_count'] = this.passengerCount;
    data['trip_distance'] = this.tripDistance;
    data['PULocationID'] = this.pULocationID;
    data['DOLocationID'] = this.dOLocationID;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class Lokasyonlar {
  String locationID;
  String borough;
  String zone;
  String serviceZone;

  Lokasyonlar({this.locationID, this.borough, this.zone, this.serviceZone});

  Lokasyonlar.fromJson(Map<String, dynamic> json) {
    locationID = json['LocationID'];
    borough = json['Borough'];
    zone = json['Zone'];
    serviceZone = json['service_zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LocationID'] = this.locationID;
    data['Borough'] = this.borough;
    data['Zone'] = this.zone;
    data['service_zone'] = this.serviceZone;
    return data;
  }
}

class BirlestirilmisVeriler {
  String vendorID;
  String tpepPickupDatetime;
  String tpepDropoffDatetime;
  int passengerCount;
  double tripDistance;
  String pULocationID;
  String dOLocationID;
  double totalAmount;
  String baslangicNoktasiBorough;
  String baslangicNoktasi;
  String baslangicNoktasiServiceZone;
  String bitisNoktasiBorough;
  String bitisNoktasi;
  String bitisNoktasiServiceZone;
  double baslangicNoktasiLatitude;
  double baslangicNoktasiLongitude;
  double bitisNoktasiLatitude;
  double bitisNoktasiLongitude;
  BirlestirilmisVeriler({
    this.vendorID,
    this.tpepPickupDatetime,
    this.tpepDropoffDatetime,
    this.passengerCount,
    this.tripDistance,
    this.pULocationID,
    this.dOLocationID,
    this.totalAmount,
    this.baslangicNoktasiBorough,
    this.baslangicNoktasi,
    this.baslangicNoktasiServiceZone,
    this.bitisNoktasiBorough,
    this.bitisNoktasi,
    this.bitisNoktasiServiceZone,
    this.baslangicNoktasiLatitude,
    this.baslangicNoktasiLongitude,
    this.bitisNoktasiLatitude,
    this.bitisNoktasiLongitude,
  });

  BirlestirilmisVeriler.fromJson(
    Map<String, dynamic> data,
  ) {
    vendorID = data["veriler"]['VendorID'];
    tpepPickupDatetime = data["veriler"]['tpep_pickup_datetime'].toString();
    tpepDropoffDatetime = data["veriler"]['tpep_dropoff_datetime'].toString();
    passengerCount = data["veriler"]['passenger_count'];
    tripDistance =
        ((data["veriler"]['trip_distance'] as num) ?? 0.0).toDouble();
    pULocationID = data["veriler"]['PULocationID'];
    dOLocationID = data["veriler"]['DOLocationID'];
    totalAmount = data["veriler"]['total_amount'];
    baslangicNoktasiBorough = data["baslangicNoktasi"]["Borough"];
    baslangicNoktasi = data["baslangicNoktasi"]["Zone"];
    baslangicNoktasiServiceZone = data["baslangicNoktasi"]["service_zone"];
    bitisNoktasiBorough = data["bitisNoktasi"]["Borough"];
    bitisNoktasi = data['bitisNoktasi']["Zone"];
    bitisNoktasiServiceZone = data["bitisNoktasi"]["service_zone"];
  }

  BirlestirilmisVeriler.fromJsonFormattedDate(
    Map<String, dynamic> data,
  ) {
    final formattedDate = new DateFormat('dd/MM/yyyy H:m:s');

    vendorID = data["veriler"]['VendorID'];
    tpepPickupDatetime = formattedDate.format(
        DateTime.fromMicrosecondsSinceEpoch(
            data["veriler"]['tpep_pickup_datetime'] * 1000000));
    ;
    tpepDropoffDatetime = formattedDate.format(
        DateTime.fromMicrosecondsSinceEpoch(
            data["veriler"]['tpep_dropoff_datetime'] * 1000000));
    ;
    passengerCount = data["veriler"]['passenger_count'];
    tripDistance =
        ((data["veriler"]['trip_distance'] as num) ?? 0.0).toDouble();
    pULocationID = data["veriler"]['PULocationID'];
    dOLocationID = data["veriler"]['DOLocationID'];
    totalAmount = ((data["veriler"]['total_amount'] as num) ?? 0.0).toDouble();
    baslangicNoktasiBorough = data["baslangicNoktasi"]["Borough"];
    baslangicNoktasi = data["baslangicNoktasi"]["Zone"];
    baslangicNoktasiServiceZone = data["baslangicNoktasi"]["service_zone"];
    bitisNoktasiBorough = data["bitisNoktasi"]["Borough"];
    bitisNoktasi = data['bitisNoktasi']["Zone"];
    bitisNoktasiServiceZone = data["bitisNoktasi"]["service_zone"];
  }

  BirlestirilmisVeriler.fromJsonFormattedDateWithCoordinates(
    Map<String, dynamic> data,
  ) {
    final formattedDate = new DateFormat('dd/MM/yyyy H:m:s');

    vendorID = data["veriler"]['VendorID'];
    tpepPickupDatetime = formattedDate.format(
        DateTime.fromMicrosecondsSinceEpoch(
            data["veriler"]['tpep_pickup_datetime'] * 1000000));
    ;
    tpepDropoffDatetime = formattedDate.format(
        DateTime.fromMicrosecondsSinceEpoch(
            data["veriler"]['tpep_dropoff_datetime'] * 1000000));
    ;
    passengerCount = data["veriler"]['passenger_count'];
    tripDistance =
        ((data["veriler"]['trip_distance'] as num) ?? 0.0).toDouble();
    pULocationID = data["veriler"]['PULocationID'];
    dOLocationID = data["veriler"]['DOLocationID'];
    totalAmount = ((data["veriler"]['total_amount'] as num) ?? 0.0).toDouble();
    baslangicNoktasiLatitude = data["baslangicNoktasi"]["lat"];
    baslangicNoktasiLongitude = data["baslangicNoktasi"]["long"];
    baslangicNoktasi = data["baslangicNoktasi"]["Zone"];
    bitisNoktasiLatitude = data["bitisNoktasi"]["lat"];
    bitisNoktasiLongitude = data["bitisNoktasi"]["long"];
    bitisNoktasi = data["bitisNoktasi"]["Zone"];
  }
}
