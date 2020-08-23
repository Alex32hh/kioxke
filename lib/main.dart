import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kioxke/views/Login.dart';
import 'package:kioxke/views/bookSingular.dart';
import 'package:kioxke/views/mainPage.dart';
import 'package:kioxke/views/reader.dart';
import 'package:kioxke/views/tabs.dart';
import 'package:http/http.dart' as http;
void main(){
  runApp(
    MaterialApp(
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController _pageController = PageController(initialPage:0,);
    //book information
   String nameBook;
   String imageBook;
   String discriptBook;
   String priceBook;
   String goto,tituloAnterior;
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Login(_GotoPage),
          mainPage(context,_GotoPage),
          TabsPage(_gotoBook,goto,_GotoPage),
          SingleBook(nameBook,imageBook,discriptBook,priceBook,_GotoPage,tituloAnterior),
        ],
      )
    );
  }



 void _GotoPage(int pageNumber,String titulo){
   setState(() {
     goto = titulo;
     tituloAnterior = titulo;
   });
    _pageController.jumpToPage(pageNumber);
 }


 void _gotoBook(int pageNumber,String nameB,String imageB,String discriptB,String priceB){
   
    setState(() {
      nameBook = nameB;
      imageBook = imageB;
      discriptBook = discriptB;
      priceBook = priceB;
    });

    _pageController.jumpToPage(pageNumber);

}






}

