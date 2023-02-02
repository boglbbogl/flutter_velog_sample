package com.tyger.flutter_velog_sample
 import android.os.Bundle
 import android.os.PersistableBundle
 import android.util.Log
 import androidx.annotation.NonNull
 import io.flutter.embedding.android.FlutterActivity
 import io.flutter.embedding.engine.FlutterEngine
 import io.flutter.plugin.common.StringCodec
 import io.flutter.plugin.common.BasicMessageChannel
 import io.flutter.plugins.GeneratedPluginRegistrant
 import java.util.concurrent.TimeUnit

class MainActivity: FlutterActivity() {

      private lateinit var appLifeCycle: BasicMessageChannel<String>

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
     }

      override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
          super.onCreate(savedInstanceState, persistentState)
      }

      override fun onResume() {
          super.onResume()
          appLifeCycle.send("lifeCycleStateWithResumed")
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
        Log.d("AppLifeCycle", "1")
          appLifeCycle.send("lifeCycleStateWithDetached")
        Log.d("AppLifeCycle", "2")
          Log.d("AppLifeCycle", "3")

          super.onDestroy()
      }
}
