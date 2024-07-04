import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';


class NativePage extends StatelessWidget {
  
  NativePage({super.key});

  final viewType = '<platform-view-type>';
  final Map<String, dynamic> creationParams = <String, dynamic>{
  };

  @override
  Widget build(BuildContext context) {
    

    switch(defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformViewLink(
          surfaceFactory: (surfaceFactoryContext, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          }, 
          onCreatePlatformView: (PlatformViewCreationParams params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
            );
          }, 
          viewType: viewType
      );
      case TargetPlatform.iOS:
      
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),          
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}