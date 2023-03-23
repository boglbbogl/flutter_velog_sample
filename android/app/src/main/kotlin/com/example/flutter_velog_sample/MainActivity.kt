package com.tyger.flutter_velog_sample
 import android.os.Bundle
 import android.os.PersistableBundle
 import android.util.Log
 import androidx.annotation.NonNull
 import io.flutter.embedding.android.FlutterActivity
 import io.flutter.embedding.engine.FlutterEngine
 import io.flutter.plugin.common.StringCodec
 import io.flutter.plugin.common.BasicMessageChannel
 import io.flutter.plugin.common.MethodChannel
 import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private lateinit var appLifeCycle: BasicMessageChannel<String>
    private val closedChannel = "tyger/closed"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

          appLifeCycle = BasicMessageChannel(
              flutterEngine.dartExecutor.binaryMessenger,
              "appLifeCycle",
              StringCodec.INSTANCE)
          appLifeCycle.setMessageHandler { message, reply ->
              Log.d("AppLifeCycle", "AppLifeCycle Message = $message")
              reply.reply("From Android Life Cycle")
          }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, closedChannel).setMethodCallHandler{
            call, result ->
            if(call.method == "close"){
                result.success("System Finish !!")
                finish()
            }else{
                result.success("Not Call Method !!")
            }
        }
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
