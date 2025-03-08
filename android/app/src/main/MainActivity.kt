package com.example.offline_pay

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.offlinepay/ussd"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "dialUSSD") {
                val ussdCode = call.argument<String>("ussdCode") ?: return@setMethodCallHandler
                val phone = call.argument<String>("phone") ?: ""
                val amount = call.argument<String>("amount") ?: ""
                val completeUssdCode = "$ussdCode?$phone&$amount"

                val intent = Intent(Intent.ACTION_DIAL)
                intent.data = Uri.parse("tel:$completeUssdCode")
                startActivity(intent)
                result.success("USSD Dialed")
            } else {
                result.notImplemented()
            }
        }
    }
}
