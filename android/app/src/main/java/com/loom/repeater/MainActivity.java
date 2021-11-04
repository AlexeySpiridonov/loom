package com.loom.repeater;

import static android.net.wifi.WifiManager.*;
import static android.provider.Settings.ACTION_WIFI_ADD_NETWORKS;
import static android.provider.Settings.EXTRA_WIFI_NETWORK_LIST;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.MacAddress;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkRequest;
import android.net.NetworkSpecifier;
import android.net.Uri;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.net.wifi.WifiNetworkSpecifier;
import android.net.wifi.WifiNetworkSuggestion;
import android.net.wifi.hotspot2.PasspointConfiguration;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcelable;
import android.os.PatternMatcher;
import android.provider.Settings;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "loom/wifi";

    MethodChannel.Result flutterResult;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("tryConnectToWifi")) {
                        String login = call.argument("login");
                        String password = call.argument("password");
                        flutterResult = result;
                        
                        if (password.length() > 0)
                            connectToWifi(login, password, result);
                        else
                            connectToLoom(login, result);

                    } else {
                        result.notImplemented();
                    }
                }
            );
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 545) {
            flutterResult.success("successful");
        } else {
            flutterResult.success("unsuccessful");
        }

    }

    private void connectToLoom(String ssid, MethodChannel.Result result)
    {
        WifiManager wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            try {
                WifiConfiguration wifiConfig = new WifiConfiguration();
                wifiConfig.SSID = "\"" + ssid + "\"";
                wifiConfig.allowedKeyManagement.set(WifiConfiguration.KeyMgmt.NONE);
                int netId = wifiManager.addNetwork(wifiConfig);
                wifiManager.disconnect();
                wifiManager.enableNetwork(netId, true);
                wifiManager.reconnect();
                result.success("successful");
            } catch ( Exception e) {
                result.success(e.getMessage());
                //e.printStackTrace();
            }
        } else {
            if (!Settings.System.canWrite(getApplicationContext())) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS, Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, 200);
            }
            Intent panelIntent = new Intent("android.settings.panel.action.WIFI");
            startActivityForResult(panelIntent, 545);
            //result.success("successful");
        }
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
                result.success("successful");
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

            final boolean[] isSuccessful = {false};

            ConnectivityManager.NetworkCallback networkCallback = new ConnectivityManager.NetworkCallback() {
                @Override
                public void onAvailable(Network network) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        connectivityManager.bindProcessToNetwork(network);
                    } else {
                        ConnectivityManager.setProcessDefaultNetwork(network);
                    }

                    isSuccessful[0] = true;
                    //flutterResult.success("successful");

                    //result.success("successful");
                    super.onAvailable(network);
                }
            };

            connectivityManager.requestNetwork(networkRequest,networkCallback);

            try {
<<<<<<< HEAD
                for (int i = 0; i < 200; i++) {
=======
                for (int i = 0; i < 20; i++) {
>>>>>>> c9001e265f997983b1b906f15fd948ac037d2761
                    Thread.sleep(100);
                    if (isSuccessful[0]) {
                        result.success("successful");
                        return;
                    }
                }
                result.success("unsuccessful");
            } catch(InterruptedException e) {
                result.success("unsuccessful");
                //System.out.println("got interrupted!");
            }
        }
    }
}