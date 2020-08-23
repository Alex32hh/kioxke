import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function callback;
  Login(this.callback);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
     
    final _formKey = GlobalKey<FormState>();

  @override
Widget build(BuildContext context) {
  return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color:Color.fromRGBO(115, 115, 115, 1)
          ),
          child: Column(
            children: [

          Container(
              padding: EdgeInsets.only(top:40),
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height /2,
             child: Column(
              children: [
               logo(),
               textLogo()
              ], 
             ),
            ),

            Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height /2,
             
             child: Column(
               children: [
                 Form(
                 key: _formKey,
                 child: Column(
                 children: <Widget>[
                     inputlista("Nome de Utilizador"),
                     inputlista("Palavra-Passe"),
                     loginButton("Entrar",Color.fromRGBO(253, 172, 66, 1),widget.callback),
                     loginButton("Nao tem Conta? Crie uma aqui",Colors.transparent,widget.callback)
                   ]
                    )
                 )
               ],
             ),
            )
            ], 
          ),
        );
}

Widget loginButton(String labelText,Color cor,Function callback){
  return Padding(
    padding: EdgeInsets.only(top: 10,right: 10, left: 10),
    child:FlatButton(onPressed:(){
      callback(1,"");
    },
   padding:EdgeInsets.all(0.0),
   child: Container(
     alignment: Alignment.center,
      width: MediaQuery.of(context).size.width -10,
      height:60.0,
      decoration: BoxDecoration(
        color: cor,

        borderRadius: BorderRadius.all(Radius.circular(5))
        // Color.fromRGBO(253, 172, 66, 1)
      ),
      child: Text("$labelText",style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),),
   )
 )
   );
}

Widget logo(){
  return Container(
   alignment: Alignment(0,1),
   width: MediaQuery.of(context).size.width,
   height: 300,
  //  color: Colors.red,
   child: Container(
     width:300,
     height:150,
     alignment: Alignment.center,
     child: Image.asset('images/logo.png')
   ),
  );
}

Widget textLogo(){
  return Container(
    // color: Colors.red,
    alignment: Alignment.center,
    width: 200,
    height: 50,
    child: Text('Entrar',style: TextStyle(color:Colors.white, fontSize: 20)),
  );
}

Widget inputlista(String label){
  return Padding(
    padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
    child:TextField(
    style: TextStyle(fontSize: 12.0, color: Colors.white),
    textAlign: TextAlign.center,
    decoration: InputDecoration(

      hintText: '$label',
      hintStyle: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
      fillColor: Color.fromRGBO(175, 175, 175, 1),
      filled: true,
      contentPadding: const EdgeInsets.all(20.0),
      border:OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0),),
    ),

    ),
  )
  );

}

}
