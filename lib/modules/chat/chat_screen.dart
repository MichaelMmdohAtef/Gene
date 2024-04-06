import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:Gene/library/custom_scroll_view/custom_scroll_view.dart';
import 'package:Gene/library/record_voice/social_media_record_local.dart';
import 'package:Gene/modules/chat/audio_player_widget.dart';
import 'package:Gene/modules/chat/file_chat_widget.dart';
import 'package:Gene/modules/chat/image_chat_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/models/message_model.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';


// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  ChatScreen({required Doctors this.doctorModel});

  Doctors? doctorModel;

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  TextEditingController messageController=TextEditingController();

  FocusNode messageFocus=FocusNode();

  late double screenHeight;

  late double screenWidth;

  var audioRecord;

  ScrollController? listScrollController;


  bool isRecording=false;

  static List<MessageModel> allMessages=[];
  static List<AudioPlayer> audioPlayers=[];


  late BuildContext globalContext;

  GlobalKey scaffoldKey=GlobalKey<ScaffoldState>();

  Directory? tempDir;

  @override
  void initState() {
    // TODO: implement initState
    listScrollController=ScrollController();

    checkPermission();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listScrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allMessages=[];
    audioPlayers=[];

    return Builder(
      builder:(context) {
        if(HomeCubit.get(context).showEmoji)
          HomeCubit.get(context).onChangeEmojiState();

        globalContext=context;

        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            screenHeight = MediaQuery.sizeOf(context).height;
            screenWidth = MediaQuery.sizeOf(context).width;
            // ignore: deprecated_member_use
            return WillPopScope(
              onWillPop: () {
                if(cubit.showEmoji){
                  cubit.onChangeEmojiState();
                  return Future(() => false,);
                }
                return Future(() => true,);
              },
              child: Scaffold(
                key: scaffoldKey,
                appBar: statusBar(),
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if(cubit.showEmoji)
                      cubit.onChangeEmojiState();
                  },
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection(Collection)
                        .doc(SignInCubit.get(context).loginDataModel!.userAccount!.id.toString()).collection("Chats").doc(widget.doctorModel!.userId.toString())
                        .collection("Messages")
                        .orderBy("date",descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                          int count=0;
                        snapshot.data!.docs.forEach((element) {
                          MessageModel message=MessageModel.fromJson(json: element.data(),id: count);
                          if(allMessages.isNotEmpty){
                            MessageModel? model;
                            allMessages.forEach((element) {
                              if(message.date==element.date){
                               model=message;
                              }
                            });
                            if(model!=null){

                            }else{
                              allMessages.add(MessageModel.fromJson(json: element.data(),id: count));
                              audioPlayers.add(AudioPlayer(playerId: count.toString()));
                            }
                          }else{
                            allMessages.add(MessageModel.fromJson(json: element.data(),id: count));
                            audioPlayers.add(AudioPlayer(playerId: count.toString()));
                          }
                          count++;
                        });
                      }
                      return Stack(
                        children: [

                          /// first background
                          Positioned(
                            height: MediaQuery.sizeOf(context).height * 0.8218,
                            width: MediaQuery.sizeOf(context).width,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Image(
                                image: AssetImage(
                                  "assets/Background/App Background-1.png",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            top: 0,
                            left: 0,
                          ),

                          ///second background
                          Positioned(
                            height: MediaQuery.sizeOf(context).height * 0.8218,
                            width: MediaQuery.sizeOf(context).width,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Image(
                                image: AssetImage(
                                  "assets/Background/App Background.png",
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            top: MediaQuery.sizeOf(context).height * 0.8207,
                            left: 0,
                          ),

                          ///app bar
                          appBarWidget(
                            context: context,
                            onPressLeading: () {
                              Navigator.pop(context);
                            },
                            height: MediaQuery.sizeOf(context).height * 0.2159,
                            width: MediaQuery.sizeOf(context).width,
                            titleAppBar:"Dr: ${widget.doctorModel!.firstName!}",
                            assetBackgroundImage: "assets/container_home_page/title appBar.png",
                          ),

                          ///body
                          Stack(
                            children: [
                              PositionedDirectional(
                                bottom: screenHeight * 0.0161,
                                start: screenWidth * 0.0327,
                                end: screenWidth * 0.0327,
                                top: screenHeight * 0.08,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: defaultBlackColor.withAlpha(30),
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 15,
                                      ),
                                    ],
                                    color: defaultWhiteColor,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      top: screenHeight * 0.0304,
                                      start: screenWidth * 0.0327,
                                      end: screenWidth * 0.0327,
                                      bottom: screenHeight * 0.0161,
                                    ),
                                    child: layOut(context),
                                  ),
                                ),
                              ),


                            ],
                          ),

                          ///if variable of emoji = true
                          ///show emoji container
                          if(cubit.showEmoji)
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                child: EmojiPicker(
                                  onBackspacePressed: () {

                                  },
                                  textEditingController: messageController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                                  config: Config(
                                    columns: 7, // Issue: https://github.com/flutter/flutter/issues/28894
                                    verticalSpacing: 0,
                                    horizontalSpacing: 0,
                                    gridPadding: EdgeInsets.zero,
                                    initCategory: Category.RECENT,
                                    bgColor: Color(0xFFF2F2F2),
                                    indicatorColor: Colors.blue,
                                    iconColor: Colors.grey,
                                    iconColorSelected: Colors.blue,
                                    backspaceColor: Colors.blue,
                                    skinToneDialogBgColor: Colors.white,
                                    skinToneIndicatorColor: Colors.grey,
                                    enableSkinTones: true,
                                    recentTabBehavior: RecentTabBehavior.RECENT,
                                    recentsLimit: 28,
                                    noRecents: const Text(
                                      'No Recent',
                                      style: TextStyle(fontSize: 20, color: Colors.black26),
                                      textAlign: TextAlign.center,
                                    ), // Needs to be const Widget

                                    loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
                                    tabIndicatorAnimDuration: kTabScrollDuration,
                                    categoryIcons: const CategoryIcons(),
                                    buttonMode: ButtonMode.MATERIAL,
                                  ),
                                ),
                              ),
                            ),

                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );

  }


  Widget layOut(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return Stack(
      children: [
        Column(
          children: [

            ///container that show chat between user and doctor
            Expanded(
              child: ConditionalBuilder(
                condition: allMessages.isNotEmpty,
                builder: (context) => Align(
                  alignment: Alignment.topCenter,
                  child: CustomListView.separated(
                    physics: BouncingScrollPhysics(),
                      reverse: false,
                      shrinkWrap: true,
                      controller: listScrollController,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {

                        /// if message for user return ui for user message
                        if (SignInCubit.get(context).loginDataModel!.userAccount!.id.toString() == allMessages[index].senderUserUrl) {
                          return myMessageLayout(model:allMessages[index],context: context,);
                        }
                        /// if message for doctor return ui for doctor message
                        else {
                          return receiverMessageLayout(model:allMessages[index],);
                        }

                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: allMessages.length,
                  ),
                ),
                fallback: (context) => Container(),
              ),
            ),

            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.015,
            ),

            ///input action
            Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        bottom:(cubit.showEmoji)? screenHeight * 0.28:0
                    ),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.06,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [

                          ///suffix icon for sent message or record
                          Positioned(
                              left: 0,
                              right: 0,
                              height: MediaQuery.sizeOf(context).height * 0.06,
                              child:Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child:cubit.isTextFieldWriting?
                                CircleAvatar(
                                    backgroundColor: defaultBlueAccentColor,
                                    child: IconButton(
                                      onPressed: () {
                                        showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                        cubit.sendMessage(
                                          callCameraFromDialog: false,
                                          receiverUser: widget.doctorModel!.userId.toString(),
                                          message: messageController.text,
                                          typeOfMessage: TypeOfMessage.text.name,
                                          dateTime: DateTime.now().toLocal().toString(),
                                          context: context,
                                          doctorModel: widget.doctorModel!,
                                        );
                                        messageController.text = "";
                                        cubit.onWritingOnTextField(isWriting: false);
                                      },
                                      iconSize: 24,
                                      icon: Icon(
                                        Icons.send,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    radius: 25
                                  // cubit.isSelectedMicro ? 30 : 25,
                                ):
                                SocialMediaRecorderLocal(
                                  rtl: languageApp!="ar"?true:false,
                                  recordIconBackGroundColor: defaultBlueAccentColor,
                                  counterBackGroundColor: defaultBlueAccentColor,
                                  initRecordPackageWidth: 50,
                                  maxRecordTimeInSecond: 180,
                                  sendRequestFunction: (file,time)async{
                                    File tempFile=File(file.path);
                                    String audioPath="";
                                    if(await tempFile.exists()){
                                      audioPath=tempFile.path;
                                      print("on send request"+audioPath.toString());
                                    }
                                    // String audioPath=await stopRecord();

                                    List splitTime=time.toString().split(":");
                                    print(time);
                                    DateTime date=DateTime.now();
                                    DateTime duration=DateTime(date.year,date.month,date.day,0,int.parse(splitTime[0]),int.parse(splitTime[1]));
                                    // DateTime duration=DateTime.parse(time);
                                    print("audio path"+audioPath.toString());
                                    File fileUrl=File(audioPath);
                                    var asyncFile=await fileUrl.readAsBytesSync();
                                    showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                    await cubit.uploadAudioToFireStore(
                                        file: asyncFile,
                                        path: fileUrl.path,
                                        receiverId: widget.doctorModel!.userId.toString(),
                                        context: context,
                                        durationOfAudio: duration.toString(),
                                        name: p.basename(fileUrl.path),
                                        // size: getFileSizeString(bytes: fileUrl.lengthSync()),
                                        extension: p.extension(fileUrl.path),
                                        doctorModel: widget.doctorModel!,
                                    );
                                  },
                                  backGroundColor:defaultBlueAccentColor,
                                  recordIcon:Icon(
                                    Icons.mic,
                                    color: Colors.white,
                                  ),
                                  // encode: AudioEncoderType.AAC,
                                  radius: BorderRadius.all(Radius.circular(24)),
                                ),
                              )

                          ),

                          ///Field of text and actions
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.06,
                              width: MediaQuery.sizeOf(context).width * 0.73,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: defaultBlueDarkColor,
                                  width: 2,
                                ),
                                borderRadius:BorderRadius.all(Radius.circular(22)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ///emoji icon button
                                  Container(
                                    child: IconButton(
                                      onPressed: () async{
                                        messageFocus.unfocus();
                                        FocusScope.of(context).unfocus();
                                        cubit.onChangeEmojiState();
                                      },
                                      padding: EdgeInsets.all(0),
                                      iconSize: 25,
                                      icon:Icon(Icons.emoji_emotions,color: defaultBlueAccentColor,size: 25,),
                                    ),
                                  ),

                                  ///text field of input message
                                  Expanded(
                                    child: TextField(
                                      controller: messageController,
                                      onChanged: (value) {
                                        if (!value.isEmpty) {
                                          cubit.onWritingOnTextField(isWriting: true);
                                        } else {
                                          cubit.onWritingOnTextField(isWriting: false);
                                        }
                                      },
                                      focusNode: messageFocus,
                                      onTap: () {
                                        if(cubit.showEmoji){
                                          cubit.onChangeEmojiState();
                                        }
                                      },
                                      maxLines: null,
                                      expands: true,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: S.of(context).fieldTextHintOfChatScreen),
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  ///attachment icon
                                  IconButton(
                                      onPressed: () {
                                        showDialog(context:  scaffoldKey.currentContext!, builder: (context) => containerDialogOfIcons(dialogContext: context),);
                                      },
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(
                                        Icons.attach_file,
                                        color: defaultBlueAccentColor,
                                        size: 25,
                                      )),


                                  ///camera icon
                                  IconButton(
                                      onPressed: () {
                                        pickFromCamera(context: context,callFromDialog: false);
                                      },
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(
                                        Icons.photo_camera_rounded,
                                        color: defaultBlueAccentColor,
                                        size: 25,
                                      )),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ],
    );
  }

  ///message received from doctor
  Widget receiverMessageLayout({
    required MessageModel model,
  }) {
    // listScrollController.animateTo(ScrollController(keepScrollOffset: true,initialScrollOffset: 0).position.maxScrollExtent, duration:Duration(milliseconds: 100), curve: Curves.easeOut);
    DateTime date=DateTime.parse(model.date.toString());
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        children: [
          ///text message
          if(model.typeOfMessage == TypeOfMessage.text.name)
            Container(
              child: Column(
                children: [
                  Text(model.message!),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.007,
                  ),
                  Text("${date.day==DateTime.now().day?"today":"${date.year}/${date.month}/${date.day}"}   ${date.hour}:${date.minute}"),
                ],
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(15),
                  bottomEnd: Radius.circular(15),
                  topEnd: Radius.circular(15),
                ),
              ),
            ),
          ///audio
          if(model.typeOfMessage == TypeOfMessage.audio.name)
            AudioPlayerWidget(model: model,rtl:true,),
            // Audio(model: model,rtl: true,index: index),
          ///document
          if(model.typeOfMessage == TypeOfMessage.file.name)
            FileChatWidget(model: model,rtl: true,),
          ///image
          if(model.typeOfMessage == TypeOfMessage.image.name)
            ImageChatWidget(model: model,rtl: true),
        ],
      ),
    );
  }

  ///message sent by patient
  Widget myMessageLayout({
   required MessageModel model,
   required BuildContext context,
  }) {
    // listScrollController.animateTo(ScrollController(keepScrollOffset: true,initialScrollOffset: 0).position.maxScrollExtent, duration:Duration(milliseconds: 100), curve: Curves.easeOut);
    DateTime date=DateTime.parse(model.date.toString());
    return Align(
          alignment: AlignmentDirectional.centerEnd,
          child:Column(
            children: [
                ///text message
              if(model.typeOfMessage == TypeOfMessage.text.name)
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(model.message!),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.007,
                      ),
                      Text("${date.day==DateTime.now().day?"today":"${date.year}/${date.month}/${date.day}"}   ${date.hour}:${date.minute}"),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.2),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(15),
                      bottomEnd: Radius.circular(0),
                      topEnd: Radius.circular(15),
                      bottomStart: Radius.circular(15),
                    ),
                  ),
                ),
                ///audio
              if(model.typeOfMessage == TypeOfMessage.audio.name)
                AudioPlayerWidget(model: model,rtl: false,),
              // Audio(model: model,rtl: false,index: index),
                ///document
              if(model.typeOfMessage == TypeOfMessage.file.name)
                FileChatWidget(model: model),
                ///image
              if(model.typeOfMessage == TypeOfMessage.image.name)
                ImageChatWidget(model: model),
            ],
          ),
        );
    }

  ///pick documents
  pickDocuments({
   required BuildContext context
  })async{
    showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc','docx', 'pdf', 'xl','xls','rar','zip'],
    ).then((result)async{
      if(result!=null) {
        PlatformFile platformFile = result.files.first;
        File file = File(platformFile.path!);
        ///upload document to cloud fire store
        await HomeCubit.get(context).uploadDocumentToFireStore(
          file: await file.readAsBytesSync(),
          path: platformFile.path!,
          context: context,
          receiverId: widget.doctorModel!.userId.toString(),
          size: getFileSizeString(bytes: platformFile.size)??"",
          extension: p.extension(file.path),
          name: platformFile.name,
          doctorModel: widget.doctorModel!,
        );
      }else{
        Navigator.pop(context);
        Navigator.pop(context);
      }
    })
    .catchError((onError){
      showDialog(context: context, builder:(context) => defaultDialog(context: context, text: onError.toString()));
    });
  }

  ///pick images from gallery
  pickFromGallery({
    required BuildContext context
  })async{
    showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','jpeg','png'],
    )
    // ignore: body_might_complete_normally_catch_error
    .catchError((onError){
      showDialog(context: context, builder:(context) => defaultDialog(context: context, text: onError.toString()));
    });
    if(result!=null){
      PlatformFile platformFile =result.files.first;
      File file =File(platformFile.path!);
      ///upload image to cloud fires tore
      await HomeCubit.get(context).uploadImageToFireStore(
        file: file.readAsBytesSync(),
        path: platformFile.path!,
        context: context,
        receiverId: widget.doctorModel!.userId.toString(),
        size: getFileSizeString(bytes: platformFile.size)??"",
        extension: platformFile.extension!,
        name: platformFile.name,
        doctorModel: widget.doctorModel!,
      );
    }else{
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  ///pick image from camera
  pickFromCamera({
    required BuildContext context,
    required bool callFromDialog,
  })async{
    showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
    // ignore: invalid_use_of_visible_for_testing_member
    XFile? result = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.camera,
    // ignore: body_might_complete_normally_catch_error
    ).catchError((onError){
      showDialog(context: context, builder:(context) => defaultDialog(context: context, text: onError.toString()));
    });
    if(result!=null){
      File file =File(result.path);
      ///upload image to cloud fire store
      await HomeCubit.get(context).uploadImageToFireStore(
        file: file.readAsBytesSync(),
        path: result.path,
        callCameraFromDialog: callFromDialog,
        context: context,
        receiverId: widget.doctorModel!.userId.toString(),
        size: getFileSizeString(bytes: file.lengthSync())??"",
        extension: p.extension(file.path),
        name: p.basename(file.path),
        doctorModel: widget.doctorModel!,
      );
    }else{
      Navigator.pop(context);
      if(callFromDialog)
      Navigator.pop(context);
    }
  }

  ///Icons container
  defaultIconOfAttachment({
    required BuildContext context,
    required Function() onTap,
    required IconData iconData,
    required String text,
  }) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenHeight * 0.0939,
        width: screenWidth * 0.1355,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ///Icon
            Container(
              height: screenHeight * 0.0539,
              width: screenWidth * 0.1168,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: defaultBinkColor,
                boxShadow: [
                ],
              ),
              child: Center(
                child: Icon(iconData,color: defaultBlueAccentColor),
              ),
            ),

            SizedBox(
              height: screenHeight * 0.0118,
            ),

            ///name of icon
            defaultText(
                textAlign: TextAlign.center,
                height: screenHeight * 0.0280,
                width: screenWidth * 0.1355,
                text: "${text}",
                fontSize: 14,
                boxFit: BoxFit.fitHeight,
                color: defaultBinkColor,
                context: context),

          ],
        ),
      ),
    );
  }

  ///dialog of input actions
  containerDialogOfIcons({
      required BuildContext dialogContext
  }){
      return Container(
        clipBehavior: Clip.antiAlias,
        margin:EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(dialogContext).height * 0.41,
          horizontal:  MediaQuery.sizeOf(dialogContext).width * 0.1,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Dialog(
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///document icon
              defaultIconOfAttachment(
                context: dialogContext,
                  onTap: () async{
                    pickDocuments(context: dialogContext);
                  },
                  iconData:Icons.file_copy,
                  text: "Document",
                  ),
              SizedBox(
                width: MediaQuery.sizeOf(dialogContext).width * 0.08,
              ),
              ///gallary icon
              defaultIconOfAttachment(
                context: dialogContext,
                onTap: () {
                   pickFromGallery(context: dialogContext);
                },
                iconData:Icons.photo,
                text: "Gallery",
              ),
              SizedBox(
                width: MediaQuery.sizeOf(dialogContext).width * 0.08,
              ),
              ///camera icon
              defaultIconOfAttachment(
                context: dialogContext,
                onTap: () {
                  pickFromCamera(context: dialogContext,callFromDialog: true);
                },
                iconData:Icons.photo_camera_rounded,
                text: "Camera",
              ),
            ],
          ),
          clipBehavior: Clip.none,
          insetPadding: EdgeInsets.all(0),
          backgroundColor: Colors.white,
          elevation: 0,
          insetAnimationDuration: Duration(seconds: 2),
          insetAnimationCurve: Curves.fastLinearToSlowEaseIn,
        ),
      );

  }

  ///check if permission of storage is granted or not
  bool isPermission=false;
  checkPermission()async{
    var permission=await _isStoragePermission();
    if(permission){
      setState((){
        isPermission=true;
      });
    }
  }

  ///check if permission of storage is granted or not
  ///and request permission
  _isStoragePermission()async{
    var isStorage=await Permission.storage.status;
    if(!isStorage.isGranted){
      await Permission.storage.request();
      if(!isStorage.isGranted){
        return false;
      }else{
        return true;
      }
    }else{
      return true;
    }
  }



}

  ///get file size from bytes
  String? getFileSizeString({required int bytes, int decimals = 0}) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  ///types of media that user can contact through
  enum TypeOfMessage{
    audio,
    text,
    image,
    file,
  }
