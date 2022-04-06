package com.ocwvar.flutter_playground

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL = "cross-platform channel"
private const val METHOD_SYSTEM_VERSION = "METHOD_SYSTEM_VERSION"

class MainActivity: FlutterActivity() {

    /*

    Dart	                        Kotlin
    null	                        null
    bool	                        Boolean
    int	                            Int
    int, if 32 bits not enough	    Long
    double	                        Double
    String	                        String
    Uint8List	                    ByteArray
    Int32List	                    IntArray
    Int64List	                    LongArray
    Float32List	                    FloatArray
    Float64List	                    DoubleArray
    List	                        List
    Map	                            HashMap

     */

    /**
     * Hook for subclasses to easily configure a `FlutterEngine`.
     *
     *
     * This method is called after [.provideFlutterEngine].
     *
     *
     * All plugins listed in the app's pubspec are registered in the base implementation of this
     * method unless the FlutterEngine for this activity was externally created. To avoid the
     * automatic plugin registration for implicitly created FlutterEngines, override this method
     * without invoking super(). To keep automatic plugin registration and further configure the
     * FlutterEngine, override this method, invoke super(), and then configure the FlutterEngine as
     * desired.
     */
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                val methodName: String = call.method ?: ""
                when(methodName) {
                    METHOD_SYSTEM_VERSION -> {
                        result.success(getSystemVersion())
                    }

                    else -> {
                        result.error("01", "method name not found -> $methodName", null)
                    }
                }
            }

    }

    private fun getSystemVersion(): String {
        return "Android with SDK ${Build.VERSION.SDK_INT}"
    }
}
