import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
// ignore: must_be_immutable
class HeroChatImage extends StatelessWidget {
  String image;
  String name;
  HeroChatImage({required String this.image,required this.name});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          systemNavigationBarContrastEnforced: true
        ),
        titleSpacing: 0,
        actions: [
          ///share icon
          IconButton(
              onPressed: () async{
                http.Response response=await http.get(
                    Uri.parse(image)
                );
                Uint8List imageAsUint8List= response.bodyBytes;

                saveImageAndShareIt(value:imageAsUint8List, name: name);
              },
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.share_rounded,
                color: Colors.white,
                size: 25,
              )),
          ///download icon
          IconButton(
              onPressed: () async{
                http.Response response=await http.get(
                    Uri.parse(image)
                );
                Uint8List imageAsUint8List= response.bodyBytes;
                saveImage(value: imageAsUint8List, name: name);
              },
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.download,
                color: Colors.white,
                size: 25,
              )),

        ],
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          Navigator.of(context).pop();
        },
        onTap: () {

        },
        child: Container(
        width: MediaQuery.sizeOf(context).width,
        height:MediaQuery.sizeOf(context).height,
        child: Hero(
          tag: "hero-rectangle",
          createRectTween: (Rect? begin, Rect? end) {
            return MaterialRectCenterArcTween(begin: begin, end: end);
          },
          child: InteractiveViewer(
            maxScale: 4,
            alignment: Alignment.center,
            child: BoxWidget(
              color: Colors.black,
              image: image,
            ),
          ),
        ),
      ),
      ),
    );
  }
}
class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.color,
    required this.image,
  });

  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height:MediaQuery.sizeOf(context).height,
      color: color,
      child: Image.network(
            image,
            fit: BoxFit.fitWidth,
      ),
    );
  }
}


///save image on phone
saveImage({
  required Uint8List value,
  required String name
})async{
  await [Permission.storage].request();
  await ImageGallerySaver.saveImage(value,name:name,isReturnImagePathOfIOS: true);
}


///share image with other ways
saveImageAndShareIt({
  required Uint8List value,
  required String name,
})async{
  final directory=(await getApplicationCacheDirectory()).path;
  final image=File('$directory/$name');
  image.writeAsBytesSync(value);
  // ignore: deprecated_member_use
  await Share.shareFiles([image.path]);
}
