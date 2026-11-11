package com.example.calm_steps

import android.Manifest
import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "calm_steps/reminders").setMethodCallHandler { call, result ->
            val manager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            val alarms = getSystemService(ALARM_SERVICE) as AlarmManager
            val intent = Intent(this, ReminderReceiver::class.java)
            if (call.method == "cancel") {
                val pending = PendingIntent.getBroadcast(this, 1, intent, PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE)
                if (pending != null) { alarms.cancel(pending); pending.cancel() }
                manager.cancel(1)
                result.success(null)
            } else if (call.method == "schedule") {
                if (Build.VERSION.SDK_INT >= 33 && checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
                    requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), 100)
                    result.error("PERMISSION", "Allow notifications, then press Schedule again.", null)
                } else if (!manager.areNotificationsEnabled()) {
                    result.error("PERMISSION", "Enable Calm Steps notifications in system Settings.", null)
                } else if (Build.VERSION.SDK_INT >= 31 && !alarms.canScheduleExactAlarms()) {
                    startActivity(Intent(Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM, android.net.Uri.parse("package:$packageName")))
                    result.error("ALARM_PERMISSION", "Allow alarms and reminders, return and schedule again.", null)
                } else {
                    if (Build.VERSION.SDK_INT >= 26) { manager.createNotificationChannel(NotificationChannel("meditation", "Meditation reminders", NotificationManager.IMPORTANCE_HIGH)) }
                    intent.putExtra("title", call.argument<String>("title"))
                    val pending = PendingIntent.getBroadcast(this, 1, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
                    alarms.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, call.argument<Number>("time")!!.toLong(), pending)
                    result.success(null)
                }
            } else { result.notImplemented() }
        }
    }
}
