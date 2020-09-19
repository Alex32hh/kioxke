import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kioxke/views/tabs.dart';
import 'drawer.dart';

// final Function(int) gotoP = (a){};
class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
  final String userName ;
  final String userEmail;
  MainPage(this.userName,this.userEmail);
}

class _MainPageState extends State<MainPage> {
   void initState() {
   SystemChannels.textInput.invokeMethod('TextInput.hide');
   super.initState();
   }
   
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        leading: SizedBox(),
        backgroundColor: Color.fromRGBO(253, 172, 66, 1),
        actions: [

          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            // color: Colors.red,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.sort), onPressed: () => _scaffoldKey.currentState.openDrawer(),),
                  Text(("Kioxke").toUpperCase(),style: TextStyle(fontSize: 20),),
                  IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                ]),
          )

        ],
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width /19),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
            children: <Widget>[
              buttonBox("images/jornal.jpg","Jornais",context,()=>   Navigator.push(context,MaterialPageRoute(builder: (context) => TabsPage("Jornais")))),
              buttonBox("images/revistas.jpg","Revistas",context,()=>   Navigator.push(context,MaterialPageRoute(builder: (context) => TabsPage("Revistas")))),
              buttonBox("images/livros.jpg","Livros",context,()=>   Navigator.push(context,MaterialPageRoute(builder: (context) => TabsPage("Livros")))),
              buttonBox("images/bd.jpg","Banda Desenhada",context,()=>   Navigator.push(context,MaterialPageRoute(builder: (context) => TabsPage("Banda Desenhada")))),
            ]),
      )
      ,
      drawer: DrawerPg(widget.userName,widget.userEmail)

      );
     
  }
  
}



Widget buttonBox(String urlink, String textTitle, BuildContext context,Function() callbak) {
  return GestureDetector(
      onTap: () {
        callbak();
      },
      child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Stack(children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 160,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width /3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    textTitle,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(253, 172, 66, 1)),
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          image:AssetImage(urlink), fit: BoxFit.cover,alignment: Alignment.topCenter),
                    ),
                  ),
                ))
          ])));
}





