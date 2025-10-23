package com.example.vuzix_try

import io.flutter.embedding.android.FlutterActivity
import android.os.Build
import android.content.pm.PackageManager
import android.Manifest

class MainActivity : FlutterActivity() {
    override fun onStart() {
        super.onStart()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                requestPermissions(arrayOf(Manifest.permission.RECORD_AUDIO), 1)
            }
        }
    }
}