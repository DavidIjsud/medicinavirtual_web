import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:topicowebflutter3/interfaces/listReservasOfPacInMedicos.dart';
import 'package:topicowebflutter3/pages/pacienteEspecifico.dart';
import 'package:topicowebflutter3/providers/medico.provider.dart';
import 'package:topicowebflutter3/providers/widgetChange.Notifier.dart';

class ListOfReservasOfPacientes extends StatefulWidget {
  const ListOfReservasOfPacientes({ Key key , this.widgetChangeNotifier  }) : super(key: key);

   final WidgetChangeNotifier widgetChangeNotifier;

  @override
  _ListOfReservasOfPacientesState createState() => _ListOfReservasOfPacientesState();
}

class _ListOfReservasOfPacientesState extends State<ListOfReservasOfPacientes> {



  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                   Center(
                       child: Text("RESERVAS DE PACIENTES" , style:  TextStyle( fontSize: 40 , fontWeight: FontWeight.bold ) , ),
                   ),
                   SizedBox( height: 70, ),
                   Expanded(
                     child: FutureBuilder(
                        future:  MedicoProvider.obtainReservasOfPacientes("8154167") ,
                        builder: ( _ , AsyncSnapshot<ListReservasOfPacientesInMedico> asyncSnapshot  ){
                             if( asyncSnapshot.hasData ){
                                if( asyncSnapshot.data.status ){
                                      return ListView.builder(
                                           shrinkWrap: true,
                                           itemCount: asyncSnapshot.data.data.length,
                                           itemBuilder: (context, index) {
                                              return Card(
                                                elevation: 10,

                                                child:  Row(
                                                    children: [

                                                        SizedBox( width: 70, ),
                                                        Column(
                                                            children: [
                                                                Container(
                                                                  width: 200,
                                                                  height: 200,
                                                                  child: Image.network( asyncSnapshot.data.data[index].paciente.foto ),
                                                              )
                                                            ],
                                                        ),
                                                        SizedBox( width: 50, ),
                                                        Column(
                                                            children: [
                                                                  Text("Dia: " + asyncSnapshot.data.data[index].fecha ),
                                                                  Text("Hora: "+ asyncSnapshot.data.data[index].hora  ),
                                                                  Text("Enlace: "+ (asyncSnapshot.data.data[index].enlace.isNotEmpty ?  asyncSnapshot.data.data[index].enlace  : "No se aprobo la cita" )),
                                                                  Text( "Paciente: "+ asyncSnapshot.data.data[index].paciente.nombres + " " + asyncSnapshot.data.data[index].paciente.apellidos  ),
                                                                   Center(child: ElevatedButton.icon(onPressed: (){
                                                                     
                                                                      Map<String, dynamic> informacionMedico = {
                                                                           "fecha" : asyncSnapshot.data.data[index].fecha,
                                                                           "hora" : asyncSnapshot.data.data[index].hora,
                                                                           "enlace" : asyncSnapshot.data.data[index].enlace,
                                                                           "apellidos" : asyncSnapshot.data.data[index].paciente.apellidos,
                                                                           "nombres" : asyncSnapshot.data.data[index].paciente.nombres,
                                                                           "foto" : asyncSnapshot.data.data[index].paciente.foto,
                                                                           "fechaNacimiento" : asyncSnapshot.data.data[index].paciente.fechaNacimiento,
                                                                           "telefono" : asyncSnapshot.data.data[index].paciente.telefono,
                                                                           "idReserva" : asyncSnapshot.data.data[index].id
                                                                      };

                                                                      widget.widgetChangeNotifier.changeWidget( PacienteEspecifico( informacionpaciente: informacionMedico  ,widgetChangeNotifier: widget.widgetChangeNotifier , ) );

                                                                   }, icon: Icon(Icons.open_in_browser) , label: Text("VER MAS")))
                                                            ],
                                                        ),
                                                          
                                                    ],
                                                ), 
                                              );
                                           }
                                        );
                                }else{
                                    return Center(
                                        child: CircularProgressIndicator(),
                                    );
                                }
                             }

                             return Center(
                                 child: CircularProgressIndicator(),
                             );
                        }
                  ),
                   )
              ],
        ),
    );
  }
}