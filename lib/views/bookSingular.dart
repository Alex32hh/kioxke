
import 'dart:async';
import 'dart:io';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:kioxke/backend/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
// import 'package:universal_html/html.dart';

class SingleBook extends StatefulWidget {
   final String nameBook;
   final String imageBook;
   final String discriptBook;
   final String priceBook;
   final String autorBook;
   final String likes;
   final String bookUrl;

  SingleBook(this.nameBook,this.imageBook,this.discriptBook,this.priceBook,this.autorBook,this.likes,this.bookUrl);
  // SingleBook({Key key}) : super(key: key);

  @override
  _SingleBookState createState() => _SingleBookState();
}

  bool isDownloaded = false;
  bool isOndownload = false;
  String directorio,nameBook;

class _SingleBookState extends State<SingleBook> {

  String pathPDF = "";

  Future<bool> getFileNameWithExtension()async{
      //return file with file extension
      final filename = widget.bookUrl.substring(widget.bookUrl.lastIndexOf("/") + 1);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      if(await file.exists())
        return true;
      else
        return false;
  }

  Future<String> getFile()async{
      final filename = widget.bookUrl.substring(widget.bookUrl.lastIndexOf("/") + 1);
      var dir = await getApplicationDocumentsDirectory();
      String file = "${dir.path}/$filename";
      return file.toString();
  }



   Timer timer;

  @override
  void initState() {
    super.initState();

    getFile().then((value) {
      directorio = value;
      print(directorio);
    });

    timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) =>  getFileNameWithExtension().then((value){
      setState(() {
        isDownloaded =  value;    
        if(isDownloaded==true)       
           isOndownload = false;
      });
    }));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
               Container(
                 width:30,
                 height:30,
               ),
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
           titulo(context,"Descrição"),
           boxDescricao(context),
           titulo(context,"Comentários"),

          buttonBox(
                  "https://i.pinimg.com/originals/34/13/d7/3413d7b3b1ab1c3e841f71395809d789.jpg",
                  "Livros",
                  context,null,"Um dos melhores, se não o melhor livro 'técnico' que já tive a oportunidade de ler.","Filipe Aparecido"),
          buttonBox(
                  "https://i.pinimg.com/280x280_RS/62/c9/df/62c9dfc2bb087e1c53e2513ec6ce443b.jpg",
                  "Livros",
                  context,null,"Linguagem super acessível. Explicado de forma prática e fácil de entender.","José Monkundua"),
          buttonBox(
                  "https://cdn-sites-images.46graus.com/files/photos/ef6b6166/29b69b72-67b9-4ea8-8347-227d5900e805/carla-e-felipe-288-768x510.jpg",
                  "Livros",
                  context,null,"Excelente! Parabéns! Esse livro não só me ensinou um tema que sempre tive preguiça de abordar, mas me deu também uma excelente aula de didática na informática.","Lucas Amaral"),
          
        ],
      ),

      ))
    );
  }


Widget boxFirst(BuildContext context){
   return   Flexible(
      flex: 3,
      fit: FlexFit.loose,
     child:Container(
     width: MediaQuery.of(context).size.width-10,
     height: 200,
     child: Row(
       children: [

         Container(
            width:MediaQuery.of(context).size.width /3,
            height: 200,
            decoration: BoxDecoration(
              color:Colors.grey[200],
              image: DecorationImage(image: NetworkImage(widget.imageBook),fit:BoxFit.fill),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
         ),
           Flexible(
              flex: 3,
              child:
           Container(
            width:MediaQuery.of(context).size.width /1.7,
            height: 300,
            child: Column(
              children: [

             Flexible(
              flex: 3,
              child:Container(
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
                )
              )),

                 Container(
                  width:MediaQuery.of(context).size.width /1.6,
                  height: 20,
                   alignment: Alignment(-0.8,0),
                  child: Text(widget.autorBook),
                ),

                 Container(
                  width:MediaQuery.of(context).size.width /1.6,
                  height: 40,
                   alignment: Alignment(-0.76,0),
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
                             child: Text("0")
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
                             child: Text(widget.likes)
                           )
                          ],
                         ),
                      ),
                    
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: ViewModelProvider<MyViewModel>.withConsumer(
               viewModel: MyViewModel(widget.bookUrl,widget.bookUrl.substring(widget.bookUrl.lastIndexOf("/") + 1)),
              builder: (context, model, child) => Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                                  Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDownloaded==false?Colors.amber:Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child:  Text("Adicionar +",style: TextStyle(color:Colors.white,fontSize: 15))
                ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                padding: EdgeInsets.all(0),
                child:isOndownload == true?CircularPercentIndicator( progressColor:Colors.amber,radius: 40, percent:model.downloadProgress==null?0:model.downloadProgress, ):
                Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDownloaded==false?Colors.amber:Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child:  Text(isDownloaded==true?"Ler":"Comprar",style: TextStyle(color:Colors.white,fontSize: 15))
                ),
                onPressed: () async {
                  if(isDownloaded == false){
                    model.startDownloading();
                    setState(() {
                        isOndownload = true;
                    });
                  }
                  else{
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => PDFScreen(directorio,fileName)));

                    
                  //   EpubViewer.setConfig(
                  //     themeColor: Theme.of(context).primaryColor,
                  //     identifier: "iosBook",
                  //     scrollDirection: EpubScrollDirection.VERTICAL,
                  //     allowSharing: false,
                  //     enableTts: true,
                  //   );
                    
                  //  EpubViewer.open(
                  //   directorio,
                  //    lastLocation: EpubLocator.fromJson({
                  //      "bookId": "2239",
                  //      "href": "/OEBPS/ch06.xhtml",
                  //      "created": 1539934158390,
                  //      "locations": {
                  //        "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                  //      }
                  //    }),
                  //  );

                  }
                 
                },
              ),
          ),

        ],
      ),
    )
                )
                
              ],
            ),
         ),
        )],
     ),
   ));
 }

Widget titulo(BuildContext context,String titulo){
  return Container(
   width: MediaQuery.of(context).size.width,
   height: 40,
   alignment: Alignment(-0.98,0),
   child: Text(titulo,style: TextStyle(fontWeight: FontWeight.bold),),
  );
} 

Widget boxDescricao(BuildContext context){
   return Container(
     width: MediaQuery.of(context).size.width-10,
     height: 100,
     padding: EdgeInsets.only(left:5),
     child: Text(widget.discriptBook,style: TextStyle(),)
   );
}

Widget buttonBox(String urlink, String textTitle, BuildContext context,Function(int, String) callbak,String comentario,String nome) {
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
                          width:240,
                          alignment: Alignment.centerLeft,
                          height:40,
                          child: Text("$nome",style: TextStyle(fontWeight:FontWeight.bold),)
                        ),
                        Container(
                          width:250,
                          alignment: Alignment.topLeft,
                          height:50,
                          child: Text("$comentario")
                        ),
                        Container(
                          width:250,
                          padding: EdgeInsets.only(top:5),
                          alignment: Alignment.centerLeft,
                          height:20,
                          child: Text("Há 10 horas ")
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
                          image: NetworkImage(urlink), fit: BoxFit.cover,alignment: Alignment.centerRight),
                    ),
                  ),
                ))
          ])));
}

}


