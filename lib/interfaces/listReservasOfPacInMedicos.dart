// To parse this JSON data, do
//
//     final listReservasOfPacientesInMedico = listReservasOfPacientesInMedicoFromJson(jsonString);

import 'dart:convert';

ListReservasOfPacientesInMedico listReservasOfPacientesInMedicoFromJson(String str) => ListReservasOfPacientesInMedico.fromJson(json.decode(str));

String listReservasOfPacientesInMedicoToJson(ListReservasOfPacientesInMedico data) => json.encode(data.toJson());

class ListReservasOfPacientesInMedico {
    ListReservasOfPacientesInMedico({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory ListReservasOfPacientesInMedico.fromJson(Map<String, dynamic> json) => ListReservasOfPacientesInMedico(
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
        this.fecha,
        this.hora,
        this.enlace,
        this.paciente,
    });

    int id;
    String fecha;
    String hora;
    String enlace;
    Paciente paciente;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fecha: json["fecha"],
        hora: json["hora"],
        enlace: json["enlace"],
        paciente: Paciente.fromJson(json["paciente"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "hora": hora,
        "enlace": enlace,
        "paciente": paciente.toJson(),
    };
}

class Paciente {
    Paciente({
        this.ci,
        this.apellidos,
        this.foto,
        this.nombres,
        this.telefono,
        this.seguro,
        this.gruposanguieo,
        this.fechaNacimiento,
    });

    int ci;
    String apellidos;
    String foto;
    String nombres;
    int telefono;
    String seguro;
    dynamic gruposanguieo;
    DateTime fechaNacimiento;

    factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        ci: json["ci"],
        apellidos: json["apellidos"],
        foto: json["foto"],
        nombres: json["nombres"],
        telefono: json["telefono"],
        seguro: json["seguro"],
        gruposanguieo: json["gruposanguieo"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
    );

    Map<String, dynamic> toJson() => {
        "ci": ci,
        "apellidos": apellidos,
        "foto": foto,
        "nombres": nombres,
        "telefono": telefono,
        "seguro": seguro,
        "gruposanguieo": gruposanguieo,
        "fechaNacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
    };
}
