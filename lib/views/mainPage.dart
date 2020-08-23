import 'package:flutter/material.dart';

// final Function(int) gotoP = (a){};

Widget mainPage(BuildContext context, Function callbak) {
  return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(253, 172, 66, 1),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            // color: Colors.red,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.sort), onPressed: () {}),
                  Text(
                    "Kioxke",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                ]),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 80,left:15, right:15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              buttonBox("https://i.pinimg.com/originals/0c/a9/fb/0ca9fba306bfb65f98e40802e95f062a.jpg","Jornais",context,callbak),
              buttonBox(
                  "https://image.isu.pub/120430172719-9dd38fe88074479cb86e0446b400a3bb/jpg/page_1_thumb_large.jpg",
                  "Revistas",
                  context,callbak),
                  
              buttonBox(
                  "https://http2.mlstatic.com/kit-livros-harry-potter-capa-dura-2-ao-8-lacrados-D_NQ_NP_871790-MLB27828435642_072018-F.jpg",
                  "Livros",
                  context,callbak)
            ]),
      ));
}




Widget buttonBox(String urlink, String textTitle, BuildContext context,Function(int, String) callbak) {
  return GestureDetector(
      onTap: () {
        callbak(2, "$textTitle");
      },
      child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Stack(children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 180,
                  alignment: Alignment(0.3, 0),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(253, 172, 66, 1)),
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(urlink), fit: BoxFit.fill),
                    ),
                  ),
                ))
          ])));
}





