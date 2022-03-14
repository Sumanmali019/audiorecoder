// import 'dart:io';
// import 'package:audiorecoed/firebaseAuth/firebase.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

// class Upload {
//   bool? isDone = false;
//   UploadTask? task;
//   File? pathTosave;

//   Future<void> uploadAudio() async {
//     if (pathTosave == null) return;
//     FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//     User? user = FirebaseAuth.instance.currentUser;

//     final filename = basename(pathTosave!.path);
//     final destination = '${user!.uid}/$filename}';

//     task = FirebaseApi.uploadTask(destination, pathTosave!);
//     task!.whenComplete(() => isDone = true);
//   }
// }

// class FirebaseApi {
//   static UploadTask? uploadTask(String destination, File pathTosave) {
//     try {
//       final ref = FirebaseStorage.instance.ref(destination);
//       return ref.putFile(pathTosave);
//     } on FirebaseException catch (e) {
//       print('error while uploading');
//     }
//     return null;
//   }
// }

// import 'dart:io';

// import 'package:audiorecoed/firebaseAuth/firebase.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class Recodedbutton extends StatefulWidget {
//   final Function onUploadComplete;
//   Recodedbutton({
//     Key? key,
//     required this.onUploadComplete,
//   }) : super(key: key);

//   @override
//   State<Recodedbutton> createState() => _RecodedbuttonState();
// }

// class _RecodedbuttonState extends State<Recodedbutton> {
//   late bool _isUploading;
//   late String _filePath;

//   @override
//   @override
//   void initState() {
//     super.initState();
//     _isUploading = false;
//   }

//   Widget build(BuildContext context) {
//     return const Center();
//   }

//   Future<void> _onFileUploadButtonPressed() async {
//     FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//     setState(() {
//       _isUploading = true;
//     });
//     try {
//       await firebaseStorage
//           .ref('upload-voice-firebase')
//           .child(
//               _filePath.substring(_filePath.lastIndexOf('/'), _filePath.length))
//           .putFile(File(_filePath));
//       widget.onUploadComplete();
//     } catch (error) {
//       print('Error occured while uplaoding to Firebase ${error.toString()}');
//     } finally {
//       setState(() {
//         _isUploading = false;
//       });
//     }
//   }
// }
