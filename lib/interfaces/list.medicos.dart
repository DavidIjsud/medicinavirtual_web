// To parse this JSON data, do
//
//     final listMedicoResponse = listMedicoResponseFromJson(jsonString);

import 'dart:convert';

ListMedicoResponse listMedicoResponseFromJson(String str) => ListMedicoResponse.fromJson(json.decode(str));

String listMedicoResponseToJson(ListMedicoResponse data) => json.encode(data.toJson());

class ListMedicoResponse {
    ListMedicoResponse({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<MedicoCuenta> data;

    factory ListMedicoResponse.fromJson(Map<String, dynamic> json) => ListMedicoResponse(
        status: json["status"],
        message: json["message"],
        data: List<MedicoCuenta>.from(json["data"].map((x) => MedicoCuenta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class MedicoCuenta {
    MedicoCuenta({
        this.email,
        this.fechaCreacion,
        this.contrasena,
        this.estado,
        this.tipoCuenta,
        this.persona,
        this.pin,
    });

    String email;
    DateTime fechaCreacion;
    String contrasena;
    bool estado;
    String tipoCuenta;
    Persona persona;
    Pin pin;

    factory MedicoCuenta.fromJson(Map<String, dynamic> json) => MedicoCuenta(
        email: json["email"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        contrasena: json["contrasena"],
        estado: json["estado"],
        tipoCuenta: json["tipoCuenta"],
        persona: Persona.fromJson(json["persona"]),
        pin: Pin.fromJson(json["pin"]),
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "fechaCreacion": "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
        "contrasena": contrasena,
        "estado": estado,
        "tipoCuenta": tipoCuenta,
        "persona": persona.toJson(),
        "pin": pin.toJson(),
    };
}

class Persona {
    Persona({
        this.ci,
        this.apellidos,
        this.foto,
        this.nombres,
        this.telefono,
    });

    int ci;
    String apellidos;
    String foto;
    String nombres;
    int telefono;

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        ci: json["ci"],
        apellidos: json["apellidos"],
        foto: json["foto"],
        nombres: json["nombres"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        "ci": ci,
        "apellidos": apellidos,
        "foto": foto,
        "nombres": nombres,
        "telefono": telefono,
    };
}

class Pin {
    Pin({
        this.id,
        this.pin,
        this.date,
    });

    int id;
    int pin;
    DateTime date;

    factory Pin.fromJson(Map<String, dynamic> json) => Pin(
        id: json["id"],
        pin: json["pin"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pin": pin,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}
