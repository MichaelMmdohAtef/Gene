import 'package:Gene/models/message_model.dart';
import 'package:Gene/modules/chat/hero_image_chat_screen.dart';
import 'package:Gene/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


// ignore: must_be_immutable
class ImageChatWidget extends StatelessWidget {
  MessageModel model;
  bool rtl=false;
  ImageChatWidget({super.key,required this.model, this.rtl=false});

  @override
  Widget build(BuildContext context) {
    DateTime date=DateTime.parse(model.date.toString());
    return InkWell(
      onTap: () {
        navigateAndPush(context, HeroChatImage(image: model.imageURL!,name: model.nameOfDocument!,));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ///builder of image
            CachedNetworkImage(
              imageUrl: model.imageURL!,
              placeholder: (context, url) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircularProgressIndicator(),
                  )),
                );
              },
              errorWidget:(context, url, error) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Icon(Icons.error_outline),
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Image.network(model.imageURL!,),
                );
              },

            ),

            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.007,
            ),
            ///date of message
            Text("${date.day==DateTime.now().day?"today":"${date.year}/${date.month}/${date.day}"}  ${date.hour}:${date.minute}"),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(15),
            bottomEnd: Radius.circular(0),
            topEnd: Radius.circular(15),
            bottomStart:rtl?Radius.circular(0) : Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
