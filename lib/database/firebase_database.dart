// import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
// import 'package:flutter/material.dart';

// import 'firebase_options.dart';

// // Change to false to use live database instance.
// const USE_DATABASE_EMULATOR = true;
// // The port we've set the Firebase Database emulator to run on via the
// // `firebase.json` configuration file.
// const emulatorPort = 9000;
// // Android device emulators consider localhost of the host machine as 10.0.2.2
// // so let's use that if running on Android.
// final emulatorHost =
//     (defaultTargetPlatform == TargetPlatform.android)
//         ? '10.0.2.2'
//         : 'localhost';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   if (USE_DATABASE_EMULATOR) {
//     FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, emulatorPort);
//   }

//   runApp(
//     const MaterialApp(
//       title: 'Flutter Database Example',
//       home: MyHomePage(),
//     ),
//   );
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   late DatabaseReference _counterRef;
//   late DatabaseReference _messagesRef;
//   late StreamSubscription<DatabaseEvent> _counterSubscription;
//   late StreamSubscription<DatabaseEvent> _messagesSubscription;
//   bool _anchorToBottom = false;

//   String _kTestKey = 'Hello';
//   String _kTestValue = 'world!';
//   FirebaseException? _error;
//   bool initialized = false;

//   @override
//   void initState() {
//     init();
//     super.initState();
//   }

//   Future<void> init() async {
//     _counterRef = FirebaseDatabase.instance.ref('counter');

//     final database = FirebaseDatabase.instance;

//     _messagesRef = database.ref('messages');

//     database.setLoggingEnabled(false);

//     if (!kIsWeb) {
//       database.setPersistenceEnabled(true);
//       database.setPersistenceCacheSizeBytes(10000000);
//     }

//     if (!kIsWeb) {
//       await _counterRef.keepSynced(true);
//     }

//     setState(() {
//       initialized = true;
//     });

//     try {
//       final counterSnapshot = await _counterRef.get();

//       print(
//         'Connected to directly configured database and read '
//         '${counterSnapshot.value}',
//       );
//     } catch (err) {
//       print(err);
//     }

//     _counterSubscription = _counterRef.onValue.listen(
//       (DatabaseEvent event) {
//         setState(() {
//           _error = null;
//           _counter = (event.snapshot.value ?? 0) as int;
//         });
//       },
//       onError: (Object o) {
//         final error = o as FirebaseException;
//         setState(() {
//           _error = error;
//         });
//       },
//     );

//     final messagesQuery = _messagesRef.limitToLast(10);

//     _messagesSubscription = messagesQuery.onChildAdded.listen(
//       (DatabaseEvent event) {
//         print('Child added: ${event.snapshot.value}');
//       },
//       onError: (Object o) {
//         final error = o as FirebaseException;
//         print('Error: ${error.code} ${error.message}');
//       },
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _messagesSubscription.cancel();
//     _counterSubscription.cancel();
//   }

//   Future<void> _increment() async {
//     await _counterRef.set(ServerValue.increment(1));

//     await _messagesRef
//         .push()
//         .set(<String, String>{_kTestKey: '$_kTestValue $_counter'});
//   }

//   Future<void> _incrementAsTransaction() async {
//     try {
//       final transactionResult = await _counterRef.runTransaction((mutableData) {
//         return Transaction.success((mutableData as int? ?? 0) + 1);
//       });

//       if (transactionResult.committed) {
//         final newMessageRef = _messagesRef.push();
//         await newMessageRef.set(<String, String>{
//           _kTestKey: '$_kTestValue ${transactionResult.snapshot.value}'
//         });
//       }
//     } on FirebaseException catch (e) {
//       print(e.message);
//     }
//   }

//   Future<void> _deleteMessage(DataSnapshot snapshot) async {
//     final messageRef = _messagesRef.child(snapshot.key!);
//     await messageRef.remove();
//   }

//   void _setAnchorToBottom(bool? value) {
//     if (value == null) {
//       return;
//     }

//     setState(() {
//       _anchorToBottom = value;
//     });
//   }
// }
