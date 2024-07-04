import Flutter
import UIKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var eventChannel: FlutterEventChannel 
    private var counterHandler: CounterHandler

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
       eventChannel  = FlutterEventChannel(name: "channel/counter", binaryMessenger: messenger!) // timeHandlerEvent is event name
       counterHandler = CounterHandler()
       eventChannel.setStreamHandler(counterHandler)

        super.init()

        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){        
         _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
        let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
            button.backgroundColor = UIColor.red
            button.setTitle("Name your Button ", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        _view.addSubview(nativeLabel)
        _view.addSubview(button)
    }

    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        
        
        counterHandler.sendData(data: 1) 
    }


    class CounterHandler: NSObject, FlutterStreamHandler {
        // Handle events on the main thread.                
       private var eventSink: FlutterEventSink?
    
        func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
            self.eventSink = eventSink
            return nil
        }
        
        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            eventSink = nil
            return nil
        }
        
        func sendData(data: Any) {
            print(data)
            if let eventSink = eventSink {
                eventSink(data)
            }
        }
    }

}

 


