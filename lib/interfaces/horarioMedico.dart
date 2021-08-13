// To parse this JSON data, do
//
//     final horariosMedico = horariosMedicoFromJson(jsonString);

import 'dart:convert';

HorariosMedico horariosMedicoFromJson(String str) => HorariosMedico.fromJson(json.decode(str));

String horariosMedicoToJson(HorariosMedico data) => json.encode(data.toJson());

class HorariosMedico {
    HorariosMedico({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    List<Datum> data;

    factory HorariosMedico.fromJson(Map<String, dynamic> json) => HorariosMedico(
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
        this.activo,
        this.dia,
    });

    int id;
    bool activo;
    Dia dia;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        activo: json["activo"],
        dia: Dia.fromJson(json["dia"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "dia": dia.toJson(),
    };
}

class Dia {
    Dia({
        this.id,
        this.nombre,
        this.horarios,
    });

    int id;
    String nombre;
    List<HorarioElement> horarios;

    factory Dia.fromJson(Map<String, dynamic> json) => Dia(
        id: json["id"],
        nombre: json["nombre"],
        horarios: List<HorarioElement>.from(json["horarios"].map((x) => HorarioElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
    };
}

class HorarioElement {
    HorarioElement({
        this.id,
        this.activo,
        this.ciMedico,
        this.horario,
    });

    int id;
    bool activo;
    int ciMedico;
    HorarioHorario horario;

    factory HorarioElement.fromJson(Map<String, dynamic> json) => HorarioElement(
        id: json["id"],
        activo: json["activo"],
        ciMedico: json["ciMedico"],
        horario: HorarioHorario.fromJson(json["horario"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "activo": activo,
        "ciMedico": ciMedico,
        "horario": horario.toJson(),
    };
}

class HorarioHorario {
    HorarioHorario({
        this.id,
        this.horaFijada,
    });

    int id;
    String horaFijada;

    factory HorarioHorario.fromJson(Map<String, dynamic> json) => HorarioHorario(
        id: json["id"],
        horaFijada: json["horaFijada"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "horaFijada": horaFijada,
    };
}
