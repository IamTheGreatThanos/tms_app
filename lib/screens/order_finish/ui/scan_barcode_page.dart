import 'dart:developer';

import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/widgets/camera/camera_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarcodePage extends StatefulWidget {
  const ScanBarcodePage({Key? key}) : super(key: key);

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodePageState();
}

class _ScanBarcodePageState extends State<ScanBarcodePage> {
  MobileScannerController controller = MobileScannerController();
  List<String> codes = [];

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey,
      //   centerTitle: true,
      //   title: const Text(
      //     "ФОТО",
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: SvgPicture.asset(
      //       "assets/images/svg/arrow_back.svg",
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                log("BARCODE CODE::::: $code");
                if (!codes.contains(code)) {
                  codes.add(code);

                  // controller.stop();
                  // context
                  //     .read<BlocGoodsList>()
                  //     .add(EventScanItem(code: code));

                }
              }
            },
          ),
          Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: CameraShaper(
                paintHeight: MediaQuery.of(context).size.height * 0.2,
                paintWidth: MediaQuery.of(context).size.width - 26,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 3,
            child: const Center(
              child: Text(
                'Отсканируйте штрих код на обороте коробки',
                style: TextStyle(color: ColorPalette.white, fontSize: 16),
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/images/svg/arrow_back.svg",
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Text(
                      "ФОТО",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/images/svg/thunder_lightning_notifications.svg",
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.toggleTorch();
                      },
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
