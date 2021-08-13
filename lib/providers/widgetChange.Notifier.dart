

import 'package:flutter/material.dart';
import 'package:topicowebflutter3/widgets/medicos.dart';
import 'package:topicowebflutter3/widgets/mainMedicoPage.dart';
import 'package:topicowebflutter3/widgets/widgetsMEdicoPage/misHorariosMedicoWidget.dart';

class WidgetChangeNotifier extends ChangeNotifier{

    String tcuenta;
    Widget _widget;
    WidgetChangeNotifier( String tipoCuenta ){
        tcuenta = tipoCuenta;
        _widget = tipoCuenta == "ADMINISTRADOR" ? MedicoPageListWidget() : HorarioRegisterMedico(); 
    }


    void changeWidget( Widget w ){
        _widget = w;
        notifyListeners();
    }

    Widget get widget => _widget;
   
}

class WidgetChangeMedicoHorarios extends ChangeNotifier{
    
     Widget _widget;
     WidgetChangeMedicoHorarios(){
         this._widget = MisHorariosMedico();
     }

     void changeWidget( Widget w ){
          _widget = w;
          notifyListeners();
     }

     Widget get widget => _widget;

}