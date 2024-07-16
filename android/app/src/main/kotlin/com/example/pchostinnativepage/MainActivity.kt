package com.example.pchostinnativepage

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    companion object{        
        var flutterEngineGlobal : FlutterEngine? = null
      }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngineGlobal = flutterEngine;
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-rf>", 
                                      NativeViewFactory())
    }
}
