import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora_admin/chat/controller/chat_controller.dart';
import 'package:decora_admin/chat/model/RecentObjModel.dart';
import 'package:decora_admin/common/common_service.dart';
import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  String? imageUrl;

   ChatRoom({super.key,required this.imageUrl});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  List<types.Message> _messages = [];
  var controller = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: controller.currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: controller.currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: controller.currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    controller.fireStoreInstance
        .collection(CommonService.schoolCode)
        .doc("Chats")
        .collection(controller.chatRoomId)
        .add(textMessage.toJson());

    RecentObjModel teacherDetail = RecentObjModel(
        type: textMessage.text,
        author: Author.fromJson(textMessage.author.toJson()),
        createdAt: textMessage.createdAt,
        detail: Detail(
          img: "${EndPoints.baseDownloadUrl+controller.currentTeacherEmp.photo!}",
          name: controller.currentTeacherEmp.sT_Name,
          uid: controller.receiverUserId,
          qualification: "",
          gender: controller.currentTeacherEmp.sT_Gender,
        ),
        id: textMessage.id,
        text: textMessage.text);

    var dashboard = Get.find<DashboardController>();

    RecentObjModel currentDetail = RecentObjModel(
        type: textMessage.text,
        author: Author.fromJson(textMessage.author.toJson()),
        createdAt: textMessage.createdAt,
        detail: Detail(
          img:
              '${EndPoints.baseDownloadUrl}${dashboard.dashboardService.dashboardModel.value.profile?[0].emp_Photo ?? ""}',
          name:
              "${dashboard.dashboardService.dashboardModel.value.profile?.first.emp_Name} ",
          uid: controller.currentUserId,
          qualification:
              "${dashboard.dashboardService.dashboardModel.value.profile?.first.subjectExpertise}",
          gender: controller.currentTeacherEmp.sT_Gender,
        ),
        id: textMessage.id,
        text: textMessage.text);

    controller
        .recentFromCurrentUserToReceiverUser()
        .set(teacherDetail.toJson());
    controller
        .recentFormReceiverUserToCurrentUser()
        .set(currentDetail.toJson());
    controller.chatService.saveChat(msg: textMessage.text, roomId: controller.chatRoomId, stuId: controller.receiverUserId, senderId: teacherDetail.author?.id??"");

    _addMessage(textMessage);
  }

/*
  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }
*/

  List<types.Message> _loadMessages(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    /*final messages =  snapshot.data?.docs
        .map((e) => types.Message.fromJson(e.data()))
        .toList();*/
    List<types.Message> messages = [];
    snapshot.data?.docs.forEach((e) {
      messages.insert(0, types.TextMessage.fromJson(e.data()));
    });
    // setState(() {
    //   _messages = messages!;
    // });
    return messages;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.primary,
      title: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Ams().imageWidget(widget.imageUrl, fit: BoxFit.fill),
          ),
          SizedBox(width: 10.w,),
          Text(
            controller.currentTeacherEmp.sT_Name!,
            overflow: TextOverflow.ellipsis,

            style:
            getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
          ),
        ],
      ),
    ),
        body: StreamBuilder(
            stream: controller.getChatRoomSnapshot(),
            builder: (context, snapshot) {
              return Chat(
                messages: _loadMessages(snapshot),
                // onAttachmentPressed: _handleAttachmentPressed,
                // onMessageTap: _handleMessageTap,
                // onPreviewDataFetched: _handlePreviewDataFetched,
                onSendPressed: _handleSendPressed,
                disableImageGallery: true,
                showUserAvatars: false,
                showUserNames: true,
                theme: DefaultChatTheme(
                  primaryColor: ColorManager.primary,
                  inputBackgroundColor: ColorManager.primaryMedium,
                  inputTextColor: ColorManager.black,
                ),
                user: controller.currentUser,
              );
            }),
      );
}
