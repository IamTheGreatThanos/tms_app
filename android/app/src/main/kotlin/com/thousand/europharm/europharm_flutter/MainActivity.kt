package com.thousand.europharm.europharm_flutter
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.yandex.mapkit.MapKitFactory;
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("5e34fc66-a948-4e55-837c-1253cd994b2f") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
