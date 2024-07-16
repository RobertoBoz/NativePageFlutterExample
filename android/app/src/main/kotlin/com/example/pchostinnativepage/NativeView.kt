package com.example.pchostinnativepage
import android.widget.Button
import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import android.widget.LinearLayout
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.embedding.engine.FlutterEngine



internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val textView: TextView
    private val linearLayout: LinearLayout
    private lateinit var eventChannel: EventChannel
    private lateinit var rfHandler: RfHandler
    

    override fun getView(): View {
        return linearLayout
    }


    override fun dispose() {}

    init {
        
        val engine = MainActivity.Companion.flutterEngineGlobal
        if (engine != null) {
            val messenger = engine.dartExecutor.binaryMessenger
            eventChannel = EventChannel(messenger, "channel/rf")
            rfHandler = RfHandler()
            eventChannel.setStreamHandler(rfHandler)
        }

        
        linearLayout = LinearLayout(context)
        linearLayout.orientation = LinearLayout.VERTICAL
        
        textView = TextView(context)
        textView.textSize = 10f
        textView.setBackgroundColor(Color.BLUE)
        textView.text = "Rendered on a native Android view (id: $id)"
        
        val button = Button(context)
        button.text = "+"
        button.setBackgroundColor(Color.RED)
        button.setOnClickListener { buttonAction() }

        linearLayout.addView(textView)
        linearLayout.addView(button)
    }

    private fun buttonAction() {
        rfHandler.sendData(data = 1)
    }



    class RfHandler : StreamHandler {
        private var eventSink: EventSink? = null

        override fun onListen(arguments: Any?, eventSink: EventSink) {
            this.eventSink = eventSink
        }

        override fun onCancel(arguments: Any?){
            eventSink?.endOfStream()
            eventSink = null
        }

        fun sendData(data: Any) {
            println(data)
            eventSink?.success(data)
        }
    }
}