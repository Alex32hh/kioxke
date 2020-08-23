import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kioxke/views/reader.dart';
import 'package:path_provider/path_provider.dart';


class SingleBook extends StatefulWidget {

   final String nameBook;
   final String imageBook;
   final String discriptBook;
   final String priceBook;
   final String tituloAnterior;
   final Function goback;


  SingleBook(this.nameBook,this.imageBook,this.discriptBook,this.priceBook,this.goback,this.tituloAnterior);
  // SingleBook({Key key}) : super(key: key);

  @override
  _SingleBookState createState() => _SingleBookState();
}

class _SingleBookState extends State<SingleBook> {

  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "https://www.lendo.org/wp-content/uploads/2008/04/o-uraguai.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }


  @override
  Widget build(BuildContext context) {
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
                  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
                   widget.goback(2,widget.tituloAnterior);
                  }),
                Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text: widget.nameBook),
                ),
              ),
                  IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
                ]),
          )
        ],
      ),

      body: SingleChildScrollView(child:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height+40,
        padding: EdgeInsets.only(left:15,right:15,top:15),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
        children: [
           boxFirst(context),
           titulo(context,"Descricao"),
           boxDescricao(context),
           titulo(context,"Comentarios"),

          buttonBox(
                  "https://http2.mlstatic.com/kit-livros-harry-potter-capa-dura-2-ao-8-lacrados-D_NQ_NP_871790-MLB27828435642_072018-F.jpg",
                  "Livros",
                  context,null),
          buttonBox(
                  "https://http2.mlstatic.com/kit-livros-harry-potter-capa-dura-2-ao-8-lacrados-D_NQ_NP_871790-MLB27828435642_072018-F.jpg",
                  "Livros",
                  context,null),
          buttonBox(
                  "https://http2.mlstatic.com/kit-livros-harry-potter-capa-dura-2-ao-8-lacrados-D_NQ_NP_871790-MLB27828435642_072018-F.jpg",
                  "Livros",
                  context,null),
          
        ],
      ),

      ))
    );
  }


Widget boxFirst(BuildContext context){
   return Container(
     width: MediaQuery.of(context).size.width-10,
     height: 200,
     child: Row(
       children: [
         Container(
            width:MediaQuery.of(context).size.width /3,
            height: 200,
            decoration: BoxDecoration(
              color:Colors.amber,
              image: DecorationImage(image: NetworkImage(widget.imageBook),fit:BoxFit.fill),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
         ),
         
           Container(
            width:MediaQuery.of(context).size.width /1.7,
            height: 200,
            child: Column(
              children: [

                Container(
                  width:MediaQuery.of(context).size.width /1.6,
                  height: 45,
                  padding: EdgeInsets.all(15),
                  child: Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),
                        text: widget.nameBook),
                  ),
                ),
                ),

                 Container(
                  width:MediaQuery.of(context).size.width /1.6,
                  height: 20,
                   alignment: Alignment(-0.7,0),
                  child: Text("Edições de Novembro"),
                ),

                 Container(
                  width:MediaQuery.of(context).size.width /1.6,
                  height: 40,
                   alignment: Alignment(-0.80,0),
                  child: Text(widget.priceBook+"AOA",style: TextStyle(color:Colors.amber,fontSize: 20),),
                ),

                 Container(
                  width:MediaQuery.of(context).size.width /1.6,
                  height: 40,
                   alignment: Alignment(-0.7,0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      Container(
                        width: 70,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Container(
                             padding: EdgeInsets.only(left:15),
                             child: Icon(Icons.share,color: Colors.amber, size: 20,),
                           ),
                           Container(
                             padding: EdgeInsets.only(left:0),
                             child: Text("200")
                           )
                          ],
                         ),
                      ),


                      Container(
                        width: 70,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Container(
                             padding: EdgeInsets.only(left:15),
                             child: Icon(Icons.favorite_border,color: Colors.amber, size: 20,),
                           ),
                           Container(
                             padding: EdgeInsets.only(left:0),
                             child: Text("500")
                           )
                          ],
                         ),
                      ),
                    
                    ],
                  ),
                ),


                Padding(padding: EdgeInsets.only(left:110),
                child: FlatButton(
                onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFScreen(pathPDF, widget.nameBook)),
                ), 
                child: Container(
                  width:MediaQuery.of(context).size.width /4,
                  height: 40,
                   alignment: Alignment(0,0),
                 
                   decoration: BoxDecoration(
                     border: Border(
                      top: BorderSide(width: 2.0, color: Colors.amber),
                      left: BorderSide(width: 2.0, color: Colors.amber),
                      right: BorderSide(width: 2.0, color: Colors.amber),
                      bottom: BorderSide(width: 2.0, color: Colors.amber),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.amber
                   ),
                  child: Text("Abrir",style: TextStyle(color:Colors.black,fontSize: 15),),
                ),)
                )


              ],
            ),
         ),



       ],
     ),
   );
 }

Widget titulo(BuildContext context,String Titulo){
  return Container(
   width: MediaQuery.of(context).size.width,
   height: 40,
   alignment: Alignment(-0.98,0),
   child: Text(Titulo,style: TextStyle(fontWeight: FontWeight.bold),),
  );
} 

Widget boxDescricao(BuildContext context){
   return Container(
     width: MediaQuery.of(context).size.width-10,
     height: 190,
     padding: EdgeInsets.only(left:5),
     child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
   );
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
                  height: 130,
                  padding: EdgeInsets.only(left:50),
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
                  child: Container(
                    width:10,
                    height:100,
                    child: Column(
                      children: [

                        Container(
                          width:250,
                          alignment: Alignment.centerLeft,
                          height:40,
                          child: Text("Alexandre Marques",style: TextStyle(fontWeight:FontWeight.bold),)
                        ),
                        Container(
                          width:250,
                          alignment: Alignment.topLeft,
                          height:60,
                          child: Text("O jornal e bla bla bla")
                        ),
                        Container(
                          width:250,
                          alignment: Alignment.centerLeft,
                          height:20,
                          child: Text("9:00")
                        ),

                      ],
                    ),
                  )
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(urlink), fit: BoxFit.fill),
                    ),
                  ),
                ))
          ])));
}

}