import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/clinics_model.dart';
import 'package:Gene/shared/components/components.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen>{

  ///search controller that controls in viewing doctors written by user
  TextEditingController searchController=TextEditingController();
  late double screenHeight;
  late double screenWidth;

  ///list of doctors that user search on them
  List<Doctors> filtersDoctor=[];

  ScrollController? scrollSearchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(HomeCubit.get(context).seachTextOfSearchScreen!=null){
      searchController.text=HomeCubit.get(context).seachTextOfSearchScreen!;
      changeSearchList(value: searchController.text, context: context);
      setState(() {

      });
    }
    scrollSearchController=ScrollController(initialScrollOffset: HomeCubit.get(context).offSitOfSearchScreen);
    ///initialize the listener of Scroll Controller
    checkScrollOffsit(context);
  }


  @override
  Widget build(BuildContext context) {
    screenHeight=MediaQuery.sizeOf(context).height;
    screenWidth=MediaQuery.sizeOf(context).width;

    return BlocConsumer<HomeCubit,HomeStates>(
        builder:(context, state) {
         return Scaffold(
             appBar: statusBar(),
             body: Column(
               children: [
                 ///text field of search
                 Container(
                   decoration: BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         color: Colors.blue,
                         width: 2,
                       )
                     )
                   ),
                   child: Row(
                     children: [

                       ///text field
                       Expanded(
                         child: Container(
                           height: MediaQuery.sizeOf(context).height * 0.07,
                           child: TextFormField(
                             onChanged: (value){
                               searchController.text=value;
                               HomeCubit.get(context).onBackSearchScreenToTop(offSit: HomeCubit.get(context).offSitOfSearchScreen,name: value);
                               changeSearchList(value: value, context: context);
                               setState(() {});
                             },
                             decoration: InputDecoration(
                               contentPadding: EdgeInsets.symmetric(
                                 horizontal: 15,
                               ),
                               border: InputBorder.none
                             ),
                         
                             // autofocus: true,
                             controller: searchController,
                             keyboardType: TextInputType.text,
                           ),
                         ),
                       ),

                       ///clear button
                       ///show when text field of search is not empty
                       if(searchController.text!="")
                       Padding(
                           padding: const EdgeInsetsDirectional.only(
                               end: 15
                           ),
                           child: Align(
                             alignment: AlignmentDirectional.centerEnd,
                             child: InkWell(
                               onTap: (){
                                 searchController.text="";
                                 setState(() {});
                               },
                               child: Container(
                                 alignment: AlignmentDirectional.centerEnd,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Colors.black,
                                   ),
                                   width:MediaQuery.sizeOf(context).width * 0.06,
                                   height: MediaQuery.sizeOf(context).height * 0.03,
                                   child: Center(child: Icon(Icons.close,size: 20,color: Colors.white,))),
                             ),
                           ),
                         ),

                     ],
                   ),
                 ),
                 ///container that view doctors Depending on the user search
                 Expanded(
                   child: ConditionalBuilder(
                     condition: filtersDoctor.isNotEmpty,
                     builder:(context) =>Padding(
                       padding:  EdgeInsetsDirectional.only(
                         top:screenHeight* 0.0215,
                         // bottom:screenHeight* 0.0551,
                         start:screenWidth* 0.0665,
                         end:screenWidth* 0.0665,
                       ),
                       child: GridView.count(
                         crossAxisCount:2,
                         shrinkWrap: true,
                         padding:
                         EdgeInsets.all(5),
                         controller: scrollSearchController,
                         physics:
                         BouncingScrollPhysics(),
                         children: List.generate(
                             filtersDoctor.length,
                                 (index) => itemOfDoctors(
                                   index: index,
                               context:
                               context,
                               model: filtersDoctor[index],
                                   widgetScreen: SearchScreen()
                             )),
                         // primary: false,
                         mainAxisSpacing: MediaQuery.sizeOf(context).height*0.0329,
                         crossAxisSpacing: MediaQuery.sizeOf(context).width*0.0397,
                         childAspectRatio: 0.614,
                         // childAspectRatio: (MediaQuery.sizeOf(context).width * 0.38)
                         //     / (MediaQuery.sizeOf(context).height * 0.2861),
                       ),
                     ),
                     fallback: (context) => Padding(
                           padding:  EdgeInsetsDirectional.only(
                             top:screenHeight* 0.0215,
                             // bottom:screenHeight* 0.0551,
                             start:screenWidth* 0.0665,
                             end:screenWidth* 0.0665,
                           ),
                           child: GridView.count(
                             crossAxisCount:2,
                             shrinkWrap: true,
                             padding:
                             EdgeInsets.all(5),
                             controller: scrollSearchController,
                             physics:
                             BouncingScrollPhysics(),
                             children: List.generate(
                                 HomeCubit.get(context).allDoctors.length,
                                     (index) => itemOfDoctors(
                                     index: index,
                                     context:
                                     context,
                                     model: HomeCubit.get(context).allDoctors[index],
                                     widgetScreen: SearchScreen()
                                 )),
                             mainAxisSpacing: MediaQuery.sizeOf(context).height*0.0329,
                             crossAxisSpacing: MediaQuery.sizeOf(context).width*0.0397,
                             childAspectRatio: 0.614,
                           ),
                         )
                   ),
                 ),

               ],
             )
         );
        },
        listener: (context, state) {

        },
    );


  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    HomeCubit.get(context).onBackSearchScreenToTop(name: '',offSit: 0);
    super.deactivate();
  }

  ///scroll to top page in doctor screen
  void scrollScreenToTop() {
    scrollSearchController!.animateTo(scrollSearchController!.position.minScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  ///listener on scroll position
  void checkScrollOffsit(BuildContext context) {
    scrollSearchController!..addListener(() {
      double offSit=scrollSearchController!.offset;
      String? search=searchController.text;
      print(offSit);
      if (scrollSearchController!.offset == scrollSearchController!.position.maxScrollExtent-20) {
        HomeCubit.get(context).onBackSearchScreenToTop(name: search,offSit: offSit);
      } else {
        HomeCubit.get(context).onBackSearchScreenToTop(name: search,offSit: offSit);
      }
    });
  }


  ///fun to change state of search Depending on the user
  changeSearchList({
    required String value,
    required BuildContext context,
  }){
    filtersDoctor=[];
    HomeCubit.get(context).allDoctors.map((e){
      if(e.fullName.toString().toLowerCase().contains(value.toString().toLowerCase())){
        filtersDoctor.add(e);
      }
    }).toList();
  }

}

