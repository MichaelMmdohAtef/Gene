import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Gene/library/slider_notification/slider_notification.dart';
import 'package:Gene/modules/Booking_screen.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/modules/Sign_In/cubit/states.dart';
import 'package:Gene/modules/Sign_In/sign_in_screen.dart';
import 'package:Gene/modules/my_profile.dart';
import 'package:Gene/modules/search_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/modules/doctor_screen.dart';
import 'package:Gene/modules/favourites_screen.dart';
import 'package:Gene/modules/gene_clinics_screen.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.initScroll=true});
  bool initScroll;
  @override
  State<HomeScreen> createState() => _HomeScreenState(initScroll: this.initScroll);
}

class _HomeScreenState extends State<HomeScreen> {
  ///controller that control doctors that must view in search screen
  TextEditingController searchController=TextEditingController();

  ///controller that control scroll bar in Home Screen
  ScrollController? scrollController;
  bool initScroll;
  _HomeScreenState({required bool this.initScroll});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController=ScrollController(initialScrollOffset: initScroll?0:HomeCubit.get(context).offSitOfHomeScreen);
    ///initialize the listener of Scroll Controller
    // checkScrollUp(context);
  }

  @override
  Widget build(BuildContext context) {
     double screenHeight =MediaQuery.sizeOf(context).height;
     double screenWidth =MediaQuery.sizeOf(context).width;
    return Builder(
      builder: (context) {
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            ///get object from cubit
            var cubit = HomeCubit.get(context);

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: statusBar(),
                ///scroll up button
                floatingActionButton: cubit.showBackToTopButton == false
                    ? null
                    :Padding(
                    padding:  EdgeInsetsDirectional.only(
                      bottom:screenHeight*0.07,
                      end:screenWidth*0.0314 ,
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: defaultBlueDarkColor,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(
                          Icons.arrow_upward,
                        ),
                        color: Colors.white,
                        ///fun to scroll screen to top
                        onPressed: scrollToTop,
                      ),
                    ),
                  ),

                  ///body
                  body: Stack(
                    children: [
                      ///app bar and home page
                      SingleChildScrollView(
                        controller: scrollController,
                        physics: ScrollPhysics(),
                        child: Stack(
                          children: [
                            /// body
                            Stack(
                              children: [

                                ///first background
                                Positioned(
                                  height: MediaQuery.sizeOf(context).height * 0.8218,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: const Image(
                                      image: AssetImage(
                                        "assets/Background/App Background-2.png",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  top: -MediaQuery.sizeOf(context).height * 0.20518,
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
                                  top: MediaQuery.sizeOf(context).height * 0.6166,
                                  left: 0,
                                ),

                                ///third background
                                Positioned(
                                  height: MediaQuery.sizeOf(context).height * 0.8218,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: const Image(
                                      image: AssetImage(
                                        "assets/Background/App Background-1.png",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  top: MediaQuery.sizeOf(context).height * 1.41789,
                                  left: 0,
                                ),

                                ///body
                                SafeArea(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      top: MediaQuery.sizeOf(context).height * 0.2958,
                                      end: MediaQuery.sizeOf(context).width * 0.0327,
                                      start: MediaQuery.sizeOf(context).width * 0.0327,
                                    ),
                                    child: Column(
                                      children: [

                                        ///carousel slider (header image for app)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.sizeOf(context).width * 0.007),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            height: MediaQuery.sizeOf(context).height *
                                                0.3488,
                                            width: MediaQuery.sizeOf(context).width,
                                            child: Column(
                                              children: [
                                                ///image view
                                                Container(
                                                  height: MediaQuery.sizeOf(context).height * 0.2602,
                                                  width: MediaQuery.sizeOf(context).width,
                                                  color: Colors.transparent,
                                                  child: Stack(
                                                    children: [
                                                      ConstrainedBox(
                                                        child: CarouselSlider(
                                                          items:languageApp=="ar"?
                                                          bigMedicalImageAR.map((element) {
                                                            return Image.asset(
                                                              element.toString(),
                                                              fit: BoxFit.cover,
                                                              width: MediaQuery.sizeOf(context).width,
                                                            );
                                                          }).toList()
                                                              :bigMedicalImageEN.map((element) {
                                                            return Image.asset(
                                                              element.toString(),
                                                              fit: BoxFit.cover,
                                                              width: MediaQuery.sizeOf(context).width,
                                                            );
                                                          }).toList(),
                                                          options: CarouselOptions(
                                                            scrollPhysics: const BouncingScrollPhysics(),
                                                            padEnds: false,
                                                            aspectRatio: 2,
                                                            height: double.infinity,
                                                            autoPlay: true,
                                                            autoPlayInterval: Duration(seconds: 3),
                                                            // autoPlayAnimationDuration: Duration(seconds: 3),
                                                            enlargeCenterPage: true,
                                                            scrollDirection: Axis.horizontal,
                                                            enableInfiniteScroll:true,
                                                            initialPage: cubit.indexImage,
                                                            onPageChanged: (index, reason) async{
                                                              await cubit.onChangeCarouselImage(index);
                                                            },
                                                            reverse: false,
                                                            viewportFraction: 1,
                                                          ),
                                                          carouselController: cubit.pageLargeCarouselController,
                                                        ),
                                                        constraints: BoxConstraints(
                                                          minHeight: MediaQuery.sizeOf(context).height * 0.2602,
                                                          maxHeight: MediaQuery.sizeOf(context).height * 0.2602,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom: MediaQuery.sizeOf(context).height * 0.0075),
                                                        child: Align(
                                                          alignment:
                                                          Alignment.bottomCenter,
                                                          child:
                                                          AnimatedSmoothIndicator(
                                                            activeIndex: cubit.indexImage,
                                                            count: smallMedicalImageEN.length,
                                                            effect: const WormEffect(
                                                              dotColor: Color(0xff67B9C5),
                                                              activeDotColor: Color(0xff84EEFF),
                                                            ),
                                                            axisDirection:
                                                            Axis.horizontal,
                                                            onDotClicked: (index) {
                                                              cubit.onChangeCarouselImage(index);
                                                              cubit.onChangeImageIndex(index);
                                                            },
                                                            textDirection:
                                                            TextDirection.ltr,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ///slider of image
                                                Expanded(
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:MediaQuery.sizeOf(context)
                                                              .width *
                                                              0.0280),
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        height:
                                                        MediaQuery.sizeOf(context)
                                                            .height *
                                                            0.0539,
                                                        width:
                                                        MediaQuery.sizeOf(context)
                                                            .width,
                                                        child: Row(
                                                          children: [
                                                            ///back button to previous image
                                                            IconButton(
                                                                onPressed: () async{
                                                                  cubit.onNavigateToPreviousCarouselImage();
                                                                },
                                                                iconSize: 25,
                                                                alignment:
                                                                Alignment.center,
                                                                padding:
                                                                const EdgeInsets.all(0),
                                                                color:
                                                                const Color(0xff68BBC7),
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_back_ios_rounded,
                                                                  weight: 5,
                                                                  shadows: [
                                                                    Shadow(
                                                                      color: Color(
                                                                          0xff000000)
                                                                          .withAlpha(
                                                                          8),
                                                                      blurRadius: 25,
                                                                      offset: Offset(
                                                                          0, 0),
                                                                    ),
                                                                  ],
                                                                )),
                                                            SizedBox(
                                                              width: MediaQuery.sizeOf(
                                                                  context)
                                                                  .width *
                                                                  0.0016,
                                                            ),
                                                            ///slider of images
                                                            Expanded(
                                                                child: ConstrainedBox(
                                                                  constraints: BoxConstraints(
                                                                    minHeight: MediaQuery.sizeOf(context).height * 0.0539,
                                                                    maxHeight: MediaQuery.sizeOf(context).height * 0.0539,
                                                                  ),
                                                                  child: CarouselSlider(
                                                                    items:languageApp=="ar"?
                                                                    smallMedicalImageAR.map((element) {
                                                                      return InkWell(
                                                                        onTap: (){
                                                                          cubit.onChangeCarouselImage(smallMedicalImageEN.indexOf(element));
                                                                        },
                                                                        child: Container(
                                                                          width: MediaQuery.sizeOf(context).width * 0.1168,
                                                                          height: MediaQuery.sizeOf(context).height * 0.0539,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: defaultBlackColor.withAlpha(8),
                                                                                  blurRadius: 25,
                                                                                  blurStyle: BlurStyle.outer,
                                                                                )
                                                                              ],
                                                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                                                          child:Image.asset(
                                                                            element.toString(),
                                                                            fit: BoxFit.cover,
                                                                            width: MediaQuery.sizeOf(context).width,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).toList()
                                                                    :
                                                                    smallMedicalImageEN.map((element) {
                                                                      return InkWell(
                                                                        onTap: (){
                                                                          cubit.onChangeCarouselImage(smallMedicalImageEN.indexOf(element));
                                                                        },
                                                                        child: Container(
                                                                          width: MediaQuery.sizeOf(context).width * 0.1168,
                                                                          height: MediaQuery.sizeOf(context).height * 0.0539,
                                                                          clipBehavior: Clip.antiAlias,
                                                                          decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: defaultBlackColor.withAlpha(8),
                                                                                  blurRadius: 25,
                                                                                  blurStyle: BlurStyle.outer,
                                                                                )
                                                                              ],
                                                                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                                                                          child:Image.asset(
                                                                            element.toString(),
                                                                            fit: BoxFit.cover,
                                                                            width: MediaQuery.sizeOf(context).width,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                    options:CarouselOptions(
                                                                      scrollPhysics:const BouncingScrollPhysics(),
                                                                      padEnds: true,
                                                                      aspectRatio:2,
                                                                      // height: MediaQuery.sizeOf(context).height * 0.0539,
                                                                      autoPlay: false,
                                                                      enlargeCenterPage: true,
                                                                      scrollDirection: Axis.horizontal,
                                                                      enableInfiniteScroll:true,
                                                                      reverse: false,
                                                                      initialPage:cubit.indexImage,
                                                                      onPageChanged:(index, reason) async{
                                                                        cubit.onChangeCarouselImage(index);
                                                                      },
                                                                      pauseAutoPlayInFiniteScroll: true,
                                                                      pauseAutoPlayOnManualNavigate: true,
                                                                      viewportFraction: 0.2,
                                                                    ),
                                                                    carouselController: cubit.pageController,
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              width: MediaQuery.sizeOf(
                                                                  context)
                                                                  .width *
                                                                  0.0016,
                                                            ),
                                                            ///next button to next image
                                                            IconButton(
                                                                onPressed: () {
                                                                  cubit.onNavigateToNextCarouselImage();
                                                                },
                                                                alignment: Alignment.center,
                                                                iconSize: 25,
                                                                padding:
                                                                EdgeInsets.all(0),
                                                                color:
                                                                Color(0xff68BBC7),
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_outlined,
                                                                  weight: 5,
                                                                  shadows: [
                                                                    Shadow(
                                                                      color: Color(
                                                                          0xff000000)
                                                                          .withAlpha(
                                                                          8),
                                                                      blurRadius: 25,
                                                                      offset: Offset(
                                                                          0, 0),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: MediaQuery.sizeOf(context).height * 0.0215,
                                        ),

                                        ///Gene clinics
                                        Container(
                                          height: MediaQuery.sizeOf(context).height * 0.623,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/container_home_page/outpatient Clinic.png"),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                              start: MediaQuery.sizeOf(context).width *
                                                  0.0443,
                                              end: MediaQuery.sizeOf(context).width *
                                                  0.0443,
                                            ),
                                            child: Column(
                                              children: [
                                                ///title
                                                Container(
                                                  width: MediaQuery.sizeOf(context).width,
                                                  height: MediaQuery.sizeOf(context).height * 0.0820,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            ///title
                                                            defaultText(text:S.of(context).titleClinicsPage,
                                                                color: defaultWhiteColor,
                                                                height: MediaQuery.sizeOf(context).height * 0.0490,
                                                                width: MediaQuery.sizeOf(context).width * 0.514,
                                                                textAlign: TextAlign.start,
                                                                textHeight: 1.1428,
                                                                alignment: AlignmentDirectional.centerStart,
                                                                fontFamily: "Arial",
                                                                fontSize: 24,
                                                                context: context),
                                                            ///more button that navigate to clinics screen
                                                            InkWell(
                                                              onTap: () async{
                                                                bool hasInternet=await NetworkConnection.getConnectivity();
                                                                if(hasInternet){
                                                                  showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                                                  await HomeCubit.get(context).getClinicsData().then((value){
                                                                    navigateAndReplace(context: context,widget:GeneClinicsScreen());
                                                                  });
                                                                }else{
                                                                  navigateAndPush(context,GeneClinicsScreen());
                                                                  showSnackBar(context: context, text: S.current.failedConnection);
                                                                }
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  defaultText(
                                                                      height: MediaQuery.sizeOf(context).height * 0.0390,
                                                                      text: S.current.moreToNavigate,
                                                                      fontSize: 18,
                                                                      fontFamily: "Arial",
                                                                      boxFit: BoxFit.fitHeight,
                                                                      textHeight: 1.1666,
                                                                      color: defaultWhiteColor,
                                                                      context: context),
                                                                  SizedBox(
                                                                    width: MediaQuery.sizeOf(context).width * 0.0063,
                                                                  ),

                                                                  Container(
                                                                    height: MediaQuery.sizeOf(context).height * 0.0290,
                                                                    child: FittedBox(
                                                                      fit: BoxFit.fitHeight,
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_forward,
                                                                        size: 16,
                                                                        color:
                                                                        defaultWhiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: AlignmentDirectional.bottomCenter,
                                                        child: Container(
                                                          height: 1,
                                                          width: MediaQuery.sizeOf(context).width,
                                                          color: Color(
                                                            0xffFFFFFF,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.0157,
                                                ),
                                                ///container view for clinics in Gene
                                                cubit.clinics.length != 0?
                                                Expanded(
                                                  child: GridView.count(
                                                    crossAxisCount: 3,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.all(5),
                                                    physics: NeverScrollableScrollPhysics(),
                                                    children: cubit
                                                        .clinics.length >=
                                                        9
                                                        ? List.generate(
                                                        9,
                                                            (index) => itemOfClinics(
                                                            context: context,
                                                            model: cubit.clinics[index]
                                                        ))
                                                        : List.generate(
                                                        cubit.clinics.length,
                                                            (index) => itemOfClinics(
                                                            context: context,
                                                            model: cubit.clinics[index]
                                                        )),
                                                    mainAxisSpacing: MediaQuery.sizeOf(context).height * 0.0179,
                                                    crossAxisSpacing:MediaQuery.sizeOf(context).width *  0.0233,
                                                    childAspectRatio: 0.97/1.2048,
                                                  ),
                                                )
                                                :Container(),
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: MediaQuery.sizeOf(context).height * 0.0215,
                                        ),

                                        ///Gene Doctors
                                        Container(
                                          height: MediaQuery.sizeOf(context).height * 0.718,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/container_home_page/our doctors.png"),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                              start: MediaQuery.sizeOf(context).width * 0.0443,
                                              end: MediaQuery.sizeOf(context).width * 0.0443,
                                            ),
                                            child: Column(
                                              children: <Widget>[

                                                ///title
                                                Container(
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.0660,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            ///title
                                                            defaultText(text:S.of(context).titleDoctorPage,
                                                                color: defaultWhiteColor,
                                                                height: MediaQuery.sizeOf(context).height * 0.0490,
                                                                textAlign: TextAlign.start,
                                                                textHeight: 1.1428,
                                                                alignment: AlignmentDirectional.centerStart,
                                                                fontFamily: "Arial",
                                                                fontSize: 24,
                                                                context: context),
                                                            ///more button that navigate to doctors screen
                                                            InkWell(
                                                              onTap: () async{
                                                                bool hasInternet=await NetworkConnection.getConnectivity();
                                                                if(hasInternet){
                                                                  showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                                  await HomeCubit.get(context).getClinicsData().then((value){
                                                                    navigateAndReplace(context:context,widget: DoctorsScreen());
                                                                  });
                                                                }else{
                                                                  navigateAndPush(context, DoctorsScreen());
                                                                  showSnackBar(context: context, text: S.current.failedConnection);
                                                                }

                                                              },
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  defaultText(
                                                                      height: MediaQuery.sizeOf(context).height * 0.0390,
                                                                      text: S.current.moreToNavigate,
                                                                      fontSize: 18,
                                                                      fontFamily: "Arial",
                                                                      boxFit: BoxFit.fitHeight,
                                                                      textHeight: 1.1666,
                                                                      color: defaultWhiteColor,
                                                                      context: context),
                                                                  SizedBox(
                                                                    width: MediaQuery.sizeOf(context)
                                                                        .width *
                                                                        0.0063,
                                                                  ),
                                                                  Container(
                                                                    height: MediaQuery.sizeOf(context)
                                                                        .height *
                                                                        0.0290,
                                                                    child:
                                                                    FittedBox(
                                                                      fit: BoxFit.fitHeight,
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_forward,
                                                                        size: 16,
                                                                        color: defaultWhiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment:
                                                        AlignmentDirectional
                                                            .bottomCenter,
                                                        child: Container(
                                                          height: 1,
                                                          width: MediaQuery
                                                              .sizeOf(
                                                              context)
                                                              .width,
                                                          color: Color(
                                                              0xffFFFFFF),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: MediaQuery.sizeOf(context).height * 0.0151,
                                                ),
                                                ///container view for doctors in Gene
                                                cubit.allDoctors.length != 0?
                                                Expanded(
                                                  child: GridView.count(
                                                    crossAxisCount: 2,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.all(5),
                                                    physics:
                                                    NeverScrollableScrollPhysics(),
                                                    children: cubit.allDoctors.length >=
                                                        4
                                                        ? List.generate(
                                                        4,
                                                            (index) => itemOfDoctors(
                                                          index: index,
                                                          context: context,
                                                          widgetScreen: HomeScreen(initScroll: false),
                                                          model: cubit.allDoctors[index],))
                                                        : List.generate(
                                                        cubit.allDoctors.length,
                                                            (index) => itemOfDoctors(
                                                          index: index,
                                                          context: context,
                                                          model: cubit
                                                              .allDoctors[
                                                          index],
                                                              widgetScreen: HomeScreen(initScroll: false,)
                                                            )),
                                                    mainAxisSpacing: MediaQuery.sizeOf(context).height*0.0329,
                                                    crossAxisSpacing: MediaQuery.sizeOf(context).width*0.0397,
                                                    childAspectRatio: (MediaQuery.sizeOf(context).width * 0.3808)
                                                        / (MediaQuery.sizeOf(context).height * 0.2861),
                                                  ),
                                                )
                                                    :Container(),
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: MediaQuery.sizeOf(context).height * 0.0215,
                                        ),

                                        ///medical services
                                        Container(
                                          height: MediaQuery.sizeOf(context).height * 0.623,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/container_home_page/outpatient Clinic.png"),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                              start: MediaQuery.sizeOf(context).width *
                                                  0.0443,
                                              end: MediaQuery.sizeOf(context).width *
                                                  0.0443,
                                            ),
                                            child: Column(
                                              children: [
                                                ///title
                                                Container(
                                                  width: MediaQuery.sizeOf(context).width,
                                                  height: MediaQuery.sizeOf(context).height * 0.0820,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            ///title
                                                            defaultText(
                                                                text:S.of(context).titleMedicalServicesPage,
                                                                color: defaultWhiteColor,
                                                                height: MediaQuery.sizeOf(context).height * 0.0490,
                                                                width: MediaQuery.sizeOf(context).width * 0.514,
                                                                textAlign: TextAlign.start,
                                                                textHeight: 1.1428,
                                                                alignment: AlignmentDirectional.centerStart,
                                                                fontFamily: "Arial",
                                                                fontSize: 24,
                                                                context: context
                                                            ),
                                                            ///more button that navigate to Medical Service screen
                                                            InkWell(
                                                              onTap: () async{
                                                                bool hasInternet=await NetworkConnection.getConnectivity();
                                                                if(hasInternet){
                                                                  showDialog(context: context, builder: (context) => defaultCircleProgressBar(),);
                                                                  await HomeCubit.get(context).getClinicsData().then((value){
                                                                    navigateAndReplace(context: context,widget:GeneClinicsScreen());
                                                                  });
                                                                }else{
                                                                  navigateAndPush(context,GeneClinicsScreen());
                                                                  showSnackBar(context: context, text: S.current.failedConnection);
                                                                }
                                                              },
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  defaultText(
                                                                      height: MediaQuery.sizeOf(context).height * 0.0390,
                                                                      text: S.current.moreToNavigate,
                                                                      fontSize: 18,
                                                                      fontFamily: "Arial",
                                                                      boxFit: BoxFit.fitHeight,
                                                                      textHeight: 1.1666,
                                                                      color: defaultWhiteColor,
                                                                      context: context),
                                                                  SizedBox(
                                                                    width: MediaQuery.sizeOf(context).width * 0.0063,
                                                                  ),

                                                                  Container(
                                                                    height: MediaQuery.sizeOf(context).height * 0.0290,
                                                                    child: FittedBox(
                                                                      fit: BoxFit.fitHeight,
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_forward,
                                                                        size: 16,
                                                                        color:
                                                                        defaultWhiteColor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: AlignmentDirectional.bottomCenter,
                                                        child: Container(
                                                          height: 1,
                                                          width: MediaQuery.sizeOf(context).width,
                                                          color: Color(
                                                            0xffFFFFFF,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.0157,
                                                ),
                                                ///container view for Medical Services in Gene
                                                cubit.clinics.length != 0?
                                                Expanded(
                                                  child: GridView.count(
                                                    crossAxisCount: 3,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.all(5),
                                                    physics: NeverScrollableScrollPhysics(),
                                                    children: cubit
                                                        .clinics.length >=
                                                        9
                                                        ? List.generate(
                                                        9,
                                                            (index) => itemOfClinics(
                                                            context: context,
                                                            model: cubit.clinics[index]
                                                        ))
                                                        : List.generate(
                                                        cubit.clinics.length,
                                                            (index) => itemOfClinics(
                                                            context: context,
                                                            model: cubit.clinics[index]
                                                        )),
                                                    mainAxisSpacing: MediaQuery.sizeOf(context).height * 0.0179,
                                                    crossAxisSpacing:MediaQuery.sizeOf(context).width *  0.0233,
                                                    childAspectRatio: 0.97/1.2048,
                                                  ),
                                                )
                                                    :Container(),
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: MediaQuery.sizeOf(context).height * 0.1241,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            /// appBar
                            Container(
                              alignment: Alignment.topCenter,
                              color: Colors.transparent,
                              height: MediaQuery.sizeOf(context).height * 0.2786,
                              width: MediaQuery.sizeOf(context).width,
                              child: Stack(
                                children: [

                                  ///top app bar with logo
                                  Container(
                                    height: MediaQuery.sizeOf(context).height * 0.21598,
                                    width:MediaQuery.sizeOf(context).width,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:AssetImage("assets/container_home_page/title appBar.png",),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: MediaQuery.sizeOf(context).width*0.02,
                                          end: MediaQuery.sizeOf(context).width*0.02,
                                          top: MediaQuery.sizeOf(context).height * 0.0129),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width:MediaQuery.sizeOf(context).width,
                                          color: Colors.transparent,
                                          height: MediaQuery.sizeOf(context).height * 0.1187,
                                          child: Row(
                                            children: [

                                              /// logo of app
                                              Image(
                                                image:AssetImage(languageApp!="ar"?logoImageEN:logoImageAR),
                                                width: MediaQuery.sizeOf(context).width * 0.1992,
                                                fit: BoxFit.fill,
                                                height:MediaQuery.sizeOf(context).height * 0.1187,
                                              ),

                                              ///title and actions
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.only(
                                                    start: MediaQuery.sizeOf(context).width * 0.023,
                                                    bottom: MediaQuery.sizeOf(context).height * 0.0010,
                                                  ),
                                                  child: Column(
                                                    children: [

                                                      ///title
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsetsDirectional.only(
                                                              start: 15
                                                          ),
                                                          child: Container(
                                                            alignment: AlignmentDirectional.centerStart,
                                                            height: MediaQuery.sizeOf(context).height * 0.034477,
                                                            child: FittedBox(
                                                              alignment: AlignmentDirectional.centerStart,
                                                              child: Text(
                                                                S.of(context).titleHomePage,
                                                                maxLines: 1,
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  height: 1.1428,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 35,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      ///actions
                                                      Row(
                                                        children: [
                                                          ///search for doctors
                                                          Expanded(
                                                            child: Container(
                                                              height: MediaQuery.sizeOf(context).height * 0.0539,
                                                              clipBehavior: Clip.antiAlias,
                                                              decoration: BoxDecoration(
                                                                color: defaultWhiteColor,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: defaultBlackColor.withOpacity(0.16),
                                                                    blurStyle: BlurStyle.outer,
                                                                    blurRadius:6 ,
                                                                    offset: Offset(0,3),
                                                                  )
                                                                ],
                                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                                              ),
                                                              child: Padding(
                                                                padding:  EdgeInsetsDirectional.only(
                                                                  start:MediaQuery.sizeOf(context).width*0.0186,
                                                                  end: MediaQuery.sizeOf(context).width*0.0191,
                                                                  top: MediaQuery.sizeOf(context).height*0.0129,
                                                                  bottom: MediaQuery.sizeOf(context).height*0.0086,
                                                                ),
                                                                child: InkWell(
                                                                  onTap: (){
                                                                    navigateAndPush(context,SearchScreen());
                                                                  },
                                                                  child: Container(
                                                                    height: MediaQuery.sizeOf(context).height*0.025,
                                                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                                                    child: TextFormField(
                                                                      keyboardType: TextInputType.text,
                                                                      onTap: (){
                                                                        navigateAndPush(context,SearchScreen());
                                                                      },
                                                                      // enabled: false,
                                                                      decoration: InputDecoration(
                                                                        contentPadding:EdgeInsetsDirectional.only(
                                                                            start:10,
                                                                            top: 4,
                                                                            bottom:8
                                                                        ),
                                                                        border: InputBorder.none,
                                                                        fillColor: Colors.white,
                                                                        filled: true,
                                                                        enabled: false,
                                                                        label: Container(
                                                                          // width: MediaQuery.sizeOf(context).width*0.497,
                                                                          height: MediaQuery.sizeOf(context).height*0.025,
                                                                          child: FittedBox(
                                                                            fit: BoxFit.fill,
                                                                            alignment: AlignmentDirectional.centerStart,
                                                                            child: Text(
                                                                              S.of(context).hintSearchTextFieldHomePage,
                                                                              style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: defaultBlackColor.withOpacity(0.5),
                                                                                fontFamily: "Arial",
                                                                                height: 1.12,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        prefixIcon:SvgPicture.asset(
                                                                          "assets/svgIcons/search-svgrepo-com.svg",
                                                                          color: Color(0xff7F7F7F),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          SizedBox(
                                                            width:MediaQuery.sizeOf(context).width*0.0350,
                                                          ),

                                                          /// booking button
                                                          Container(
                                                            width: MediaQuery.sizeOf(context).width*0.0817,
                                                            height: MediaQuery.sizeOf(context).height *0.0377,
                                                            child: IconButton(
                                                              padding: EdgeInsets.all(0),
                                                              onPressed: () async{
                                                                bool hasInternet=await NetworkConnection.getConnectivity();
                                                                if(userTokenApi !=null){
                                                                  if(hasInternet){
                                                                    showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                                    await HomeCubit.get(context).getBookingForUser().then((value){
                                                                      Navigator.pop(context);
                                                                      navigateAndPush(context,BookingScreen());
                                                                    });
                                                                  }else{
                                                                    navigateAndPush(context,BookingScreen(),);
                                                                    showSnackBar(context: context, text: S.current.failedConnection);
                                                                  }
                                                                }
                                                                else{
                                                                  navigateAndPush(context,SignInScreen(fromUser: true,widget: BookingScreen(),));
                                                                }
                                                              },
                                                              icon:SvgPicture.asset("assets/svgIcons/Calender.svg",
                                                                color: Colors.white,
                                                                height: MediaQuery.sizeOf(context)
                                                                    .height *0.0377,
                                                                width:MediaQuery.sizeOf(context).width*0.0817,
                                                              ),
                                                            ),
                                                          ),

                                                          SizedBox(
                                                            width:MediaQuery.sizeOf(context).width*0.0163,
                                                          ),

                                                          ///notification button
                                                          Container(
                                                            height: MediaQuery.sizeOf(context).height *0.0377,
                                                            width:MediaQuery.sizeOf(context).width*0.0817,
                                                            child: IconButton(
                                                              padding: EdgeInsets.all(0),
                                                              onPressed: () async{
                                                                bool hasInternet=await NetworkConnection.getConnectivity();
                                                                if(userTokenApi!=null){
                                                                  if(!hasInternet){
                                                                    showSnackBar(context: context, text: S.current.failedConnection);
                                                                  }
                                                                  notificationSlider(globalContext: context);
                                                                }else{
                                                                  navigateAndPush(context,SignInScreen(fromUser: true,widget: BookingScreen(),));
                                                                }
                                                              },
                                                              icon:Image.asset(
                                                                "assets/svgIcons/Notification.png",
                                                                height: MediaQuery.sizeOf(context)
                                                                    .height *0.0377,
                                                                width:MediaQuery.sizeOf(context).width*0.0817,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  ///bottom app bar with view of user data
                                  BlocConsumer<SignInCubit,SignInState>(

                                      builder:(context, state) {
                                        return Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                MediaQuery.sizeOf(context).width * 0.0327
                                            ),
                                            child: Container(
                                              height: MediaQuery.sizeOf(context).height * 0.1295,
                                              width: MediaQuery.sizeOf(context).width,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                image: DecorationImage(
                                                  filterQuality: FilterQuality.high,
                                                  image:AssetImage("assets/container_home_page/show user.png",),
                                                  fit: BoxFit.cover,
                                                ),

                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional.only(
                                                  top: MediaQuery.sizeOf(context).height * 0.0129,
                                                  bottom: MediaQuery.sizeOf(context).height * 0.0151,
                                                  start:MediaQuery.sizeOf(context).width * 0.0210 ,
                                                  end:MediaQuery.sizeOf(context).width * 0.0514,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [

                                                    ///image of user
                                                    Container(
                                                      height:MediaQuery.sizeOf(context).height * 0.101,
                                                      width: MediaQuery.sizeOf(context).width *0.2196,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 10,
                                                            offset: Offset(0, 0),
                                                            blurStyle: BlurStyle.outer,
                                                            color: defaultBlackColor.withAlpha(41),
                                                          )
                                                        ],
                                                      ),
                                                      child:SignInCubit.get(context).loginDataModel!=null?
                                                      InkWell(
                                                        onTap: ()async{
                                                          bool hasInternet=await NetworkConnection.getConnectivity();
                                                          if(hasInternet){
                                                            showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                            SignInCubit.get(context).refreshData(context: context).then((value){
                                                              navigateAndReplace(context:context, widget: MyProfileScreen());
                                                            });
                                                          }else{
                                                            navigateAndPush(context,MyProfileScreen());
                                                            showSnackBar(context: context, text: S.current.failedConnection);
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage: NetworkImage(SignInCubit.get(context).loginDataModel!.userAccount!.image!),
                                                        ),
                                                      ):
                                                      InkWell(
                                                        onTap: ()async{
                                                          navigateAndPush(context,SignInScreen());
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage: NetworkImage("https://clinic.megavisionagency.com/assets/img/avatars/1.png"),
                                                        ),
                                                      ),
                                                    ),

                                                    /// center of user details container
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.only(
                                                            start: MediaQuery.sizeOf(context).width*0.0350),
                                                        ///navigate to my profile screen if user signed in
                                                        ///if not navigate to sign in screen
                                                        child: InkWell(
                                                          onTap: () async{
                                                            bool hasInternet=await NetworkConnection.getConnectivity();
                                                            if(userTokenApi != null){
                                                              if(hasInternet){
                                                                showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                                SignInCubit.get(context).refreshData(context: context).then((value){
                                                                  navigateAndReplace(context:context, widget: MyProfileScreen());
                                                                });
                                                              }else{
                                                                navigateAndPush(context,MyProfileScreen());
                                                                showSnackBar(context: context, text: S.current.failedConnection);
                                                              }

                                                            }
                                                            else{
                                                              navigateAndPush(context,SignInScreen());
                                                            }
                                                          },
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [

                                                              ///welcome text
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    // width:MediaQuery.sizeOf(context).width*0.2219 ,
                                                                    height: MediaQuery.sizeOf(context).height*0.0230,
                                                                    child: FittedBox(
                                                                      alignment: AlignmentDirectional.centerStart,
                                                                      child: Text(
                                                                        S.of(context).goodMorningHomePage,
                                                                        style: TextStyle(
                                                                          height: 1.14,
                                                                          fontSize: 18,
                                                                          fontFamily: "Arial",
                                                                          color:Color(0xffE9E9E9),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: MediaQuery.sizeOf(context).width*0.0116,),
                                                                  SvgPicture.asset(
                                                                    "assets/svgIcons/hand-svgrepo-com.svg",
                                                                    width: MediaQuery.sizeOf(context).width*0.05264,
                                                                    height: MediaQuery.sizeOf(context).height*0.0230,
                                                                  ),
                                                                ],
                                                              ),

                                                              SizedBox(height:MediaQuery.sizeOf(context).height*0.0049),

                                                              ///name of user
                                                              Container(
                                                                height: MediaQuery.sizeOf(context).height*0.02159,
                                                                width: MediaQuery.sizeOf(context).width*0.4766,
                                                                child: FittedBox(
                                                                  alignment: AlignmentDirectional.centerStart,
                                                                  child: Text(
                                                                      SignInCubit.get(context).loginDataModel!=null?
                                                                      SignInCubit.get(context).loginDataModel!.userAccount!.fullName!
                                                                      :S.of(context).pleaseLogInText,
                                                                      style: TextStyle(
                                                                        height: 1.1666,
                                                                        color: Colors.white,
                                                                        fontSize: 18,
                                                                        fontFamily: "Arial",
                                                                        fontWeight: FontWeight.w500,),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    ///favourites doctor for user
                                                    Container(
                                                      height: MediaQuery.sizeOf(context).height*0.0280,
                                                      width: MediaQuery.sizeOf(context).width*0.0665,
                                                      child: IconButton(
                                                        onPressed: () async{
                                                          bool hasInternet=await NetworkConnection.getConnectivity();
                                                          if(userTokenApi!=null){
                                                            if(hasInternet){
                                                              showDialog(context: context, builder:(context) => defaultCircleProgressBar(),);
                                                              await HomeCubit.get(context).getFavourites().then((value){
                                                                Navigator.pop(context);
                                                                navigateAndPush(context,FavouritesScreen());
                                                              });
                                                            }
                                                            else{
                                                              navigateAndPush(context,FavouritesScreen());
                                                              showSnackBar(context: context, text: S.current.failedConnection);
                                                            }
                                                          }else{
                                                            navigateAndPush(context,SignInScreen());
                                                          }

                                                        },
                                                        padding: EdgeInsets.all(0),
                                                        icon:SvgPicture.asset("assets/svgIcons/favourite.svg",
                                                          height: MediaQuery.sizeOf(context).height*0.0280,
                                                          width: MediaQuery.sizeOf(context).width*0.0665,
                                                          color: Color(0xffFF2691),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },

                                      listener:(context, state) {

                                      },

                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///navBar
                      appNavBar(context: context,localIndex: 0),

                    ],
                  ),
                ),
            );
          },
        );
      },
    );
  }

  ///scroll to top page in home screen
  void scrollToTop() {
    scrollController!.animateTo(scrollController!.position.minScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  double? offsit;
  ///check if offset of screen bigger than 30 make the button of scroll appear
  void checkScrollUp(BuildContext context){
    scrollController!..addListener(() {
       offsit=scrollController!.offset;
      if (scrollController!.offset == scrollController!.position.maxScrollExtent) {
        ///change value of showBackToTopButton to true
        ///that view Floating action of up button
        HomeCubit.get(context).onBackToTop(index: true,offSit: offsit??0);
      } else {
        ///change value of showBackToTopButton to false
        ///that hidden Floating action of up button
        HomeCubit.get(context).onBackToTop(index: false,offSit: offsit??0);
      }
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    HomeCubit.get(context).onBackToTop(index: false,offSit: 0);
    super.deactivate();
  }


}

notificationSlider({required BuildContext globalContext})=>
    Navigator.push(globalContext, DialogRoute(context: globalContext, builder:(context) =>NotificationSlider(),));


List notificationList = [
  "Notification One",
  "Notification Two",
  "Notification Three",
];

