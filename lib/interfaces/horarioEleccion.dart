// To parse this JSON data, do
//
//     final horariosEleccion = horariosEleccionFromJson(jsonString);

import 'dart:convert';

HorariosEleccion horariosEleccionFromJson(String str) => HorariosEleccion.fromJson(json.decode(str));

String horariosEleccionToJson(HorariosEleccion data) => json.encode(data.toJson());

class HorariosEleccion {
    HorariosEleccion({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory HorariosEleccion.fromJson(Map<String, dynamic> json) => HorariosEleccion(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.horaFijada,
    });

    int id;
    String horaFijada;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        horaFijada: json["horaFijada"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "horaFijada": horaFijada,
    };
}
