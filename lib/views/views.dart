import 'package:flutter/material.dart';
import 'package:kioxke/views/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
   Future<String> _email,_nome;
   final _formKey = GlobalKey<FormState>();
 
  Future<void> _checkSession(String nome,String email) async {
       final SharedPreferences prefs = await _prefs;
    //final int counter = (prefs.getInt('counter') ?? 0) + 1;
      if(prefs.getString("email") != null){
         print(prefs.getString("email")+prefs.getString("nome"));
         Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>  MainPage(prefs.getString("nome"),prefs.getString("email"))),(Route<dynamic> route) => false);
      }
    }


@override
  void initState() {
    super.initState();
      _email = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('email'));
    });
      _nome = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('nome'));
    });
     _checkSession(_nome.toString(),_email.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color:Color.fromRGBO(115, 115, 115,1)
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.8,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage('images/logo.png') )
                   ),
              )
                ],
              )
            ),
            
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.4,
              child:_nome.toString() == null?SpinKitRipple(color: Colors.white,size: 60.0,):Column(
                children: [
            Form(
                 key: _formKey,
                 child: Column(
                 children: <Widget>[
                            button(context,false,"Entrar",1,(){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                            }),
                            button(context,true,"Criar Conta",1,(){}),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                            button(context,true,"Facebook",2.4,(){}),
                            button(context,true,"Twitter",2.4,(){}),
                         ],
                       )
                   ]

            ))

               
                ],
              ),
            ),

          ],
        )


        ),
      )
    );
  }

}

Widget button(BuildContext context,bool isBorder,String titulo, double devide,Function callback){
  return Padding(padding:EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 15),
    child: FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: callback,
      child: Container(
        width: MediaQuery.of(context).size.width/devide,
        height:  60,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:isBorder == false?Color.fromRGBO(253, 172, 66, 1):Colors.transparent,
          border: isBorder==true? Border.all(color: Colors.white,):null,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        // Icon(Icons.face),
        Text("$titulo",style: TextStyle(color: Colors.white,fontSize: 15))
      ],)
    )
    )
  );
}



// Widget button(BuildContext context){
//   return FlatButton(onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),
//                 ), child: Text("Ir"));
// }




