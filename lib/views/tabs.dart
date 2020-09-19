
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kioxke/views/bookSingular.dart';


class TabsPage extends StatelessWidget {
 TabsPage(this.titulo);
 final String titulo;


  Future<List<dynamic>> fetchUsers(String id) async {
    var result = await http.get("https://kioxke.000webhostapp.com/?catType="+id+"");
    return json.decode(result.body);
  }


 
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
                Tab(text: "Tudo"),
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
                // IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.transparent),onPressed:null),
                Container(width:30,height:30,),
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

              tabsGrid(context,fetchUsers(titulo.toLowerCase()),true),
                tabsGrid(context,fetchUsers(titulo.toLowerCase()),false),
                  tabsGrid(context,fetchUsers(titulo.toLowerCase()),false),

            ],
          ),
      )
     
   ),
  );
  }


Widget tabsGrid(BuildContext context,Future claFunture,bool conTitulo){
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
              childAspectRatio:0.82,
              children: List<Widget>.generate(snapshot.data.length, (index){
              return snapshot.data[index]['titulo'] != null? boxesNews(context,()=>  openBookDetail(context,snapshot.data[index]['titulo'],snapshot.data[index]['capa'],snapshot.data[index]['descricao'],snapshot.data[index]['preco'],snapshot.data[index]['autor'],snapshot.data[index]['likes'],snapshot.data[index]['src']),
               snapshot.data[index]['titulo'],snapshot.data[index]['capa'],snapshot.data[index]['preco'],snapshot.data[index]['descricao'],snapshot.data[index]['autor'],snapshot.data[index]['likes'],snapshot.data[index]['src']):SpinKitRipple(color: Colors.amber,size: 70.0,);
            })
          );

        }else {
          return Center(child: SpinKitRipple(color: Colors.amber,size: 80.0,));
        }
            }
          )

      )               
      ],
    ));
}



Widget boxesNews(BuildContext context,Function callback,String nome,String imgUrl,String preco, String descricao, String autor, String likes,String src){
  return GestureDetector(
    onTap: (){
         Navigator.push(context,MaterialPageRoute(builder: (context) => SingleBook(nome,imgUrl,descricao,double.parse(preco).toStringAsFixed(2),autor,likes,src)));
    //callback(3,nome,imgUrl,descricao,double.parse(preco).toStringAsFixed(2),autor,likes,src);
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
            image: DecorationImage(image: NetworkImage(imgUrl),fit: BoxFit.cover),
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
          child:Text(double.parse(preco) > 100?double.parse(preco).toStringAsFixed(2)+" AOA":"Gratuito",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color:double.parse(preco) > 0?Colors.amber:Colors.green),)
        )

      ]
    )
  )
  );
}

}

void openBookDetail(BuildContext context, String nameBook,String imageBook,String discriptBook,String priceBook,String autorBook,String likes,String bookUrl){
     Navigator.push(context,MaterialPageRoute(builder: (context) => SingleBook( nameBook, imageBook, discriptBook, priceBook, autorBook, likes, bookUrl)));
}

