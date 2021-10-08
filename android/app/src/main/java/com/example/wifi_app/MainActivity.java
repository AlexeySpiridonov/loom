package com.example.wifi_app;

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
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.net.wifi.WifiNetworkSpecifier;
import android.net.wifi.WifiNetworkSuggestion;
import android.net.wifi.hotspot2.PasspointConfiguration;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcelable;
import android.os.PatternMatcher;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "loom/wifi";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("tryConnectToWifi")) {
                        connectToWifi(call.argument("login"), call.argument("password"), result);

                        //result.success(res);
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }



    private void connectToWifi(String ssid, String password, MethodChannel.Result result)
    {
        WifiManager wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            try {
                WifiConfiguration wifiConfig = new WifiConfiguration();
                wifiConfig.SSID = "\"" + ssid + "\"";
                if (password != "")
                    wifiConfig.preSharedKey = "\"" + password + "\"";
                else
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


           Intent panelIntent = new Intent("android.settings.panel.action.WIFI");
           startActivity(panelIntent);

//            WifiNetworkSuggestion suggestion = (password == "") ?
//                new WifiNetworkSuggestion.Builder()
//                        .setSsid(ssid)
//                        .build()
//            :
//                new WifiNetworkSuggestion.Builder()
//                        .setSsid(ssid)
//                        .setWpa2Passphrase(password)
//                        .build();
//
//            final List<WifiNetworkSuggestion> suggestionsList =
//                    new ArrayList<WifiNetworkSuggestion>();
//            suggestionsList.add(suggestion);

//            Intent intent = new Intent(ACTION_WIFI_ADD_NETWORKS);
//            intent.putExtra(EXTRA_WIFI_NETWORK_LIST, new WifiNetworkSuggestion[]{suggestion});
//            startActivity(intent);

//            Bundle bundle = new Bundle();
//            bundle.putParcelableArrayList(EXTRA_WIFI_NETWORK_LIST,(ArrayList<? extends
//                    Parcelable>) suggestionsList);
//            final Intent intent = new Intent(ACTION_WIFI_ADD_NETWORKS);
//            intent.putExtras(bundle);
//            startActivityForResult(intent, 0);

//            final List<WifiNetworkSuggestion> suggestionsList =
//                    new ArrayList<WifiNetworkSuggestion>();
//            suggestionsList.add(suggestion);

//            final PasspointConfiguration passpointConfig = new PasspointConfiguration();
//
//            final int status = wifiManager.addNetworkSuggestions(suggestionsList);
//            if (status != WifiManager.STATUS_NETWORK_SUGGESTIONS_SUCCESS) {
//// do error handling here…
//            }




            // WifiNetworkSpecifier wifiNetworkSpecifier = new WifiNetworkSpecifier.Builder()
            //         .setSsid( ssid )
            //         .setWpa2Passphrase(password)
            //         .build();

            // NetworkRequest networkRequest = new NetworkRequest.Builder()
            //         .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
            //         .setNetworkSpecifier(wifiNetworkSpecifier)
            //         .build();

            // ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);

            // ConnectivityManager.NetworkCallback networkCallback = new ConnectivityManager.NetworkCallback() {
            //     @Override
            //     public void onAvailable(Network network) {
            //         if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            //             connectivityManager.bindProcessToNetwork(network);
            //         } else {
            //             ConnectivityManager.setProcessDefaultNetwork(network);
            //         }

            //         Toast.makeText(
            //                 getApplicationContext(),
            //                 "Wifi successful connect on Android > 10 version",
            //                 Toast.LENGTH_LONG
            //         ).show();
            //         //result.success("Wifi successful connect on Android > 10 version");
            //         super.onAvailable(network);
            //     }
            // };

            // connectivityManager.requestNetwork(networkRequest,networkCallback);
            result.success("successful");
        }
    }
}