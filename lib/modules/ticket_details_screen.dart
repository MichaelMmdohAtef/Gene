import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/ticket_model.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';

import '../generated/l10n.dart';

// ignore: must_be_immutable
class TicketDetailsScreen extends StatelessWidget {
  TicketDetailsScreen({required this.idOfTicketModel});
  TicketModel? ticketModel=null;
  int? idOfTicketModel;

  DateTime? date;

  ///message controller that control message text written by user
  TextEditingController messageController=TextEditingController();

  late double screenHeight;
  late double screenWidth;
  @override
  Widget build(BuildContext context) {

    return Builder(
      builder:(context) {
        ticketModel=null;
        HomeCubit.get(context).getMyTicket(idOfTicket: idOfTicketModel!);
        ticketModel=HomeCubit.get(context).myTicketModel;
        date=DateTime.parse(ticketModel!.createdAt!);
       return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            screenHeight = MediaQuery.sizeOf(context).height;
            screenWidth = MediaQuery.sizeOf(context).width;
            ///scaffold
            return Scaffold(
              appBar: statusBar(),
              body: Stack(
                children: [

                  /// first background
                  Positioned(
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.8218,
                    width: MediaQuery
                        .sizeOf(context)
                        .width,
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
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.8218,
                    width: MediaQuery
                        .sizeOf(context)
                        .width,
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
                    top: MediaQuery
                        .sizeOf(context)
                        .height * 0.8207,
                    left: 0,
                  ),

                  ///appbar
                  appBarWidget(
                    context: context,
                    onPressLeading: () {
                      Navigator.pop(context);
                    },
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.2159,
                    width: MediaQuery
                        .sizeOf(context)
                        .width,
                    titleAppBar: S.of(context).titleTicketDetails,
                    assetBackgroundImage: "assets/container_home_page/title appBar.png",
                  ),

                  ///container of body
                  Stack(
                    children: [
                      PositionedDirectional(
                        height: screenHeight * 0.82,
                        start: screenWidth * 0.0327,
                        end: screenWidth * 0.0327,
                        top: screenHeight * 0.07,
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
                                top: screenHeight * 0.02,
                                start: screenWidth * 0.0677,
                                end: screenWidth * 0.0677,
                              ),

                              child: ConditionalBuilder(
                                condition:cubit.myTicketModel != null,
                                builder: (context) {
                                  ///single child scroll view
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        ///container that content on my message problem
                                        myMessageLayout(context: context),

                                        SizedBox(
                                          height: screenHeight * 0.02,
                                        ),

                                        ///list of comments
                                        ///container that content on my reply or reply of support team problem
                                        if(cubit.myTicketModel!.comments!.length!=0)
                                          ListView.separated(
                                              shrinkWrap: true,
                                              physics: BouncingScrollPhysics(),
                                              padding: EdgeInsetsDirectional.all(0),
                                              itemBuilder:(context, index) => cubit.myTicketModel!.comments![index].userId=="7"?receiverReplyMessageLayout(context: context, commentModel:ticketModel!.comments![index]):myReplyMessageLayout(context: context, commentModel: cubit.myTicketModel!.comments![index]),
                                              separatorBuilder:(context, index) =>SizedBox(
                                                height: screenHeight * 0.02,
                                              ),
                                              itemCount: cubit.myTicketModel!.comments!.length
                                          ),

                                        SizedBox(
                                          height: screenHeight * 0.0304,
                                        ),

                                      ],
                                    ),
                                  );
                                },

                                fallback: (context) {
                                  return Container();
                                },)

                          ),
                        ),
                      ),
                    ],
                  ),

                  ///field of message & send button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [

                          ///message text field
                          Expanded(
                            child: defaultTextFormField(
                                context: context,
                                height: screenHeight * 0.06831,
                                controller: messageController,
                                hint: S.of(context).hintFieldTextTicketsDetails,
                                keyboardType: TextInputType.text,
                                onChange: (p0) {
                                  messageController.text=p0.toString();
                                },
                                onValidate: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).validatorFieldTextTicketsDetails;
                                  }
                                  return null;
                                }),
                            flex: 3,
                          ),

                          SizedBox(
                            width: screenWidth * 0.0116,
                          ),

                          ///post button
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                bottom: 8,
                              ),
                              child: defaultMaterialButton(
                                height: screenHeight * 0.06031,
                                context: context,
                                backgroundColor: defaultBlueAccentColor,
                                textColor: defaultWhiteColor,
                                text: S.of(context).postButtonTicketsDetails,
                                onPress: () async {
                                  bool hasInternet=await NetworkConnection.getConnectivity();
                                  if(messageController.text!=""){
                                    if(hasInternet){
                                      showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                      await cubit.createComment(
                                          comment: messageController.text,
                                          ticketId: ticketModel!.id!).then((
                                          value) async{
                                        await cubit.getAllTickets().then((value){
                                          Navigator.pop(context);
                                          messageController.text = "";
                                          showDialog(context: context, builder: (context) => defaultDialog(context: context, text: S.of(context).messageSentSuccessfully,)).whenComplete((){
                                            navigateAndReplace(context: context, widget:TicketDetailsScreen(idOfTicketModel: idOfTicketModel));
                                          });
                                        });
                                      });
                                    }
                                    else{
                                      showSnackBar(context: context, text: S.current.failedConnection);
                                    }
                                  }
                                  else{
                                    showDialog(context: context, builder:(context) => defaultDialog(context: context,
                                        text: S.of(context).validatorFieldTextTicketsDetails),);
                                  }
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ///container that content on reply of support team
  Widget receiverReplyMessageLayout({
    required BuildContext context,
    required CommentModel commentModel,
  }) {
    DateTime dateTime=DateTime.parse(commentModel.createdAt!);
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(12),
            bottomEnd: Radius.circular(5),
            topEnd: Radius.circular(5),
          ),
        ),
        child:Column(
          children: [

            Container(
              height:screenHeight * 0.03,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:defaultText(
                        text: S.of(context).adminText,
                        color: Color(0xff434343),
                        fontSize: 18,
                        fontFamily: "Roboto",
                        textAlign: TextAlign.start,
                        textHeight: 1.333,
                        alignment: AlignmentDirectional.bottomStart,

                        boxFit: BoxFit.contain,
                        height:screenHeight * 0.03,
                        context: context), ),
                  Expanded(
                    child:defaultText(
                        text:"${dateTime.month.toString()}/${dateTime.day.toString()}",
                        // "${ticketModel!.createdAt!}",
                        color: defaultBlueDarkColor.withOpacity(0.85),
                        fontSize: 12,
                        alignment: AlignmentDirectional.bottomEnd,
                        fontFamily: "Roboto",
                        width: screenWidth,
                        textAlign: TextAlign.start,
                        textHeight: 1.333,
                        height:screenHeight * 0.017,
                        context: context), ),
                ] ,
              ),
            ),

            SizedBox(
              height: screenHeight * 0.0194,
            ),

            defaultText(
                text: "${S.of(context).messageText} ${commentModel.content!}",
                color: Color(0xff434343),
                fontSize: 18,
                fontFamily: "Roboto",
                textAlign: TextAlign.start,
                textHeight: 1.333,
                boxFit: BoxFit.contain,
                height:screenHeight * 0.022,
                context: context,
            ),

            // Text(cubit.userModel!.fullName!)
          ],
        ),
      ),
    );
  }

  ///ui container that content on my message problem
  Widget myMessageLayout({
    required BuildContext context,
  }) {
    var cubit=SignInCubit.get(context);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(12),
            // bottomEnd: Radius.circular(5),
            topEnd: Radius.circular(5),
            bottomStart: Radius.circular(5),
          ),
        ),
        child:Column(
          children: [

            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height:screenHeight * 0.03,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:defaultText(
                          text: cubit.userModel!.fullName!,
                          color: Color(0xff434343),
                          fontSize: 18,
                          fontFamily: "Roboto",
                          textAlign: TextAlign.start,
                          textHeight: 1.333,
                          alignment: AlignmentDirectional.bottomStart,
                          boxFit: BoxFit.contain,
                          height:screenHeight * 0.03,
                          context: context), ),
                    Expanded(
                      child:defaultText(
                          text:"${date!.month.toString()}/${date!.day.toString()}",
                          // "${ticketModel!.createdAt!}",
                          color: defaultBlueDarkColor.withOpacity(0.85),
                          fontSize: 12,
                          alignment: AlignmentDirectional.bottomEnd,
                          fontFamily: "Roboto",
                          width: screenWidth,
                          textAlign: TextAlign.start,
                          textHeight: 1.333,
                          height:screenHeight * 0.017,
                          context: context),),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0194,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                    text: "${S.of(context).titleText} ${ticketModel!.title!}",
                    color: Color(0xff434343),
                    fontSize: 18,
                    fontFamily: "Roboto",
                    textAlign: TextAlign.start,
                    textHeight: 1.333,
                    boxFit: BoxFit.contain,
                    height:screenHeight * 0.028,
                    context: context,
                ),
                SizedBox(
                  height: screenHeight * 0.0194,
                ),
                defaultText(text: "${S.of(context).supTitleContainerMyTicketsScreen} ${ticketModel!.type!}",
                    color: defaultBlueDarkColor.withOpacity(0.85),
                    fontSize: 12,
                    fontFamily: "Roboto",
                    width: screenWidth,
                    textAlign: TextAlign.start,
                    textHeight: 1.333,
                    height:screenHeight * 0.028,
                    context: context),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.0194,
            ),
            defaultText(
                text: "${S.of(context).messageText} ${ticketModel!.content!}",
                color: Color(0xff434343),
                fontSize: 18,
                fontFamily: "Roboto",
                textAlign: TextAlign.start,
                textHeight: 1.333,
                boxFit: BoxFit.contain,
                height:screenHeight * 0.022,
                context: context),
            // Text(cubit.userModel!.fullName!)
          ],
        ),
      ),
    );
  }

  ///container that content on my reply
  Widget myReplyMessageLayout({
    required BuildContext context,
    required CommentModel commentModel,
  }) {
    var cubit=SignInCubit.get(context);
    DateTime dateTime=DateTime.parse(commentModel.createdAt!);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(12),
            // bottomEnd: Radius.circular(5),
            topEnd: Radius.circular(5),
            bottomStart: Radius.circular(5),
          ),
        ),
        child:Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height:screenHeight * 0.03,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:defaultText(
                          text: cubit.userModel!.fullName!,
                          color: Color(0xff434343),
                          fontSize: 18,
                          fontFamily: "Roboto",
                          textAlign: TextAlign.start,
                          textHeight: 1.333,
                          alignment: AlignmentDirectional.bottomStart,

                          boxFit: BoxFit.contain,
                          height:screenHeight * 0.03,
                          context: context), ),
                    Expanded(
                      child:defaultText(
                          text:"${dateTime.month.toString()}/${dateTime.day.toString()}",
                          // "${ticketModel!.createdAt!}",
                          color: defaultBlueDarkColor.withOpacity(0.85),
                          fontSize: 12,
                          alignment: AlignmentDirectional.bottomEnd,
                          fontFamily: "Roboto",
                          width: screenWidth,
                          textAlign: TextAlign.start,
                          textHeight: 1.333,
                          height:screenHeight * 0.017,
                          context: context), ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.0194,
            ),
            defaultText(
                text: "${S.of(context).messageText} ${commentModel.content!}",
                color: Color(0xff434343),
                fontSize: 18,
                fontFamily: "Roboto",
                textAlign: TextAlign.start,
                textHeight: 1.333,
                boxFit: BoxFit.contain,
                height:screenHeight * 0.022,
                context: context),
            // Text(cubit.userModel!.fullName!)
          ],
        ),
      ),
    );
  }

}


