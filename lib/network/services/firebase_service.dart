
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('feedBack');
}
