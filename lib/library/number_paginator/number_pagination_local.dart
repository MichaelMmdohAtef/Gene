library number_pagination;

import 'package:flutter/material.dart';
import 'package:Gene/shared/components/constants.dart';

class NumberPaginationLocal extends StatefulWidget {
  /// Creates a NumberPagination widget.
  const NumberPaginationLocal({
    required this.onPageChanged,
    required this.pageTotal,
    this.threshold = 10,
    this.pageInit = 1,
    this.colorPrimary = Colors.black,
    this.colorSub = Colors.white,
    this.controlButton,
    this.iconToFirst,
    this.iconPrevious,
    this.iconNext,
    this.iconToLast,
    this.fontSize = 15,
    this.fontFamily,
    this.noNumber=false,
  });

  ///Trigger when page changed
  final Function(int) onPageChanged;

  ///End of numbers.
  final int pageTotal;

  final bool noNumber;

  ///Page number to be displayed first
  final int pageInit;

  ///Numbers to show at once.
  final int threshold;

  ///Color of numbers.
  final Color colorPrimary;

  ///Color of background.
  final Color colorSub;

  ///to First, to Previous, to next, to Last Button UI.
  final Widget? controlButton;

  ///The icon of button to first.
  final Widget? iconToFirst;

  ///The icon of button to previous.
  final Widget? iconPrevious;

  ///The icon of button to next.
  final Widget? iconNext;

  ///The icon of button to last.
  final Widget? iconToLast;

  ///The size of numbers.
  final double fontSize;

  ///The fontFamily of numbers.
  final String? fontFamily;

  @override
  _NumberPaginationLocalState createState() => _NumberPaginationLocalState();

}

class _NumberPaginationLocalState extends State<NumberPaginationLocal> {
  late int rangeStart;
  late int rangeEnd;
  late int currentPage;
  late final Widget iconToFirst;
  late final Widget iconPrevious;
  late final Widget iconNext;
  late final Widget iconToLast;

  @override
  void initState() {
    this.currentPage = widget.pageInit;
    this.iconToFirst = widget.iconToFirst ?? Icon(Icons.first_page);
    this.iconPrevious = widget.iconPrevious ?? Icon(Icons.keyboard_arrow_left);
    this.iconNext = widget.iconNext ?? Icon(Icons.keyboard_arrow_right);
    this.iconToLast = widget.iconToLast ?? Icon(Icons.last_page);

    _rangeSet();

    super.initState();
  }

  // Widget _defaultControlButton(Widget icon) {
  //   return AbsorbPointer(
  //     child: TextButton(
  //       style: ButtonStyle(
  //         elevation: MaterialStateProperty.all<double>(5.0),
  //         padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
  //         minimumSize: MaterialStateProperty.all(Size(48, 48)),
  //         foregroundColor: MaterialStateProperty.all(widget.colorPrimary),
  //         backgroundColor: MaterialStateProperty.all(widget.colorSub),
  //       ),
  //       onPressed: () {},
  //       child: icon,
  //     ),
  //   );
  // }

  void _changePage(int page) {
    if (page <= 0) page = 1;

    if (page > widget.pageTotal) page = widget.pageTotal;

    setState(() {
      currentPage = page;
      _rangeSet();
      widget.onPageChanged(currentPage);
    });
  }

  void _rangeSet() {
    rangeStart = currentPage % widget.threshold == 0
        ? currentPage - widget.threshold
        : (currentPage ~/ widget.threshold) * widget.threshold;

    rangeEnd = rangeStart + widget.threshold;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        paginationIconButton(
          context: context,
          icon: Icons.arrow_back,
          onPressed:()=> _changePage(--currentPage),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.0345,
        ),
        if(!widget.noNumber)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ...List.generate(
            rangeEnd <= widget.pageTotal
                ? widget.threshold
                : widget.pageTotal % widget.threshold,
                (index) => Container(
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (currentPage - 1) % widget.threshold == index
                    ? Color(0xff1ADFFF).withOpacity(0.58)
                    : widget.colorSub,
              ),
                  child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => _changePage(index + 1 + rangeStart),
                  child: Container(
                  alignment: AlignmentDirectional.center,
                  width:MediaQuery.sizeOf(context).width * 0.07,
                  height:MediaQuery.sizeOf(context).height * 0.06319 ,
                  decoration: BoxDecoration(
                    color: (currentPage - 1) % widget.threshold == index
                        ? Color(0xff1ADFFF).withOpacity(0.58)
                        : widget.colorSub,
                    shape: BoxShape.circle,
                    boxShadow:[
                      if((currentPage - 1) % widget.threshold == index)
                        BoxShadow(
                          color:Color(0xff00899E).withOpacity(0.38),
                          offset: Offset(0.0, 0.0), //(x,y)
                          blurRadius: 20.0,
                          blurStyle: BlurStyle.inner,
                        ),
                      if((currentPage - 1) % widget.threshold == index)
                        BoxShadow(
                          color:defaultBlackColor.withAlpha(38),
                          offset: Offset(0.0, 0.0), //(x,y)
                          blurRadius: 10.0,
                          blurStyle: BlurStyle.outer,
                        ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '${index + 1 + rangeStart}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.3333,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize,
                        fontFamily: widget.fontFamily,
                        color: (currentPage - 1) % widget.threshold == index
                            ? defaultWhiteColor
                            : Color(0xff707070),
                      ),
                    ),
                  ),
                  ),
                ),
                ),
          ),
        ],
        ),

        Spacer(),
        SizedBox(
          width:MediaQuery.sizeOf(context).width * 0.0345,
        ),
        paginationIconButton(context: context,
            icon: Icons.arrow_forward,
            onPressed:()=> _changePage(++currentPage),
        ),
      ],
    );
  }

  paginationIconButton({
    Function()? onPressed,
    required BuildContext context,
    required IconData icon,
  })=>InkWell(
    onTap: onPressed,
    child: Container(
      height:MediaQuery.sizeOf(context).height* 0.0539,
      width:MediaQuery.sizeOf(context).height * 0.1168,
      decoration: BoxDecoration(
        color:widget.noNumber?Colors.transparent : defaultWhiteColor,
        shape: BoxShape.circle,
        boxShadow:widget.noNumber?null:[
          BoxShadow(
              color: defaultBlackColor.withAlpha(40),
              blurRadius: 10,
              blurStyle: BlurStyle.outer
          )
        ],
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Icon(icon,color: defaultBlueDarkColor),
      ),
    ),
  );

}
