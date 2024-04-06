import 'package:diamond_dial_fab/diamond_border.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Gene/library/fluid_nav_bar/linear_point_curve.dart';
import 'package:Gene/shared/components/constants.dart';


typedef void FluidNavBarButtonTappedCallback();

/// An interactive button within [FluidNavBar]
///
/// This class is not used in isolation. It is created by
/// fluid navigation bar widget according to [FluidNavBarIcon] definition.
///
/// See also:
///
///  * [FluidNavBar]
///  * [FluidNavBarIcon]

class FluidNavBarItemLocal extends StatefulWidget {
  static Size?  nominalExtent;

  /// The path of the SVG asset
  final String? svgPath;

  // The icon data
  final IconData? icon;

  /// Flag to know if this item is active or not
  final bool selected;

  /// The color used to paint the SVG when the item is active
  final Color selectedForegroundColor;

  /// The color used to paint the SVG when the item is inactive
  final Color unselectedForegroundColor;

  /// The background color of the item
  final Color backgroundColor;

  /// The temporary SVG scale used when the item pop
  final double scaleFactor;

  /// The callback used when the item is tapped
  final FluidNavBarButtonTappedCallback onTap;

  /// The delay factor of the animations ( < 1 is faster, > 1 is slower)
  final double animationFactor;

  final String label;

  FluidNavBarItemLocal(
      this.svgPath,
      this.icon,
      this.selected,
      this.onTap,
      this.selectedForegroundColor,
      this.unselectedForegroundColor,
      this.backgroundColor,
      this.scaleFactor,
      this.animationFactor,
      this.label
      )   : assert(scaleFactor >= 1.0),
        assert(svgPath == null || icon == null,
        'Cannot provide both an iconPath and an icon.'),
        assert(!(svgPath == null && icon == null),
        'An iconPath or an icon must be provided.');

  @override
  State createState() {
    return _FluidNavBarItemLocalState(selected);
  }
}

class _FluidNavBarItemLocalState extends State<FluidNavBarItemLocal>
    with SingleTickerProviderStateMixin {
  static const double _activeOffset = 20;
  static const double _defaultOffset = 0;
  static const double _iconSize = 30;

  bool _selected;

  late AnimationController _animationController;
  late Animation<double> _activeColorClipAnimation;
  late Animation<double> _yOffsetAnimation;
  late Animation<double> _activatingAnimation;
  late Animation<double> _inactivatingAnimation;

  _FluidNavBarItemLocalState(this._selected);

  @override
  void initState() {
    super.initState();

    double waveRatio = 0.28;
    _animationController = AnimationController(
      duration: Duration(milliseconds: (1600 * widget.animationFactor).toInt()),
      reverseDuration:
      Duration(milliseconds: (1000 * widget.animationFactor).toInt()),
      vsync: this,
    )..addListener(() => setState(() {}));

    _activeColorClipAnimation =
        Tween<double>(begin: 0.0, end: _iconSize).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.25, 0.38, curve: Curves.easeOut),
          reverseCurve: Interval(0.7, 1.0, curve: Curves.easeInCirc),
        ));

    var _animation = CurvedAnimation(
        parent: _animationController,
        curve: LinearPointCurve(waveRatio, 0.0));

    _yOffsetAnimation = Tween<double>(begin: _defaultOffset, end: _activeOffset)
        .animate(CurvedAnimation(
      parent: _animation,
      curve: ElasticOutCurve(0.38),
      reverseCurve: Curves.easeInCirc,
    ));

    var activatingHalfTween = Tween<double>(begin: 1, end: widget.scaleFactor);
    _activatingAnimation = TweenSequence([
      TweenSequenceItem(tween: activatingHalfTween, weight: 50.0),
      TweenSequenceItem(
          tween: ReverseTween<double>(activatingHalfTween), weight: 50.0),
    ]).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.0, 0.3),
    ));
    _inactivatingAnimation = ConstantTween<double>(1.0).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.3, 1.0),
    ));

    _startAnimation();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (oldWidget.selected != _selected) {
      setState(() {
        _selected = widget.selected;
      });
      _startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {

    FluidNavBarItemLocal.nominalExtent= Size(64,64);
        // MediaQuery.sizeOf(context).width*0.1635,
        // MediaQuery.sizeOf(context).height*0.1090);

    final scaleAnimation =
    _selected ? _activatingAnimation : _inactivatingAnimation;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child:_selected?
      Padding(
        padding:EdgeInsetsDirectional.only(
          start: 5,
            bottom:MediaQuery.sizeOf(context).height * 0.01295
        ),
        child: Container(
          // color: Colors.red,
            height:MediaQuery.sizeOf(context).height*0.1090,
            width:MediaQuery.sizeOf(context).width*0.1635,
          // constraints: BoxConstraints.tight(ne!),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                // margin: EdgeInsets.all(ne.width / 2 - 28),
                width: MediaQuery.sizeOf(context).width*0.1401,
                height: MediaQuery.sizeOf(context).height*0.06479,
                decoration: ShapeDecoration(
                  color: widget.backgroundColor,
                  shape:DiamondBorder(
                    cornerRadius: 6,
                  ),
                ),
                transform: Matrix4.translationValues(0, -_yOffsetAnimation.value, 0),
                child: Stack(children: <Widget>[
                  Container(
                    color:widget.selected?Color(0xffFE1F8F):widget.backgroundColor,
                    alignment: Alignment.center,
                    child: widget.icon == null
                        ? SvgPicture.asset(
                      widget.svgPath!,
                      color: widget.unselectedForegroundColor,
                      width: MediaQuery.sizeOf(context).width*0.05714,
                      height:MediaQuery.sizeOf(context).height*0.0323*scaleAnimation.value,
                      colorBlendMode: BlendMode.srcIn,
                    )
                        : Container(
                      width: MediaQuery.sizeOf(context).width*0.05714,
                      height:MediaQuery.sizeOf(context).height*0.0323*scaleAnimation.value,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(
                          widget.icon,
                          color: widget.unselectedForegroundColor,
                          // size: 24*scaleAnimation.value,
                              // * scaleAnimation.value,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    color:widget.selected?Color(0xffFE1F8F):widget.backgroundColor,
                    child: ClipRect(
                      clipper: _SvgPictureClipper(
                          _activeColorClipAnimation.value * scaleAnimation.value),
                      child: widget.icon == null
                          ? SvgPicture.asset(
                        widget.svgPath!,
                        color: widget.selectedForegroundColor,
                        width: MediaQuery.sizeOf(context).width*0.05714,
                        height: MediaQuery.sizeOf(context).height*0.0323 * scaleAnimation.value,
                        colorBlendMode: BlendMode.srcIn,
                      )
                          : Container(
                              width: MediaQuery.sizeOf(context).width*0.05714,
                              height:MediaQuery.sizeOf(context).height * 0.0323 * scaleAnimation.value,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Icon(
                                  widget.icon,
                                  color: widget.selectedForegroundColor,
                                  // size: 24*scaleAnimation.value,
                                  // * scaleAnimation.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height:MediaQuery.sizeOf(context).height*0.0183 ,
                  width: MediaQuery.sizeOf(context).width*0.1565,
                  child: FittedBox(
                    alignment: Alignment.center,
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color:widget.selected? defaultWhiteColor: Color(0xffB6F4FE),
                      height: 1.125,
                      fontSize: 16,
                    ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ):
      Padding(
        padding:  EdgeInsets.only(
          top:MediaQuery.sizeOf(context).height * 0.0151,
          bottom:MediaQuery.sizeOf(context).height * 0.01295
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width*0.1635,
          height: MediaQuery.sizeOf(context).height*0.05615,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.tight(Size(
                MediaQuery.sizeOf(context).width,
                    MediaQuery.sizeOf(context).height*0.0700,)),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                ),
                // transform: Matrix4.translationValues(0, -_yOffsetAnimation.value-0, 0),
                child: Stack(children: <Widget>[
                  Container(
                    color:widget.selected?Color(0xffFE1F8F):widget.backgroundColor,
                    alignment: Alignment.topCenter,
                    child: widget.icon == null
                        ? SvgPicture.asset(
                      widget.svgPath!,
                      alignment: Alignment.center,
                      color: widget.unselectedForegroundColor,
                      // width: MediaQuery.sizeOf(context).width*0.05714,
                      height:MediaQuery.sizeOf(context).height*0.0323*scaleAnimation.value,
                      colorBlendMode: BlendMode.srcIn,
                    )
                        : Icon(
                      widget.icon,
                      color: widget.unselectedForegroundColor,
                      size: _iconSize*scaleAnimation.value* scaleAnimation.value,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    color:widget.selected?Color(0xffFE1F8F):widget.backgroundColor,
                    child: ClipRect(
                      clipper: _SvgPictureClipper(
                          _activeColorClipAnimation.value * scaleAnimation.value),
                      child: widget.icon == null
                          ? SvgPicture.asset(
                        widget.svgPath!,
                        alignment: Alignment.center,
                        color: widget.selectedForegroundColor,
                        // width: MediaQuery.sizeOf(context).width*0.05714,
                        height: MediaQuery.sizeOf(context).height*0.0323 * scaleAnimation.value,
                        colorBlendMode: BlendMode.srcIn,
                      )
                          : Icon(
                        widget.icon,
                        color: widget.selectedForegroundColor,
                        size: _iconSize * scaleAnimation.value,
                      ),
                    ),
                  ),
                ]),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height:MediaQuery.sizeOf(context).height*0.0183 ,
                  width: MediaQuery.sizeOf(context).width*0.1565,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:widget.selected? defaultWhiteColor: Color(0xffB6F4FE),
                        height: 1.125,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _startAnimation() {
    if (_selected) {
      _animationController.forward();
    } else {
      // Required otherwise the CurvedAnimation uses the standard curve instead of the reverseCurve
      // if the animation is not completed: so set it as completed before calling reverse.
      _animationController.value = 1.0;
      _animationController.reverse();
    }
  }
}

class _SvgPictureClipper extends CustomClipper<Rect> {
  final double height;

  _SvgPictureClipper(this.height);

  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(size.topLeft(Offset.zero),
        size.topRight(Offset.zero) + Offset(0, height));
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
