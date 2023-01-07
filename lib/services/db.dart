import 'package:cloud_firestore/cloud_firestore.dart';

// generate a class for the firestore instance
class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create a document with a unique ID
  Future<void> createUserDocument(String name, String email, String uid) async {
    var created = DateTime.now();

    Map<String, dynamic> newUserDoc = {
      'uid': uid,
      'name': name,
      'email': email,
      'created': created,
      'updated': created,
      'active': true,
    };

    await _firestore.collection('users').doc(uid).set(newUserDoc);
  }

  // create a document with a unique ID
  Future<String> createGroupDocument(String name) async {
    final groupRef = _firestore.collection('groups').doc();
    var created = DateTime.now();

    Map<String, dynamic> newGroupDoc = {
      'uid': groupRef.id,
      'name': name,
      'description': null,
      'created': created,
      'updated': created,
      'active': true,
    };

    await groupRef.set(newGroupDoc);

    return groupRef.id;
  }

  // create a document with a unique ID
  Future<void> createUserGroupDocument(
      String userId, String groupId, String privileges) async {
    Map<String, dynamic> newUserGroupDoc = {
      'user': userId,
      'group': groupId,
      'privileges': privileges,
    };

    await _firestore.collection('userGroups').doc().set(newUserGroupDoc);
  }

  // get list of documents for user
  Future<List<DocumentSnapshot>> getTasksAssignedToUser(String userId) async {
    var tasks = await _firestore
        .collection('tasks')
        .where('user', isEqualTo: userId)
        .get();

    return tasks.docs;
  }
}
