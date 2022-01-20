import 'package:flutter/material.dart';

///Custom overlay
class CustomHintOverlay extends StatefulWidget {
  ///wrapped child widget, under which overlay will be shown
  final Widget child;
  ///overlay content widget
  final Widget overlayContent;
  CustomHintOverlay({ Key? key, required this.child, required this.overlayContent }) : super(key: key);

  @override
  CustomHintOverlayState createState() => CustomHintOverlayState();
}

class CustomHintOverlayState extends State<CustomHintOverlay> {
  ///layer link, that the overlay depends on
  final LayerLink layerLink = LayerLink();
  ///Entry of overlay
  OverlayEntry? overlayEntry;
  ///Offset of overlay regarding the wrapped child
  Offset? indicatorOffset;

  @override
  void initState() {
    indicatorOffset = Offset(0, 40);
    super.initState();
  }


  ///Method for show updating or showing overlay
  void showOverlay() {
    if (overlayEntry != null) {
      updateOverlay();
      return;
    }
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: 0.0,
              left: 0.0,
              child: Material(
                color: Colors.transparent,
                child: _OverlayWidget(
                    offset: indicatorOffset,
                    link: layerLink,
                    child: widget.overlayContent,
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: hideOverlay,
            )
          ],
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry!);
  }

  ///Method for rebuilding overlay
  void updateOverlay() {
    overlayEntry?.markNeedsBuild();
  }

  ///Method for removing overlay
  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: widget.child,
    );
  }
}

///Widget for containing overlay
class _OverlayWidget extends StatelessWidget {
  final LayerLink link;
  final Offset? offset;
  final Widget child;
  _OverlayWidget({Key? key, required this.link, required this.offset, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      offset: offset!,
      link: link,
      child: child,
    );
  }
}
