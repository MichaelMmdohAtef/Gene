import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/ticket_model.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../generated/l10n.dart';

// ignore: must_be_immutable
class OpenTicketScreen extends StatelessWidget {
  OpenTicketScreen();

  late double screenHeight;
  late double screenWidth;
  TypesModel? typeOfModel;

  ///title controller that control with title of problem written by user
  final TextEditingController titleController = TextEditingController();

  ///message controller that control with message description written by user
  final TextEditingController messageController = TextEditingController();

  ///form key controller that make validate on textField if null or not
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getTypesOfTickets();
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          screenHeight = MediaQuery.sizeOf(context).height;
          screenWidth = MediaQuery.sizeOf(context).width;
          return Scaffold(
            appBar: statusBar(),
            body: Stack(
              children: [

                ///single child scroll view
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: screenHeight * 1.16),
                    child: Stack(
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

                        ///map image
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.4751,
                          width: MediaQuery.sizeOf(context).width,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(50),
                                bottomStart: Radius.circular(50),
                              )),
                          child: Image.asset("assets/svgIcons/mapImage.png",
                              fit: BoxFit.cover),
                        ),

                        ///body
                        PositionedDirectional(
                          start: screenWidth * 0.032710,
                          end: screenWidth * 0.032710,
                          top: screenHeight * 0.37904,
                          bottom: screenHeight * 0.005,
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              height:screenHeight * 0.760,
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
                                  top: screenHeight * 0.0172,
                                  bottom: screenHeight * 0.0280,
                                  start: screenWidth * 0.0350,
                                  end: screenWidth * 0.0350,
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    children: [

                                      ///title container
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          ///title (text)
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.035,
                                              ),
                                              defaultText(
                                                  height: screenHeight * 0.028,
                                                  text: S.of(context).titleText,
                                                  fontSize: 20,
                                                  boxFit: BoxFit.fitHeight,
                                                  color: defaultGreyColor,
                                                  context: context),
                                              SizedBox(
                                                width: screenWidth * 0.00755,
                                              ),
                                              Container(
                                                // width: screenWidth * 0.0210,
                                                height: screenHeight * 0.028,
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text(
                                                    "*",
                                                    style: TextStyle(
                                                      color: Color(0xffFF0000),
                                                      fontSize: 20,
                                                      fontFamily: "Roboto",
                                                      height: 1.3,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.0175,
                                          ),
                                          ///field that contains on title of problem
                                          defaultTextFormField(
                                              context: context,
                                              // height: screenHeight * 0.06831,
                                              controller: titleController,
                                              hint: S.of(context).hintTitleText,
                                              keyboardType: TextInputType.text,
                                              onValidate: (value) {
                                                if (value!.isEmpty) {
                                                  return S.of(context).validatorTitleText;
                                                }
                                                return null;
                                              }),

                                        ],
                                      ),

                                      SizedBox(
                                        height: screenHeight * 0.0248,
                                      ),

                                      ///problems container
                                      Column(
                                        children: [

                                          ///problem title (text)
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.035,
                                              ),
                                              defaultText(
                                                height: screenHeight * 0.032,
                                                text: S.of(context).problemText,
                                                fontSize: 20,
                                                boxFit: BoxFit.fitHeight,
                                                color: defaultGreyColor,
                                                context: context,
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.00755,
                                              ),

                                              Container(
                                                // width: screenWidth * 0.0210,
                                                height: screenHeight * 0.028,
                                                child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text(
                                                    "*",
                                                    style: TextStyle(
                                                      color: Color(0xffFF0000),
                                                      fontSize: 20,
                                                      fontFamily: "Roboto",
                                                      height: 1.3,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.0175,
                                          ),

                                          ///popup menu that view types of problems in app
                                          Container(
                                            child: PopupMenuButton(
                                              onOpened: () {
                                                // showDialog(context: context, builder:(context) =>  defaultCircleProgressBar());
                                                // HomeCubit.get(context).getTypesOfTickets().then((value) {
                                                //   Navigator.pop(context);
                                                cubit.onOpenedDownListVaccination(opened: true);
                                              },
                                              onCanceled: () {
                                                cubit.onOpenedDownListVaccination(opened: false);
                                              },
                                              onSelected: (index) async {
                                                typeOfModel=cubit.onChangeTypeOfProblem(index: index);
                                                cubit.onOpenedDownListVaccination(opened: false);
                                              },
                                              color: defaultWhiteColor,
                                              elevation: 0,
                                              splashRadius: 15,
                                              constraints:BoxConstraints(minHeight: screenHeight * 0.2010,maxWidth: screenWidth * 0.72),
                                              offset: Offset(0, screenHeight * 0.04),
                                              itemBuilder: (context) =>
                                                  List.generate(
                                                      cubit.allTypesOfTickets.length,
                                                          (index) => PopupMenuItem(
                                                        child: Container(
                                                          height: screenHeight * 0.0259,
                                                          child: Row(
                                                            children: [
                                                              Expanded(child:defaultText(
                                                                  text: cubit.allTypesOfTickets[index].type!,
                                                                  height: screenHeight * 0.02591,
                                                                  color: Color(0xff707070),
                                                                  fontSize: 18,
                                                                  textHeight: 1.333,
                                                                  fontFamily: "Roboto",
                                                                  boxFit: BoxFit.fitHeight,
                                                                  context:context), ),
                                                              BlocConsumer<HomeCubit,HomeStates>(
                                                                builder: (context, state) {
                                                                  return Checkbox(
                                                                    activeColor:defaultBlueAccentColor,
                                                                    focusColor: defaultBlueAccentColor,
                                                                    shape: CircleBorder(),
                                                                    tristate: false,
                                                                    value:cubit.allTypesOfTickets[index].check ?? false,
                                                                    onChanged: (check){
                                                                      typeOfModel=cubit.onChangeTypeOfProblem(index: index);
                                                                    },
                                                                  );
                                                                },
                                                                listener: (context, state) {

                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        value: index,
                                                      )),
                                              child: Container(
                                                height: screenHeight * 0.0583,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(15)),
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                        defaultBlueAccentColor)),
                                                child: Padding(
                                                  padding:
                                                  EdgeInsetsDirectional.only(
                                                    start: screenWidth * 0.0373,
                                                    end: screenWidth * 0.0373,
                                                    top: screenHeight * 0.0151,
                                                    bottom: screenHeight * 0.0172,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      defaultText(
                                                          text:typeOfModel!=null?typeOfModel!.type!: S.of(context).selectProblemText,
                                                          height: screenHeight * 0.02591,
                                                          color: Color(0xff707070),
                                                          fontSize: 18,
                                                          textHeight: 1.333,
                                                          fontFamily: "Roboto",
                                                          boxFit: BoxFit.fitHeight,
                                                          context: context),
                                                      cubit.openedDownListVaccination ==
                                                          false
                                                          ? Icon(Icons
                                                          .arrow_drop_down_sharp)
                                                          : Icon(Icons
                                                          .arrow_drop_up),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padding: EdgeInsets.all(0),
                                            ),
                                            width: screenWidth,
                                            // height: screenHeight * 0.0583,
                                          ),

                                        ],
                                      ),

                                      SizedBox(
                                        height: screenHeight * 0.0248,
                                      ),

                                      ///message container
                                      Container(
                                        alignment: Alignment.center,
                                        width: screenWidth,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            ///message title (text)
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: screenWidth * 0.035,
                                                ),
                                                defaultText(
                                                    height: screenHeight * 0.032,
                                                    text: S.of(context).messageText,
                                                    fontSize: 20,
                                                    color: defaultGreyColor,
                                                    context: context),
                                                SizedBox(
                                                  width: screenWidth * 0.00755,
                                                ),
                                                Container(
                                                  height: screenHeight * 0.028,
                                                  child: FittedBox(
                                                    fit: BoxFit.cover,
                                                    child: Text(
                                                      "*",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(0xffFF0000),
                                                        fontSize: 20,
                                                        fontFamily: "Roboto",
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.0175,
                                            ),
                                            ///field that contains on message of user
                                            defaultTextFormField(
                                                height: screenHeight * 0.3,
                                                context: context,
                                                maxLength: 120,
                                                isExpanded: true,
                                                controller: messageController,
                                                hint: S.of(context).hintMessageText,
                                                keyboardType: TextInputType.emailAddress,
                                                onValidate: (value) {
                                                  if (value!.isEmpty) {
                                                    return S.of(context).validatorMessageText;
                                                  }
                                                  return null;
                                                })
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: screenHeight * 0.0248,
                                      ),

                                      ///send button
                                      defaultMaterialButton(
                                          height: screenHeight * 0.0626,
                                          context: context,
                                          backgroundColor: defaultBlueAccentColor,
                                          textColor: defaultWhiteColor,
                                          text: S.of(context).sendText,
                                          onPress: () async{
                                            if (formKey.currentState!.validate()) {
                                              if(typeOfModel!=null){
                                                if(userTokenApi!=null){
                                                  bool hasInternet=await NetworkConnection.getConnectivity();
                                                  if(hasInternet){
                                                    showDialog(context: context, builder:(context) =>defaultCircleProgressBar(),);
                                                    cubit.createTicket(
                                                        title: titleController.text,
                                                        type:typeOfModel!.type.toString(),
                                                        content: messageController.text).then((value)async{
                                                      Navigator.pop(context);
                                                      showDialog(context: context, builder:(context) => defaultDialog(context: context,text:S.of(context).ticketAddedSuccessfully )).whenComplete(() {
                                                        Navigator.pop(context);
                                                        typeOfModel=null;
                                                        messageController.text="";
                                                        titleController.text="";
                                                      });
                                                    });
                                                  }else{
                                                    showSnackBar(context: context, text: S.current.failedConnection);
                                                  }
                                                  }
                                                  else{
                                                  navigateAndPush(context, SignInScreen(fromUser: true,widget: OpenTicketScreen(),));
                                                }
                                              }
                                              else{
                                                showDialog(context: context, builder: (context) =>
                                                defaultDialog(context: context, text: S.of(context).selectTypeOfProblemText));
                                              }
                                            }
                                          }
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                ///appbar
                appBarWidget(
                  context: context,
                  onPressLeading: () {
                    Navigator.pop(context);
                  },
                  height: MediaQuery.sizeOf(context).height * 0.1058,
                  width: MediaQuery.sizeOf(context).width,
                  titleAppBar: S.of(context).openTicketTitle,
                  assetSVGIcon: "assets/svgIcons/openTicketSvg.svg",
                  assetBackgroundImage:
                  "assets/container_home_page/title appBar.png",
                ),

              ],
            ),
          );
        },
      );
    });
  }

}
