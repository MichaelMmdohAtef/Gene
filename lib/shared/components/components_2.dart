import 'dart:io';
import 'package:Gene/main.dart';
import 'package:Gene/shared/network/cache_memory/shared_preferences.dart';
import 'package:Gene/shared/network/remote_network/NetworkConnection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_cubit.dart';
import 'package:Gene/layouts/home_layout/Cubit/home_states.dart';
import 'package:Gene/models/Country%20Model/country_model.dart';
import 'package:Gene/models/login_model.dart';
import 'package:Gene/modules/Sign_In/cubit/cubit.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:Gene/shared/components/constants.dart';
import '../../generated/l10n.dart';


///widget of country button sheet
countryButtonSheet({
  required BuildContext context,
  required TextEditingController countryController,
  required bool fromUser,
}){
  double screenHeight=MediaQuery.sizeOf(context).height;
  double screenWidth=MediaQuery.sizeOf(context).width;
  return Container(
    height:screenHeight * 0.6630,
    width:screenWidth * 0.9345,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      ),
      color:defaultWhiteColor,
    ),
    child:Padding(
      padding:EdgeInsetsDirectional.only(
        top:screenHeight *  0.0302375809935205,
        bottom:screenHeight *  0.01835,
        end:screenWidth * 0.02336,
        start:screenWidth *  0.02336,
      ),
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.0313,
            child: Stack(
              children: [
                defaultText(
                    text: S.of(context).titleButtonSheetCountry,
                    color: defaultGreyColor,
                    height: screenHeight * 0.0313,
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    alignment: AlignmentDirectional.center,
                    textHeight: 1.3181,
                    fontFamily: "Roboto",
                    context: context),
                Align(
                  alignment:AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding:  EdgeInsetsDirectional.only(
                      end: screenWidth * 0.04672,
                    ),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        HomeCubit.get(context).onSelectNameOfCountry(disposed: true);
                      },
                      child: Container(
                        height:screenHeight * 0.04,
                        width: screenWidth * 0.07,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: Icon(Icons.close,)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: screenHeight * 0.019438
          ),
          defaultTextFormField(
              context: context,
              controller: countryController,
              onChange: (value){
                HomeCubit.get(context).onSelectNameOfCountry(name:value!);
              },
              hint: S.of(context).hintTitleButtonSheetCountry,
              isExpanded: true,
              keyboardType: TextInputType.text
          ),
          SizedBox(height: screenHeight * 0.01619),
          BlocConsumer<HomeCubit,HomeStates>(
            builder:(context, state) {
              return HomeCubit.get(context).filteredCountryList.length!=0?
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    itemBuilder:(context, index) {
                      return defaultCountryContainer(
                          context: context,
                          country: HomeCubit.get(context).filteredCountryList[index],
                          index: index,fromUser: fromUser,
                      );
                    },
                    separatorBuilder:(context, index) => SizedBox(
                      height: screenHeight * 0.01511,
                    ),
                    itemCount:HomeCubit.get(context).filteredCountryList.length,
                ),
              )
              :Expanded(
                    child: ListView.separated(
                    padding: EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    itemBuilder:(context, index) {
                      return defaultCountryContainer(
                        context: context,
                        country: HomeCubit.get(context).countryList[index],
                        index: index,
                        fromUser: fromUser,
                      );
                    },
                    separatorBuilder:(context, index) => SizedBox(
                      height: screenHeight * 0.01511,
                    ),
                    itemCount:HomeCubit.get(context).countryList.length,
                ),
              );
            },
            listener:(context, state) {

            },),

          SizedBox(height: screenHeight * 0.0194),
        ],
      ),
    ),
  );
}


///container widget of country that show (name of country)
Widget defaultCountryContainer({
  required int index,
  required BuildContext context,
  required CountryModel country,
  required bool fromUser,
}){
  double screenHeight=MediaQuery.sizeOf(context).height;
  double screenWidth=MediaQuery.sizeOf(context).width;
  String countryImage="https://www.countryflagicons.com/FLAT/64/${country.countryCode}.png";
  return MaterialButton(
    onPressed: ()async{
      HomeCubit.get(context).filteredCountryList.length ==0?
      HomeCubit.get(context).onChangeCountriesCheckbox(lang:country.name)
      :HomeCubit.get(context).onChangeCountriesCheckbox(lang:country.name,isFiltered: true);
      SignInCubit.get(context).getCountryNumber(context: context);
      if(fromUser && userTokenApi != null){
        bool hasInternet=await NetworkConnection.getConnectivity();
        if(hasInternet){
          showDialog(context: context, builder:(context) =>defaultCircleProgressBar());
          UserAccountLoginPage user=SignInCubit.get(context).userModel!;
          user.country=SignInCubit.get(context).countryId.toString();
          await SignInCubit.get(context).updateData(context:context,data:user.toMap()).then((value) {
            Navigator.pop(context);
          });
        }else{
          getCountryFromCountryApi(idOfCountryFromAPI: int.parse(countryApp.toString()), context: context);
          showSnackBar(context: context, text: S.current.failedConnection);
        }

      }
      Navigator.pop(context);
      HomeCubit.get(context).onSelectNameOfCountry(disposed: true);
    },
    child: Container(
      height: screenHeight * 0.06479,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              color: defaultBlackColor.withAlpha(35),
              blurRadius: 15,
              blurStyle: BlurStyle.outer
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start:screenWidth * 0.07476,
          end:screenWidth * 0.03738,
          bottom:screenHeight * 0.01619,
          top:screenHeight * 0.01619,
        ),
        child: Row(
          children: [

            Container(
              height:screenHeight * 0.0280,
              width:screenWidth * 0.08878,
              child:
              kIsWeb || Platform.isWindows?
              Image.network(countryImage,fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => country.emojiText(country),
              )
                  : country.emojiText(country),
            ),

            SizedBox(
              width: screenWidth * 0.04439,
            ),

            Expanded(
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                height: screenHeight * 0.0375,
                child: Text(
                  country.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: defaultBlackColor,
                    fontSize: 16,
                    fontFamily: "Roboto",
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ),

            BlocConsumer<HomeCubit,HomeStates>(
              builder:(context, state) {
              return
                HomeCubit.get(context).filteredCountryList.length ==0?
                Checkbox.adaptive(
                  value:HomeCubit.get(context).countryList[index].check,
                  shape: CircleBorder(),
                  activeColor: defaultBlueAccentColor,
                  side:
                  HomeCubit.get(context).countryList[index].check!?
                  BorderSide(color: defaultBlueAccentColor,
                    width: 3,
                  ):
                  BorderSide(color: Color(0xff8F8F8F),
                    width: 3,
                  ),
                  hoverColor: Colors.orange,
                  onChanged: (checked){
                    HomeCubit.get(context).onChangeCountriesCheckbox(index: index);
                    Navigator.pop(context);
                  })
                :Checkbox.adaptive(
                  value:HomeCubit.get(context).filteredCountryList[index].check,
                  shape: CircleBorder(),
                  activeColor: defaultBlueAccentColor,
                  side:
                  HomeCubit.get(context).filteredCountryList[index].check!?
                  BorderSide(color: defaultBlueAccentColor,
                    width: 3,
                  ):
                  BorderSide(color: Color(0xff8F8F8F),
                    width: 3,
                  ),
                  hoverColor: Colors.orange,
                  onChanged: (checked){
                    HomeCubit.get(context).onChangeCountriesCheckbox(index: index,isFiltered: true);
                    Navigator.pop(context);
                  });
            },
              listener: (context, state) {

              },
            ),

          ],
        ),
      ),
    ),
  );
}


///widget of country button sheet
codeOfCountryButtonSheet({
  required BuildContext context,
  required TextEditingController countryController,
  required bool fromUser,
}){
  double screenHeight=MediaQuery.sizeOf(context).height;
  double screenWidth=MediaQuery.sizeOf(context).width;
  return Container(
    height:screenHeight * 0.6630,
    width:screenWidth * 0.9345,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      ),
      color:defaultWhiteColor,
    ),
    child:Padding(
      padding:EdgeInsetsDirectional.only(
        top:screenHeight *  0.0302375809935205,
        bottom:screenHeight *  0.01835,
        end:screenWidth * 0.02336,
        start:screenWidth *  0.02336,
      ),
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.0313,
            child: Stack(
              children: [
                defaultText(
                    text: S.of(context).titleButtonSheetCountry,
                    color: defaultGreyColor,
                    height: screenHeight * 0.0313,
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    alignment: AlignmentDirectional.center,
                    textHeight: 1.3181,
                    fontFamily: "Roboto",
                    context: context),
                Align(
                  alignment:AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding:  EdgeInsetsDirectional.only(
                      end: screenWidth * 0.04672,
                    ),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        HomeCubit.get(context).onSelectNameOfCountry(disposed: true);
                      },
                      child: Container(
                        height:screenHeight * 0.04,
                        width: screenWidth * 0.07,
                        child: FittedBox(
                            fit: BoxFit.cover,
                            child: Icon(Icons.close)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: screenHeight * 0.019438
          ),
          defaultTextFormField(
              context: context,
              controller: countryController,
              onChange: (value){
                HomeCubit.get(context).onSelectNameOfCountry(name:value!);
              },
              hint: S.of(context).hintTitleButtonSheetCountry,
              isExpanded: true,
              keyboardType: TextInputType.text
          ),
          SizedBox(height: screenHeight * 0.01619),
          BlocConsumer<HomeCubit,HomeStates>(
            builder:(context, state) {
              return HomeCubit.get(context).filteredCountryList.length!=0?
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  itemBuilder:(context, index) {
                    return defaultCountryWithPhoneContainer(
                      context: context,
                      country: HomeCubit.get(context).filteredCountryList[index],
                      index: index,fromUser: fromUser,
                    );
                  },
                  separatorBuilder:(context, index) => SizedBox(
                    height: screenHeight * 0.01511,
                  ),
                  itemCount:HomeCubit.get(context).filteredCountryList.length,
                ),
              )
                  :Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  itemBuilder:(context, index) {
                    return defaultCountryWithPhoneContainer(
                      context: context,
                      country: HomeCubit.get(context).countryList[index],
                      index: index,
                      fromUser: fromUser,
                    );
                  },
                  separatorBuilder:(context, index) => SizedBox(
                    height: screenHeight * 0.01511,
                  ),
                  itemCount:HomeCubit.get(context).countryList.length,
                ),
              );
            },
            listener:(context, state) {

            },),

          SizedBox(height: screenHeight * 0.0194),
        ],
      ),
    ),
  );
}


///container widget of country that show (name of country)
Widget defaultCountryWithPhoneContainer({
  required int index,
  required BuildContext context,
  required CountryModel country,
  required bool fromUser,
}){
  double screenHeight=MediaQuery.sizeOf(context).height;
  double screenWidth=MediaQuery.sizeOf(context).width;
  String countryImage="https://www.countryflagicons.com/FLAT/64/${country.countryCode}.png";
  return MaterialButton(
    onPressed: ()async{

      HomeCubit.get(context).filteredCountryOfPhoneList.length == 0 ?
      HomeCubit.get(context).onChangeCountriesOfPhoneCheckbox(lang:country.name)
          :HomeCubit.get(context).onChangeCountriesOfPhoneCheckbox(lang:country.name,isFiltered: true);

      await CashHelper.setString(key: COUNTRY_Of_Phone, value: country.name);

      Navigator.pop(context);
      HomeCubit.get(context).onSelectNameOfCountry(disposed: true);
    },
    child: Container(
      height: screenHeight * 0.06479,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              color: defaultBlackColor.withAlpha(35),
              blurRadius: 15,
              blurStyle: BlurStyle.outer
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start:screenWidth * 0.07476,
          end:screenWidth * 0.03738,
          bottom:screenHeight * 0.01619,
          top:screenHeight * 0.01619,
        ),
        child: Row(
          children: [

            Container(
              height:screenHeight * 0.0280,
              width:screenWidth * 0.08878,
              child:
              kIsWeb || Platform.isWindows?
              Image.network(countryImage,fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => country.emojiText(country),
              )
                  : country.emojiText(country),
            ),

            SizedBox(
              width: screenWidth * 0.04439,
            ),

            Expanded(
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                height: screenHeight * 0.0375,
                child: Text(
                  country.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: defaultBlackColor,
                    fontSize: 16,
                    fontFamily: "Roboto",
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ),

            BlocConsumer<HomeCubit,HomeStates>(
              builder:(context, state) {
                return
                  HomeCubit.get(context).countryOfPhoneList.length ==0?
                  Checkbox.adaptive(
                      value:HomeCubit.get(context).countryOfPhoneList[index].check,
                      shape: CircleBorder(),
                      activeColor: defaultBlueAccentColor,
                      side:
                      HomeCubit.get(context).countryOfPhoneList[index].check!?
                      BorderSide(color: defaultBlueAccentColor,
                        width: 3,
                      ):
                      BorderSide(color: Color(0xff8F8F8F),
                        width: 3,
                      ),
                      hoverColor: Colors.orange,
                      onChanged: (checked){
                        HomeCubit.get(context).onChangeCountriesOfPhoneCheckbox(index: index);
                        Navigator.pop(context);
                      })
                      :Checkbox.adaptive(
                      value:HomeCubit.get(context).countryOfPhoneList[index].check,
                      shape: CircleBorder(),
                      activeColor: defaultBlueAccentColor,
                      side:
                      HomeCubit.get(context).countryOfPhoneList[index].check!?
                      BorderSide(color: defaultBlueAccentColor,
                        width: 3,
                      ):
                      BorderSide(
                        color: Color(0xff8F8F8F),
                        width: 3,
                      ),
                      hoverColor: Colors.orange,
                      onChanged: (checked){
                        HomeCubit.get(context).onChangeCountriesOfPhoneCheckbox(index: index,isFiltered: true);
                        Navigator.pop(context);
                      });
              },
              listener: (context, state) {

              },
            ),

          ],
        ),
      ),
    ),
  );
}