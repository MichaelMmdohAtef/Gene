import 'dart:io';

import 'package:Gene/models/message_model.dart';
import 'package:Gene/shared/components/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class FileChatWidget extends StatefulWidget {
  MessageModel model;
  bool rtl=false;
  FileChatWidget({super.key,required this.model, this.rtl=false});

  @override
  State<FileChatWidget> createState() => _FileChatWidgetState();
}

class _FileChatWidgetState extends State<FileChatWidget> {

  bool downloading=false;
  bool fileExists=false;
  double progress=0;
  String fileName='';
  String filePath='';
  late var getPathFile;
  late CancelToken cancelToken;

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          checkFileExist(nameOfFile: widget.model.nameOfDocument!);
          DateTime date=DateTime.parse(widget.model.date.toString());
          return InkWell(
            onTap: () {
              if(fileExists){
                openFile(nameOfFile: widget.model.nameOfDocument!);
              }
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ///container of document
                  Container(
                    decoration: BoxDecoration(
                      color: defaultBlueAccentColor,
                      borderRadius: BorderRadius.all(Radius.circular(7)),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                ///name of document
                                Text(
                                  "${widget.model.nameOfDocument}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),

                                Row(
                                  children: [
                                    ///size of file
                                    Text("${widget.model.size}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.6),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                      child: Container(
                                        child: CircleAvatar(
                                          radius: 2,
                                          backgroundColor: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                    ),

                                    ///extension of file
                                    Expanded(
                                      child: Text(
                                        "${widget.model.extension!.toUpperCase().toString()}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.6),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child:fileExists?
                            Container():
                            downloading?
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 3,
                                  value: progress,
                                  backgroundColor: defaultBlueDarkColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(defaultBinkColor),
                                ),
                                Text("${(progress*100).toStringAsFixed(2)}",style: TextStyle(
                                    color: defaultBlueDarkColor
                                ),)
                              ],
                            ):IconButton(
                                onPressed: () {
                                  startDownloadFile(url: widget.model.filePath!);
                                },
                                icon: Icon(Icons.save_alt_rounded)
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  bottomStart:widget.rtl?Radius.circular(0): Radius.circular(15),
                ),
              ),
            ),
          );
        }
    );
  }

  ///check file exist
  checkFileExist({
    required String nameOfFile,
  })async{
    fileName=nameOfFile;
    var storagePath=await getPathOfFiles();
    filePath='$storagePath/$fileName';
    bool fileExistCheck=await File(filePath).exists();
    setState(() {
      fileExists=fileExistCheck;
    });
  }

  ///create directory if not exist
  getPathOfFiles()async{
    final Directory? tempDirectory=await getExternalStorageDirectory();
    final filePath=Directory("${tempDirectory!.path}/files");
    if(await filePath.exists()){
      return filePath.path;
    }else{
      filePath.create(recursive: true);
      return filePath.path;
    }
  }

  ///on cancel state but not in use
  _cancelTokenFun(){
    cancelToken.cancel();
    setState(() {
      downloading=false;
    });
  }

  ///download file
  startDownloadFile({required String url})async{
    cancelToken=CancelToken();
    var storage=await getPathOfFiles();
    filePath='$storage/$fileName';
    setState(() {
      downloading=true;
      progress=0.0;
    });
    try{
      await Dio().download(url,filePath,onReceiveProgress: (count, total) {
        setState(() {
          progress=count/total;
        });
      },cancelToken: _cancelTokenFun());
      setState(() {
        downloading=false;
        fileExists=true;
      });
    }catch(error){
      setState(() {
        downloading=false;
      });
    }
  }

  ///open file
  openFile({
    required String nameOfFile
  })async{
    var storage=await getPathOfFiles();
    filePath='$storage/$nameOfFile';
    OpenFile.open(filePath);
  }




}
