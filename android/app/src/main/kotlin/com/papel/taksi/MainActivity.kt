package com.papel.taksi

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.os.Bundle

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.papel.taksi/payment"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "launchSoftPOS" -> {
                    val paymentSessionToken = call.argument<String>("paymentSessionToken")
                    val amount = call.argument<Double>("amount")

                    if (paymentSessionToken != null && amount != null) {
                        launchSoftPOS(paymentSessionToken, amount)
                        result.success(true)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Missing required parameters", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleDeepLink(intent)
    }

    private fun launchSoftPOS(sessionToken: String, amount: Double) {
        try {
            // TODO: Implement actual SoftPOS deeplink
            // For now, this is a placeholder
            val intent = Intent(Intent.ACTION_VIEW).apply {
                data = android.net.Uri.parse("softpos://payment?sessionToken=$sessionToken&amount=$amount")
                // Package name for Payneos SoftPOS app
                setPackage("com.provisionpay.softpos.papel")
            }
            startActivity(intent)
        } catch (e: Exception) {
            // If SoftPOS app is not installed, handle gracefully
            e.printStackTrace()
        }
    }

    private fun handleDeepLink(intent: Intent?) {
        val data = intent?.data
        if (data != null && data.scheme == "papeltaksi") {
            // Handle payment callback from SoftPOS
            val path = data.path
            val transactionId = data.getQueryParameter("transactionId")
            val status = data.getQueryParameter("status")

            // TODO: Send callback to Flutter layer
            flutterEngine?.let {
                MethodChannel(it.dartExecutor.binaryMessenger, CHANNEL).invokeMethod(
                    "onPaymentCallback",
                    mapOf(
                        "transactionId" to transactionId,
                        "status" to status
                    )
                )
            }
        }
    }
}
