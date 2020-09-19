import 'package:flutter/material.dart';

class DrawerPg extends StatefulWidget {
  @override
  _DrawerPgState createState() => _DrawerPgState();
  final String _nomeUser,_emailUser;
  DrawerPg(this._nomeUser,this._emailUser);
}

class _DrawerPgState extends State<DrawerPg> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color:Color.fromRGBO(115, 115, 115, 1)
        ),

        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/bg.jpg'))
              ),
              padding: EdgeInsets.only(top:50),
              alignment: Alignment.center,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                   width: MediaQuery.of(context).size.width /4,
                    height:100,
                    decoration: BoxDecoration(
                       color:Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(image:NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Breezeicons-actions-22-im-user.svg/512px-Breezeicons-actions-22-im-user.svg.png'),
                      fit: BoxFit.fill)
                    ),
                  ),

                   Container(
                    height:50,
                    padding: EdgeInsets.all(15),
                    child: Text(widget._nomeUser,style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 18),),
                  ),

                   Container(
                    height:40,
                    child: Text(widget._nomeUser,style: TextStyle(color:Colors.white, fontSize: 12),),
                  )
                ],
              ),
            ),

            _item(Icons.person,"Conta",(){}),
             _item(Icons.book,"Livros",(){}),
              _item(Icons.library_books,"Jornais",(){}),
               _item(Icons.photo_album,"Revistas",(){}),
                _item(Icons.settings,"Definicoes",(){}),
                 _item(Icons.exit_to_app,"Sair",(){})
          ],
        ),
      )
      );
  }

  Widget _item(IconData icon, String nome, Function onclick){
    return FlatButton(onPressed: onclick,
    padding: EdgeInsets.all(0),
    child: Row(
      children: [

          Container(
            width:60,
            height:70,
            alignment: Alignment.center,
            child:Icon(icon,color: Colors.white, size: 30,)
          ),

          Container(
            width:200,
            height:70,
            alignment: Alignment.centerLeft,
            child:Text(nome,style:TextStyle(color: Colors.white, fontSize: 18),)
          )

    ],)

      );
  }
}