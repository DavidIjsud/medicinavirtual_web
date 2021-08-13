// To parse this JSON data, do
//
//     final oneMedico = oneMedicoFromJson(jsonString);

import 'dart:convert';

OneMedico oneMedicoFromJson(String str) => OneMedico.fromJson(json.decode(str));

String oneMedicoToJson(OneMedico data) => json.encode(data.toJson());

class OneMedico {
    OneMedico({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    MedicoDetail data;

    factory OneMedico.fromJson(Map<String, dynamic> json) => OneMedico(
        status: json["status"],
        message: json["message"],
        data: MedicoDetail.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class MedicoDetail {
    MedicoDetail({
        this.ci,
        this.apellidos,
        this.foto,
        this.nombres,
        this.telefono,
        this.contrato,
        this.cv,
        this.fotoTituloProfesional,
        this.numeroMatricula,
        this.estado,
        this.rol,
    });

    int ci;
    String apellidos;
    String foto;
    String nombres;
    int telefono;
    String contrato;
    String cv;
    String fotoTituloProfesional;
    int numeroMatricula;
    String estado;
    String rol;

    factory MedicoDetail.fromJson(Map<String, dynamic> json) => MedicoDetail(
        ci: json["ci"],
        apellidos: json["apellidos"],
        foto: json["foto"],
        nombres: json["nombres"],
        telefono: json["telefono"],
        contrato: json["contrato"],
        cv: json["cv"],
        fotoTituloProfesional: json["fotoTituloProfesional"],
        numeroMatricula: json["numeroMatricula"],
        estado: json["estado"],
        rol: json["rol"],
    );

    Map<String, dynamic> toJson() => {
        "ci": ci,
        "apellidos": apellidos,
        "foto": foto,
        "nombres": nombres,
        "telefono": telefono,
        "contrato": contrato,
        "cv": cv,
        "fotoTituloProfesional": fotoTituloProfesional,
        "numeroMatricula": numeroMatricula,
        "estado": estado,
        "rol": rol,
    };
}
