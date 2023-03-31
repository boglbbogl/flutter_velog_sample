package com.tyger.flutter_velog_sample

 import android.app.admin.DevicePolicyManager
 import android.bluetooth.BluetoothClass.Device
 import android.content.BroadcastReceiver
 import android.content.Context
 import android.content.Intent
 import android.content.IntentFilter
 import android.os.BatteryManager
 import android.os.Build
 import android.util.Log
 import androidx.annotation.NonNull
 import io.flutter.embedding.android.FlutterActivity
 import io.flutter.embedding.engine.FlutterEngine
 import io.flutter.plugin.common.StringCodec
 import io.flutter.plugin.common.BasicMessageChannel
 import io.flutter.plugin.common.EventChannel
 import io.flutter.plugin.common.EventChannel.EventSink
 import io.flutter.plugin.common.MethodChannel
 import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private lateinit var appLifeCycle: BasicMessageChannel<String>
    private val closedChannel = "tyger/closed"
    private lateinit var deviceNameChannel : BasicMessageChannel<String>

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        var count : Int = 0

        val countToastChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "tyger/count/toast")

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "tyger/count/app").setMethodCallHandler {
                call, result ->

            when(call.method){
                "reset" -> {
                    count = 0
                    result.success(count)
                }
                "increment" ->{
                    val args : Int? = call.argument<Int>("count")
                    count += args!!
                    result.success(count)
                    countToastChannel.invokeMethod("Count : $count     Argument : $args", null)
                }
                "decrement" -> {
                    val args : Int? = call.argument<Int>("count")
                    count -= args!!
                    result.success(count)
                    countToastChannel.invokeMethod("Count : $count     Argument : $args", null)
                }
                else -> {
                    result.success(null)
                }
            }

        }

        appLifeCycle = BasicMessageChannel(
              flutterEngine.dartExecutor.binaryMessenger,
              "appLifeCycle",
              StringCodec.INSTANCE)

        appLifeCycle.setMessageHandler { message, reply ->
              Log.d("AppLifeCycle", "AppLifeCycle Message = $message")
              reply.reply("From Android Life Cycle")
          }

        deviceNameChannel = BasicMessageChannel(flutterEngine.dartExecutor.binaryMessenger,
            "tyger/device/name",
            StringCodec.INSTANCE)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, closedChannel).setMethodCallHandler{
            call, result ->
            if(call.method == "close"){
                result.success("System Finish !!")
                finish()
            }else{
                result.success("Not Call Method !!")
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "tyger/battery/level").setMethodCallHandler{
            call, result ->
            if(call.method == "level"){
                deviceNameChannel.send(Build.MODEL)
                val level = getBatteryLevel()
                result.success(level)
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "tyger/battery/state").setStreamHandler(BatteryStateEventChannel(context))
     }

    private fun getBatteryLevel(): Int {
    val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    val batteryLevel : Int = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    return batteryLevel
  }

    override fun onPause() {
          super.onPause()
          appLifeCycle.send("lifeCycleStateWithInactive")
      }

      override fun onStop() {
          super.onStop()
          appLifeCycle.send("lifeCycleStateWithStop")
      }

      override fun onRestart() {
          super.onRestart()
          appLifeCycle.send("lifeCycleStateWithRestart")
      }

      override fun onDestroy() {           
          appLifeCycle.send("lifeCycleStateWithDetached")
          super.onDestroy()
      }
}

class BatteryStateEventChannel(context: Context) : EventChannel.StreamHandler {

    private var connectReceiver: BroadcastReceiver? = null
    private var disConnectReceiver: BroadcastReceiver? = null
    private var context: Context = context

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        connectReceiver = connected(events!!)
        disConnectReceiver = disConnected(events!!)
        context.registerReceiver(connectReceiver, IntentFilter(Intent.ACTION_POWER_CONNECTED))
        context.registerReceiver(disConnectReceiver, IntentFilter(Intent.ACTION_POWER_DISCONNECTED))
    }

    private  fun connected(events: EventChannel.EventSink) : BroadcastReceiver? {
        return  object : BroadcastReceiver(){
            override fun onReceive(context: Context?, intent: Intent) {
                events.success(true)
            }
        }
    }

    private  fun disConnected(events: EventChannel.EventSink) : BroadcastReceiver? {
        return  object : BroadcastReceiver(){
            override fun onReceive(context: Context?, intent: Intent) {
                events.success(false)
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        context.unregisterReceiver(connectReceiver)
        context.unregisterReceiver(disConnectReceiver)
        connectReceiver = null
        disConnectReceiver = null
    }

}