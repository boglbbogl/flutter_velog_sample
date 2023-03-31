import UIKit
import Flutter
import WebKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    var appLifeCycle: FlutterBasicMessageChannel!
    var deviceNameBasicChannel : FlutterBasicMessageChannel!

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let uiWebview = UiWebViewFactory()
    let wkWebview = WkWebViewFactory()
      
    let closedChannel = FlutterMethodChannel(name: "tyger/closed",
                                             binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger)
      
    self.registrar(forPlugin: "WebviewUiPlugin")?.register(uiWebview, withId:"plugins/swift/uiWebview")
    self.registrar(forPlugin: "WebviewWkPlugin")?.register(wkWebview, withId:"plugins/swift/wkWebview")

    appLifeCycle = FlutterBasicMessageChannel(
            name: "appLifeCycle",
            binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger,
            codec: FlutterStringCodec.sharedInstance())
      
    deviceNameBasicChannel = FlutterBasicMessageChannel(
        name:"tyger/device/name",
        binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger,
        codec: FlutterStringCodec.sharedInstance())
      
     
    FlutterEventChannel(name: "tyger/battery/state", binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger).setStreamHandler(BatteryStateStreamHandler())
      
    closedChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        if(call.method == "close"){
            result("System Exit !!")
            // exit(0)
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend)) 
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
                exit(0)
            }
        }else{
            result("Not Call Method !!")
        }
  })
      
      let countToastChannel = FlutterMethodChannel(name: "tyger/count/toast", binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger)
      
      var count : Int = 0
      var selectCount : Int = 1
      
      FlutterMethodChannel(name: "tyger/count/app",binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger).setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          if let args = call.arguments as? Dictionary<String, Any>,
             let param = args["count"] as? Int {
              selectCount = param
          }
          switch call.method {
          case "reset":
              count = 0
              result(count)
              break
          case "increment":
              count += selectCount
              result(count)
              countToastChannel.invokeMethod("Count : \(count)     Argument : \(selectCount)",arguments: nil)
              break
          case "decrement":
              count -= selectCount
              result(count)
              countToastChannel.invokeMethod("Count : \(count)     Argument : \(selectCount)",arguments: nil)
              break
          default:
              break
          }
    })
      
      FlutterMethodChannel(name: "tyger/battery/level", binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger).setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          if(call.method == "level"){
              self?.receiveBatteryLevel(result: result)
              self?.deviceNameBasicChannel.sendMessage(UIDevice.current.name)
          }
      })
      
      

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult) {
     let device = UIDevice.current
     device.isBatteryMonitoringEnabled = true
     if device.batteryState == UIDevice.BatteryState.unknown {
         result(nil)
     } else {
         result(Int(device.batteryLevel * 100))
     }
   }
   
    override func applicationWillTerminate(_ application: UIApplication) {
        appLifeCycle.sendMessage("lifeCycleStateWithDetached")
        sleep(2)
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        appLifeCycle.sendMessage("lifeCycleStateWithResumed")
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        appLifeCycle.sendMessage("lifeCycleStateWithInactive")
    }
}

class BatteryStateStreamHandler: NSObject, FlutterStreamHandler {
    
    var events : FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        batteryStateDidChange()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.batteryStateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: nil)
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.events = nil
        return nil
    }
    
    @objc private func batteryStateDidChange(){
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        switch device.batteryState {
        case UIDevice.BatteryState.unplugged, UIDevice.BatteryState.unknown:
            self.events!(false)
            break
        default:
            self.events!(true)
            break
        }
    }
}

class WkWebViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger?

    override init(){
        super.init()
    }

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FlutterWkWebView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}


class FlutterWkWebView: NSObject, FlutterPlatformView {
    let webView = WKWebView()

    func view() -> UIView {
        return webView
    }

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        webView.load(NSURLRequest(url: NSURL(string: "https://youtube.com")! as URL) as URLRequest)
    }

}



class UiWebViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger?

    override init(){
        super.init()
    }

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FlutterUiWebView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}


class FlutterUiWebView: NSObject, FlutterPlatformView {
   private var _nativeWebView: UIWebView

   func view() -> UIView {
       return _nativeWebView
   }

   init(
       frame: CGRect,
       viewIdentifier viewId: Int64,
       arguments args: Any?,
       binaryMessenger messenger: FlutterBinaryMessenger?
   ) {
       _nativeWebView = UIWebView()
       _nativeWebView.loadRequest(NSURLRequest(url: NSURL(string: "https://youtube.com")! as URL) as URLRequest)

   }
}
