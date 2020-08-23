import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TabsPage extends StatelessWidget {


  Future<List<dynamic>> fetchUsers(int id) async {
    var result = await http.get("https://wrapapi.com/use/tremetrex09/newsclipscrapper/Book/latest?id=$id&wrapAPIKey=nEutonp6nd0EhAOCJ8Ti4lYFcF9dWUKo");
    return json.decode(result.body)['data']['ListaBooks'];
  }

 TabsPage(this.calback,this.titulo,this.goback);
 final Function calback;
  final Function goback;
 final String titulo;
 
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(253, 172, 66, 1) ,
         bottom: PreferredSize(
             preferredSize: const Size.fromHeight(60.0),
           child:Container(
             color: Colors.white,
           width: MediaQuery.of(context).size.width,
           height: 60,
           child: TabBar(
             labelColor: Colors.black,
             indicatorColor:Colors.amber,
             labelStyle: TextStyle( fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "Todos"),
                Tab(text: "Populares"),
                Tab(text: "Categoria"),
              ],
            ),
         )
         ),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
                  goback(1,"");
                }),
                Text("$titulo",style: TextStyle(fontSize:20),),
                IconButton(icon: Icon(Icons.more_vert),onPressed: (){}),
              ]
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:TabBarView(
            children: [

              tabsGrid(calback,context,fetchUsers(2),true),
                tabsGrid(calback,context,fetchUsers(3),false),
                  tabsGrid(calback,context,fetchUsers(2),false),
            ],
          ),
      )
     
   ),
  );
  }


Widget tabsGrid(Function(int,String,String,String,String) callback,BuildContext context,Future claFunture,bool conTitulo){


return SingleChildScrollView(
          child:Column(
              children: [
                conTitulo == true?
             Padding(
                 padding: EdgeInsets.only(top:20,bottom: 10),
                 child: Container(
                   alignment: Alignment.center,
                   width: MediaQuery.of(context).size.width-45,
                   height:60,
                   decoration: BoxDecoration(
                     color: Colors.grey[200],
                     borderRadius: BorderRadius.all(Radius.circular(5))
                   ),
                   child:Text("Mais Populares"),
                 ),
          ):Text(""),

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-220,
            padding: EdgeInsets.only(left:5,right:5),
            child:FutureBuilder<List<dynamic>>(
          future: claFunture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(4.0),
              childAspectRatio: 7.0 / 9.0,
              children: List<Widget>.generate(snapshot.data.length, (index) {
              String _normalizeNum(num d) {
                d = d.clamp(double.negativeInfinity, 999999);
                d = num.parse(d.toStringAsFixed(6).substring(0, 7));
                if (d == d.toInt()) {
                  d = d.toInt();
                }
                return d.toString();
              }
              //depos remover ela dai
              Random random = new Random();
              int randomNumber = random.nextInt(600);

              return snapshot.data[index]['titulo'] != null? boxesNews(callback,snapshot.data[index]['titulo'],snapshot.data[index]['img'],_normalizeNum(randomNumber)):CircularProgressIndicator();
            })
          );

        }else {
          return Center(child: CircularProgressIndicator());
        }

            }
          )

      )               
      ],
    ));
}



Widget boxesNews(Function(int,String,String,String,String) callback,String nome,String imgUrl,String preco,){
  return GestureDetector(
    onTap: (){
     callback(3,nome,imgUrl,preco,double.parse(preco).toStringAsFixed(2));
    },
    child:Container(
    width: 190,
    height: 280,
    padding: EdgeInsets.all(10),
    child: Column(
      children:<Widget>[

        Container(
          width:240,
          height:180,
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(image: NetworkImage(imgUrl),fit: BoxFit.fill),
            borderRadius:BorderRadius.all(Radius.circular(5))
          ),
        ),

        Container(
          width: 190,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(3),
          height:20,
          child:Text("$nome",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,),)
        ),

         Container(
          width: 190,
          alignment: Alignment.centerLeft,
          height:20,
          child:Text(double.parse(preco) > 100?double.parse(preco).toStringAsFixed(2)+"AOA":"Gratuito",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color:double.parse(preco) > 0?Colors.amber:Colors.green),)
        )

      ]
    )
  )
  );
}

}

