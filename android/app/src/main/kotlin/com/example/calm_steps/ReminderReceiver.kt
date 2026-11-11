package com.example.calm_steps

import android.app.Notification
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build

class ReminderReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val builder = if (Build.VERSION.SDK_INT >= 26) Notification.Builder(context, "meditation") else Notification.Builder(context)
        val open = PendingIntent.getActivity(context, 0, Intent(context, MainActivity::class.java), PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val notification = builder.setSmallIcon(R.drawable.ic_reminder)
            .setContentTitle(intent.getStringExtra("title") ?: "Meditation Reminder")
            .setContentText("Time for your daily meditation!")
            .setContentIntent(open).setAutoCancel(true).build()
        (context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager).notify(1, notification)
    }
}
