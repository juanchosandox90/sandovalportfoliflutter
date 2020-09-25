package com.sandoval.sandovalportfolio

import android.content.Context
import android.util.Log
import com.google.android.gms.common.GoogleApiAvailability
import com.huawei.hms.api.ConnectionResult
import com.huawei.hms.api.HuaweiApiAvailability
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.sandoval.sandovalporfolio/isHmsGmsAvailable"

    var concurrentContext = this@MainActivity.context

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isHmsAvailable") {
                result.success(isHmsAvailable())
            } else if (call.method == "isGmsAvailable") {
                result.success(isGmsAvailable())
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isHmsAvailable(): Boolean {
        var isAvailable = false
        val context: Context = concurrentContext
        if (context != null) {
            val result = HuaweiApiAvailability.getInstance().isHuaweiMobileNoticeAvailable(context)
            isAvailable = ConnectionResult.SUCCESS == result
        }
        Log.i("MainActivity", "isHmsAvailable: $isAvailable")
        return isAvailable
    }

    private fun isGmsAvailable(): Boolean {
        var isAvailable = false
        val context: Context = concurrentContext
        if (context != null) {
            val result = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(context)
            isAvailable = com.google.android.gms.common.ConnectionResult.SUCCESS == result
        }
        Log.i("MainActivity", "isHmsAvailable: $isAvailable")
        return isAvailable
    }

}
