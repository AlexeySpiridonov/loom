package com.example.wifi_app;

import static android.net.wifi.WifiManager.*;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.MacAddress;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkRequest;
import android.net.NetworkSpecifier;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.net.wifi.WifiNetworkSpecifier;
import android.net.wifi.WifiNetworkSuggestion;
import android.os.Build;
import android.os.PatternMatcher;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.util.ArrayList;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("getBatteryLevel")) {
                        connectToWifi(call.argument("login"), call.argument("password"), result);

                        //result.success(res);
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }



    private void sendAnswer() {

    }





    private void connectToWifi(String ssid, String password, MethodChannel.Result result)
    {
        WifiManager wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            try {
                WifiConfiguration wifiConfig = new WifiConfiguration();
                wifiConfig.SSID = "\"" + ssid + "\"";
                wifiConfig.preSharedKey = "\"" + password + "\"";
                int netId = wifiManager.addNetwork(wifiConfig);
                wifiManager.disconnect();
                wifiManager.enableNetwork(netId, true);
                wifiManager.reconnect();
                result.success("Wifi successful connect on Android < 10 version");
            } catch ( Exception e) {
                result.success(e.getMessage());
                //e.printStackTrace();
            }
        } else {
            WifiNetworkSpecifier wifiNetworkSpecifier = new WifiNetworkSpecifier.Builder()
                    .setSsid( ssid )
                    .setWpa2Passphrase(password)
                    .build();

            NetworkRequest networkRequest = new NetworkRequest.Builder()
                    .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
                    .setNetworkSpecifier(wifiNetworkSpecifier)
                    .build();

            ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);

            ConnectivityManager.NetworkCallback networkCallback = new ConnectivityManager.NetworkCallback() {
                @Override
                public void onAvailable(Network network) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        connectivityManager.bindProcessToNetwork(network);
                    } else {
                        ConnectivityManager.setProcessDefaultNetwork(network);
                    }

                    Toast.makeText(
                            getApplicationContext(),
                            "Wifi successful connect on Android > 10 version",
                            Toast.LENGTH_LONG
                    ).show();
                    //result.success("Wifi successful connect on Android > 10 version");
                    super.onAvailable(network);
                }

                @Override
                public void onLosing(@NonNull Network network, int maxMsToLive) {
                    Toast.makeText(
                            getApplicationContext(),
                            "Losing connection",
                            Toast.LENGTH_LONG
                    ).show();
                    //result.success("Losing connection");
                    super.onLosing(network, maxMsToLive);
                }

                @Override
                public void onLost(Network network) {
                    Toast.makeText(
                            getApplicationContext(),
                            "Lost connection",
                            Toast.LENGTH_LONG
                    ).show();
                    //result.success("Lost connection");
                    super.onLost(network);
                }

                @Override
                public void onUnavailable() {
                    Toast.makeText(
                            getApplicationContext(),
                            "Unavailable connection",
                            Toast.LENGTH_LONG
                    ).show();
                    //result.success("Unavailable connection");
                    super.onUnavailable();
                }
            };

            connectivityManager.requestNetwork(networkRequest,networkCallback);
            result.success("Connected...");
        }
    }
}