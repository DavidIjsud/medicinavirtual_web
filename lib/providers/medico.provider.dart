import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:topicowebflutter3/interfaces/diasEleccion.dart';
import 'package:topicowebflutter3/interfaces/horarioEleccion.dart';
import 'package:topicowebflutter3/interfaces/horarioMedico.dart';
import 'package:topicowebflutter3/interfaces/list.medicos.dart';
import 'package:topicowebflutter3/interfaces/listReservasOfPacInMedicos.dart';
import 'package:topicowebflutter3/interfaces/one.medico.dart';
import 'package:topicowebflutter3/interfaces/response.loginmedicoad.dart';
import 'package:topicowebflutter3/pages/ReservasOfPacientesInMedico.dart';

class MedicoProvider{

   static Future<bool> validarMedico( int ci , String email , String mensaje  )async {

        var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/cuenta/validarCuenta");
      var response ;
      try {
         response = await http.post( url , headers: { "Content-Type": "application/json" } , body: jsonEncode({
            "ci": int.parse(ci.toString().trim()) ,
            "email":email.trim().toLowerCase(),
            "mensaje":mensaje
         })  );
      } catch (e) {
          return false;
      }

        return true;

  } 

  
  static Future<OneMedico> obtainOneMedico( String ci ) async {
            var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/medico/getonemedico/" + ci.trim() );
            var response ;
             try {
                  response = await http.get(url);
            } catch (e) {
                return null;
            }

             if( response.statusCode == 200 ){
              var   jsonRespuesta = jsonDecode(response.body);
              if( jsonRespuesta['status'] == true ){
                  return  oneMedicoFromJson( response.body );
              }else{
                  return null;
            }
         }

      return null;

  }

  static Future<bool> aprobarCita( int idReserva ) async{
      print("Id Reserva "+ idReserva.toString() );
      var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/reserva/aprobar/" + idReserva.toString() );
      var response ;
      try {
        response = await http.post(url);
      } catch (e) {
        return false;
      }

         if( response.statusCode == 200 ){
                    var   jsonRespuesta = jsonDecode(response.body);
                    if( jsonRespuesta['status'] == true ){
                        return   true;
                    }else{
                        return false;
                    }
          }

          return false;


  }

  static Future<ListReservasOfPacientesInMedico> obtainReservasOfPacientes( String ciMedico ) async {

            var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/reserva/obtenerReservasMedico/" + ciMedico.trim() );
            var response ;

            try {
                  response = await http.get(url);
            } catch (e) {
                return null;
            }
             if( response.statusCode == 200 ){
                    var   jsonRespuesta = jsonDecode(response.body);
                    if( jsonRespuesta['status'] == true ){
                        return   listReservasOfPacientesInMedicoFromJson( response.body );
                    }else{
                        return null;
                    }
             }

             return null;


  }

  static Future<bool> saveNewHorarioMedico( int idDia, int idHora ) async{

      var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/horario/scheduledoctor");
      var response ;
      try {
         response = await http.post( url , headers: { "Content-Type": "application/json" } , body: jsonEncode({
            "ci" : 8154167,
            "idDia" : idDia,
            "idHora" : idHora             
         }));
      }catch(e){
          return false;
      }

       if( response.statusCode == 200 ){
              var   jsonRespuesta = jsonDecode(response.body);
              if( jsonRespuesta['status'] == true ){
                  return true;
              }else{  
                  return false;
              }
       }else{
           return false;
       }

  }

  static Future<DiasEleccion> obtenerDiasAEleccion() async {

      var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/horario/getdays");
      var response ;
      try {
         response = await http.get(url);
      } catch (e) {
          return null;
      }
      if( response.statusCode == 200 ){
          var   jsonRespuesta = jsonDecode(response.body);
          if( jsonRespuesta['status'] == true ){
              return  diasEleccionFromJson( response.body );
          }else{
              return null;
          }
      }
      return null;
  }

  static Future<HorariosEleccion> obtenerHorariosAEleccion() async{

      var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/horario/gethoras");
      var respose;

      try {
          respose = await http.get(url);
      } catch (e) {
          return null;
      }

      if( respose.statusCode == 200 ){
          var   jsonRespuesta = jsonDecode(respose.body);
          if( jsonRespuesta['status'] == true ){
              return horariosEleccionFromJson( respose.body );
          }else{
              return null;
      }
      }
      return null;

  }

  static Future<ListMedicoResponse> obtainAllMedicos(  ) async{

      var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/cuenta/getallmedicocuentas");
      var response ;
      try {
           response = await http.get(url);
      } catch (e) {
           return null;
      }

      if( response.statusCode == 200 ){
           var   jsonRespuesta = jsonDecode(response.body);
           if( jsonRespuesta['status'] == true ){
              return  listMedicoResponseFromJson( response.body );
           }else{
              return null;
           }
      }

      return null;

  }

 static Future<HorariosMedico> obtainMedicoHorario( int ci ) async {

      var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/horario/diasandhorario/medico/" + ci.toString().trim() );
      var response ;

      try {
          response = await http.get(url);
      } catch (e) {
          return null;
      }

      if( response.statusCode == 200 ){
           var   jsonRespuesta = jsonDecode(response.body);
           if( jsonRespuesta['status'] == true ){
             print(response.body);
              return  horariosMedicoFromJson( response.body );
           }
           return null;
      }else{
        return null;
      }

 }


  static Future<ResponseLoginAdmMedico> loginMedicoAdm( String email , String password  ) async {

      var url = Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/administrador/iniciosesion");
      var response  ;
      try {
           response = await http.post(url, headers: { "Content-Type" : "application/json" } , 
                body: jsonEncode({
                  "email" : email.trim().toLowerCase() ,
                  "contrasena" : password.trim()  
                }),
             );
      } catch (e) {
           return null;
      }

      if (response.statusCode == 200) {

           var   jsonRespuesta = jsonDecode(response.body);
           if( jsonRespuesta['status'] == true ){
             print(response.body);
              return  responseLoginAdmMedicoFromJson( response.body );
           }else{
              return null;
           }
                
      }

      return null;

  }

  static Future<Map<String,String>> sendDataAdministrador( List<int> foto, List<int> fotoContrato , Map<String,String> datos, Map<String,String> tipos ) async {

    var url = Uri.parse(
        "https://nestjswebservicesapp.herokuapp.com/registro/administrador/add/" + datos['email']);
    var request = new http.MultipartRequest("POST", url);
    request.files.add( http.MultipartFile.fromBytes('image', foto,
        contentType: new MediaType('application', 'file'),
        filename:  tipos["foto"] ));
  

      request.files.add( http.MultipartFile.fromBytes('contrato', fotoContrato,
        contentType: new MediaType('application', 'file'),
        filename: tipos["contrato"] ));   

      request.fields["ci"] = datos['ci'].trim();    
      request.fields["apellidos"] = datos['apellidos'].trim();
      request.fields["foto"] = datos['foto'];  
      request.fields["nombres"] = datos['nombres'].trim();  
      request.fields["contrato"] = datos['contrato'];  
      request.fields["cv"] = datos['cv'];  
      request.fields["fotoTituloProfesional"] = datos['fotoTituloProfesional'];  
      request.fields["numeroMatricula"] = datos['numeroMatricula'].trim();
      request.fields["rol"] = datos['rol'].trim();  
      request.fields["telefono"] = datos['telefono'].trim();  

    print("Enviado");
    var response = await  request.send();
    print(response);
    if (response.statusCode == 200) {
               final respStr = await response.stream.bytesToString();
               final respuesta = jsonDecode(respStr );
               if( respuesta['status'] == true ){
                    
                    try {
                        var responseCuenta = await http.post(Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/cuenta/add"), headers: { "Content-Type" : "application/json" } , body: jsonEncode({
                              
                              'email': datos['email'].trim().toLowerCase(),
                              'contrasena' : datos['contrasena'].trim(),
                              'persona' :  int.parse(datos['ci'].trim()) ,
                              'tipoCuenta' : 'ADMINISTRADOR'

                        }) );

                        if (responseCuenta.statusCode == 200) {
                             var respuestaCuenta = json.decode(responseCuenta.body);
                             if( respuestaCuenta['status'] == true ){
                                   return {
                                      'status': "true",
                                      'message': respuestaCuenta['message'],
                                      'data': null
                                  };
                             }else{
                                return {
                                  'status': "false",
                                  'message': respuestaCuenta['message'],
                                  'data': null
                              };
                             }
                        }else{
                              return {
                                  'status': "false",
                                  'message': "Error al crear cuenta",
                                  'data': null
                              };
                        }

                    } catch (e) {
                        return {
                            'status': "false",
                            'message': e.message,
                            'data': null
                        };
                    }
               }else{
                   return {
                        "status" : "false",
                        "message" : respuesta['message'],
                        "data" : respuesta['data'].toString()
                   };
               }
      }else{
           return {
                "status" : "false",
                "message" : "Error al enviar el formulario",
                "data" : "null"
           };
      }
       
  }


  static Future<Map<String,String>> sendData( List<int> foto,List<int> fotoTitulo , List<int> fotoCV , List<int> fotoContrato , Map<String,String> datos, Map<String,String> tipos ) async {

    var url = Uri.parse(
        "https://nestjswebservicesapp.herokuapp.com/registro/medico/add/" + datos['email']);
    var request = new http.MultipartRequest("POST", url);


    request.files.add( http.MultipartFile.fromBytes('image', foto,
        contentType: new MediaType('image', 'jpeg'),
        filename:  tipos["foto"] ));

    request.files.add( http.MultipartFile.fromBytes('cv', fotoCV,
        contentType: new MediaType('image', 'jpeg'),
        filename: tipos["cv"] ));

     request.files.add( http.MultipartFile.fromBytes('fotoTituloProfesional', fotoTitulo,
        contentType: new MediaType('image', 'jpeg'),
        filename: tipos["fotoTituloProfesional"] ));  

      request.files.add( http.MultipartFile.fromBytes('contrato', fotoContrato,
        contentType: new MediaType('image', 'jpeg'),
        filename: tipos["contrato"] ));   

      request.fields["ci"] = datos['ci'].trim();  
      request.fields["apellidos"] = datos['apellidos'].trim();
      request.fields["foto"] = datos['foto'];  
      request.fields["nombres"] = datos['nombres'].trim();  
      request.fields["contrato"] = datos['contrato'];  
      request.fields["cv"] = datos['cv'];  
      request.fields["fotoTituloProfesional"] = datos['fotoTituloProfesional'];  
      request.fields["numeroMatricula"] = datos['numeroMatricula'].trim();
      request.fields["rol"] = datos['rol'].trim();  
      request.fields["telefono"] = datos['telefono'].trim();
      request.fields['especialidade'] = datos['especialidad'].trim();

    print("Enviado");
    var response = await  request.send();
    print(response);
    if (response.statusCode == 200) {
               final respStr = await response.stream.bytesToString();
               final respuesta = jsonDecode(respStr );
               if( respuesta['status'] == true ){
                    
                    try {
                        var responseCuenta = await http.post(Uri.parse("https://nestjswebservicesapp.herokuapp.com/registro/cuenta/add"), headers: { "Content-Type" : "application/json" } , body: jsonEncode({
                              
                              'email': datos['email'].trim().toLowerCase(),
                              'contrasena' : datos['contrasena'].trim(),
                              'persona' :  int.parse(datos['ci'].trim()) ,
                              'tipoCuenta' : 'MEDICO'

                        }) );

                        if (responseCuenta.statusCode == 200) {
                             var respuestaCuenta = json.decode(responseCuenta.body);
                             if( respuestaCuenta['status'] == true ){
                                   return {
                                      'status': "true",
                                      'message': respuestaCuenta['message'],
                                      'data': null
                                  };
                             }else{
                                return {
                                  'status': "false",
                                  'message': respuestaCuenta['message'],
                                  'data': null
                              };
                             }
                        }else{
                              return {
                                  'status': "false",
                                  'message': "Error al crear cuenta",
                                  'data': null
                              };
                        }

                    } catch (e) {
                        return {
                            'status': "false",
                            'message': e.message,
                            'data': null
                        };
                    }
               }else{
                   return {
                        "status" : "false",
                        "message" : respuesta['message'],
                        "data" : respuesta['data'].toString()
                   };
               }
      }else{
           return {
                "status" : "false",
                "message" : "Error al enviar el formulario",
                "data" : "null"
           };
      }
       
  }

}