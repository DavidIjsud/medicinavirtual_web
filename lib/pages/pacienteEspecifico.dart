import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:topicowebflutter3/providers/medico.provider.dart';
import 'package:topicowebflutter3/providers/widgetChange.Notifier.dart';
import 'package:topicowebflutter3/widgets/meetingJitsin.dart';

class PacienteEspecifico extends StatefulWidget {
  const PacienteEspecifico({ Key key, this.informacionpaciente, this.widgetChangeNotifier  }) : super(key: key);

    final Map<String, dynamic> informacionpaciente;
    final WidgetChangeNotifier widgetChangeNotifier;

  @override
  _PacienteEspecificoState createState() => _PacienteEspecificoState();
}

class _PacienteEspecificoState extends State<PacienteEspecifico> {


   var progress;
 
  

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: ( BuildContext c ){
         this.progress = ProgressHUD.of(c);
         return Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
                  Container(
                     width: 400,
                     height: 400,
                     child: Image.network( widget.informacionpaciente['foto'] ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                       children: [ 
                           Card( elevation: 20 ,child: Text( "Dia: "+ widget.informacionpaciente['fecha'] )),
                           Card( elevation: 20  , child: Text( "Hora: "+ widget.informacionpaciente['hora']   )),
                           Card( elevation: 20 ,child: Text("Enlace: "+ widget.informacionpaciente['enlace']  )),
                           Card( elevation: 20 ,child: Text( "Nombre paciente: "+ widget.informacionpaciente['nombres']  )),
                           Card( elevation: 20 ,child: Text( "Apellidos: "+ widget.informacionpaciente['apellidos']  )),
                           Card( elevation: 20 ,child: Text("Telefono: "+ widget.informacionpaciente['telefono'].toString()  )),
                           Card( elevation: 20 ,child: Text("Fecha nacimiento: "+  widget.informacionpaciente['fechaNacimiento'].toString()  )),
                           Container(
                               width: 200,
                               height: 70,
                               color: Colors.orange,
                               child:  ElevatedButton(onPressed: (){

                                      if( widget.informacionpaciente['enlace'].toString().isNotEmpty ){
                                            widget.widgetChangeNotifier.changeWidget( Meeting(  enlace: widget.informacionpaciente['enlace'].toString(),   ) );
                                      }else{

                                          this.progress.showWithText("Por favor espere...");
                                          MedicoProvider.aprobarCita( widget.informacionpaciente['idReserva'] )
                                                .then((value) {
                                                     this.progress.dismiss();
                                                     if( value ){

                                                            final snackBar = SnackBar(content: Text('Reserva Aceptada, notificacion enviada'));
                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                     }else{

                                                            final snackBar = SnackBar(content: Text('Reserva Aceptada, notificacion enviada'));
                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                    
                                                     }
                                                });
                                      }

                               }, child:  Text( widget.informacionpaciente['enlace'].toString().isNotEmpty ? "ENTRAR A LA REUNION" : "ACEPTAR CITA" ) ) ,
                           ),
                        ],
                    ),
                  ),
             ],
         ),
      );
        }
      ),
    );
  }
}