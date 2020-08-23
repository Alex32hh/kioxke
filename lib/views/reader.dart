import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFScreen extends StatelessWidget {
  final String nameBook;
  String pathPDF = "";
  PDFScreen(this.pathPDF,this.nameBook);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("$nameBook"),
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(253, 172, 66, 1) ,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF);
  }
}