// import 'package:flutter/material.dart';
// import 'package:kioxke/backend/path.dart';
// import 'package:provider_architecture/viewmodel_provider.dart';
// // import 'package:flutterdownloader/viewmodel.dart';
// import 'package:provider_architecture/provider_architecture.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: Text('File download demo')),
//         body: BodyWidget(),
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }


// class BodyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelProvider<MyViewModel>.withConsumer(
//       viewModel: MyViewModel('https://kioxke.000webhostapp.com/economics_to_be_happier.pdf'),
//       builder: (context, model, child) => Stack(
//         children: <Widget>[
//           Center(
//             child: SizedBox(
//               width: 100,
//               height: 100,
//               child: CircularProgressIndicator(
//                 strokeWidth: 20,
//                 value: model.downloadProgress,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: RaisedButton(
//                 child: Text('Download file'),
//                 onPressed: () {
//                   model.startDownloading();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }