// To parse this JSON data, do
//
//     final diasEleccion = diasEleccionFromJson(jsonString);

import 'dart:convert';

DiasEleccion diasEleccionFromJson(String str) => DiasEleccion.fromJson(json.decode(str));

String diasEleccionToJson(DiasEleccion data) => json.encode(data.toJson());

class DiasEleccion {
    DiasEleccion({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory DiasEleccion.fromJson(Map<String, dynamic> json) => DiasEleccion(
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
        this.nombre,
    });

    int id;
    String nombre;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
