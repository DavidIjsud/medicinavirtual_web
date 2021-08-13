import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';
import 'package:topicowebflutter3/pages/ReservasOfPacientesInMedico.dart';
import 'package:topicowebflutter3/pages/register.adm.dart';
import 'package:topicowebflutter3/providers/widgetChange.Notifier.dart';
import 'package:topicowebflutter3/widgets/mainMedicoPage.dart';
import 'package:topicowebflutter3/widgets/medicos.dart';

class MedicoPage extends StatefulWidget {
  MedicoPage({Key key, this.title, this.tipoCuenta }) : super(key: key);

  final String title;
  final String tipoCuenta;
  

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<MedicoPage> {

  WidgetChangeNotifier widgetChangeNotifier;

  @override
  initState(){
      this.widgetChangeNotifier = new WidgetChangeNotifier( widget.tipoCuenta );
  }

   List<Widget> _menuMedico( BuildContext contexto ){

      List<Widget> listaWidgets = [];
        const size =  SizedBox( height: 10.0, );
      const menu =   Center( child: Text("MENU"), );
      var btnAdministradores =  Center(
            child:  Container(
              width: 250,
              height: 50,
              child: ElevatedButton(
               child: Text('Reservas'),
                onPressed: (){
                    this.widgetChangeNotifier.changeWidget(ListOfReservasOfPacientes( widgetChangeNotifier: this.widgetChangeNotifier, ));
                }
              ),
            ),
      ); 
      var btnReservas =  Center(
            child:  Container(
              width: 250,
              height: 50,
              child: ElevatedButton(
               child: Text('Horarios'),
                onPressed: (){

                     this.widgetChangeNotifier.changeWidget( HorarioRegisterMedico() );
                }
              ),
            ),
      ); 
      var btnMedicos =  Center(
            child:  Container(
              width: 250,
              height: 50,
              child: ElevatedButton(
               child: Text('Pacientes'),
                onPressed: (){}
              ),
            ),
      ); 

      var btnSalir =  Center(
            child:  Container(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                     Navigator.of(contexto).pop();
                },
               style:  ButtonStyle(
                    
                    backgroundColor: MaterialStateProperty.all( Colors.red ),) 
               ,
                  child: Container(
                      color: Colors.red,
                      child:  Text('SALIR'),
                  ),
              ),
            ) 
       ) ; 

        listaWidgets.add( size );
        listaWidgets.add( menu );
        listaWidgets.add( size );
        listaWidgets.add(btnAdministradores);
        listaWidgets.add( size );
        listaWidgets.add(btnReservas);
        listaWidgets.add( size );
        listaWidgets.add(btnMedicos);
        listaWidgets.add( size );
        listaWidgets.add(btnSalir);

        return listaWidgets;

   }
  
  List<Widget> _menuAdministrador( BuildContext contexto ){
        List<Widget> listaWidgets = [];

      const size =  SizedBox( height: 10.0, );
      const menu =   Center( child: Text("MENU"), );
      var btnAdministradores =  Center(
            child:  Container(
              width: 250 ,
              height: 50,
              child: ElevatedButton(
               child: Text('Administradores'),
                onPressed: (){
                     this.widgetChangeNotifier.changeWidget( RegisterAdm() );
                }
              ),
            ),
      ); 
      var btnReservas =  Center(
            child:  Container(
               width: 250 ,
              height: 50,  
              child: ElevatedButton(
               child: Text('Reservas'),
                onPressed: (){}
              ),
            ),
      ); 
      var btnMedicos =  Center(
            child:  Container(
               width: 250 ,
              height: 50,
              child: ElevatedButton(
               child: Text('Medicos'),
                onPressed: (){
                    this.widgetChangeNotifier.changeWidget( MedicoPageListWidget());
                }
              ),
            ),
      ); 

       var btnSalir =  Center(
            child:  Container(
               width: 250 ,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                     Navigator.of(contexto).pop();
                },
               style:  ButtonStyle(
                    
                    backgroundColor: MaterialStateProperty.all( Colors.red ),) 
               ,
                  child: Container(
                      color: Colors.red,
                      child:  Text('SALIR'),
                  ),
              ),
            ) 
       ) ; 

        listaWidgets.add( size );
        listaWidgets.add( menu );
        listaWidgets.add( size );
        listaWidgets.add(btnAdministradores);
        listaWidgets.add( size );
        listaWidgets.add(btnReservas);
        listaWidgets.add( size );
        listaWidgets.add(btnMedicos);
         listaWidgets.add( size );
        listaWidgets.add(btnSalir);

        return listaWidgets;

  }


  @override
  Widget build(BuildContext context) {
     final tamanoPhone = MediaQuery.of(context).size;
     return Scaffold(
        body: Container(
             width: tamanoPhone.width ,
             height: tamanoPhone.height,
             child: Row(
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                       Container(
                          width: tamanoPhone.width * 0.2,
                          height: tamanoPhone.height,
                          child: Card(
                            elevation: 10.0,
                            color: Colors.orange ,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.tipoCuenta == "MEDICO" ?   _menuMedico(context)  :  _menuAdministrador(context)  ,
                            ),
                          ),
                       ),
                       Container(
                          width: tamanoPhone.width * 0.8,
                          height: tamanoPhone.height,
                          color: Colors.green,
                          child: ChangeNotifierBuilder(
                                       
                                       notifier: this.widgetChangeNotifier ,
                                       builder: ( c ,WidgetChangeNotifier  wn , w ){
                                             return wn.widget;
                                       },  
                                   )
                       )
                 ],
             ),
        )   ,
     );

  }


}