import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora_admin/chat/model/RecentObjModel.dart';
import 'package:decora_admin/chat/service/chat_service.dart';
import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/common/model/employee_model.dart';
import 'package:decora_admin/common/model/student_model.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatService = Get.put<ChatService>(ChatService());

  var fireStoreInstance = FirebaseFirestore.instance;

  var chatRoomId = "";
  var currentUserId = CommonService.userId;
  var receiverUserId = "";
  var clsId = "".obs;

  late StudentRecord currentTeacherEmp;

  late var chatRoomInstance;
  late var recentForCurrentUser;
  late var recentForReceiverUser;

  final currentUser = types.User(
    id: CommonService.userId,
  );

  var receiverUser = types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  setCurrentTeacherFromList(StudentRecord empR) {
    currentTeacherEmp = empR;
  }

  setCurrentTeacherFromRecent(RecentObjModel empR) {
    currentTeacherEmp = StudentRecord(
        sT_Name: empR.detail?.name,
        photo: empR.detail?.img,
        user_ID: empR.detail?.uid,
        sT_Gender: empR.detail?.gender);
  }

  CollectionReference<Map<String, dynamic>> recentCollReference(userId) {
    return fireStoreInstance
        .collection(CommonService.schoolCode)
        .doc(userId)
        .collection("FriendList");
  }

  DocumentReference<Map<String, dynamic>>
      recentFromCurrentUserToReceiverUser() {
    return recentCollReference(currentUserId).doc(receiverUserId);
  }

  DocumentReference<Map<String, dynamic>>
      recentFormReceiverUserToCurrentUser() {
    return recentCollReference(receiverUserId).doc(currentUserId);
  }

  setCurrentId(String currentId) {
    currentUserId = currentId;
    Get.log("${currentId}");

  }

  setReceiverId(String receiverId) {
    receiverUserId = receiverId;
    Get.log("Receiver :${receiverId}");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRoomSnapshot() {
    if (currentUserId.compareTo(receiverUserId) < 1) {
      chatRoomId = currentUserId + "-" + receiverUserId;
    } else {
      chatRoomId = receiverUserId + "-" + currentUserId;
    }

    Get.log("Room Id :${chatRoomId}");

    return FirebaseFirestore.instance
        .collection(CommonService.schoolCode)
        .doc("Chats")
        .collection(chatRoomId)
        .orderBy("createdAt", descending: false)
        .limitToLast(20)
        .snapshots();
  }

  /* Stream<QuerySnapshot<Map<String, dynamic>>> buildSnapshots() {
    return FirebaseFirestore.instance
        .collection(CommonService.schoolCode)
        .doc("Chats")
        .collection(chatRoomId)
        .orderBy("createdAt", descending: false)
        .limitToLast(20).snapshots();
  }*/

  setReceiverUser(String receiverId) {
    receiverUser = types.User(
      id: receiverId,
    );
  }

  getFriendList() {}

  loadChatRoomMessage() {}
}
