// Plugins de dart //

//dartpad//
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_messaging_web/firebase_messaging_web.dart';
import 'package:geolocator_web/geolocator_web.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:permission_handler_html/permission_handler_html.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  FirebaseCoreWeb.registerWith(registrar);
  FirebaseMessagingWeb.registerWith(registrar);
  GeolocatorPlugin.registerWith(registrar);
  GoogleMapsPlugin.registerWith(registrar);
  WebPermissionHandler.registerWith(registrar);
  SharedPreferencesPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}

// Plugins de registro // 
//
// Generated file. Do not edit.
// This file is generated from template in file `flutter_tools/lib/src/flutter_plugins.dart`.
//

// @dart = 3.6

import 'dart:io'; // flutter_ignore: dart_io_import.
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:url_launcher_android/url_launcher_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:google_maps_flutter_ios/google_maps_flutter_ios.dart';
import 'package:shared_preferences_foundation/shared_preferences_foundation.dart';
import 'package:url_launcher_ios/url_launcher_ios.dart';
import 'package:flutter_local_notifications_linux/flutter_local_notifications_linux.dart';
import 'package:path_provider_linux/path_provider_linux.dart';
import 'package:shared_preferences_linux/shared_preferences_linux.dart';
import 'package:url_launcher_linux/url_launcher_linux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:shared_preferences_foundation/shared_preferences_foundation.dart';
import 'package:url_launcher_macos/url_launcher_macos.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:shared_preferences_windows/shared_preferences_windows.dart';
import 'package:url_launcher_windows/url_launcher_windows.dart';

@pragma('vm:entry-point')
class _PluginRegistrant {

  @pragma('vm:entry-point')
  static void register() {
    if (Platform.isAndroid) {
      try {
        AndroidFlutterLocalNotificationsPlugin.registerWith();
      } catch (err) {
        print(
          '`flutter_local_notifications` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        GeolocatorAndroid.registerWith();
      } catch (err) {
        print(
          '`geolocator_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        GoogleMapsFlutterAndroid.registerWith();
      } catch (err) {
        print(
          '`google_maps_flutter_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        SharedPreferencesAndroid.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        UrlLauncherAndroid.registerWith();
      } catch (err) {
        print(
          '`url_launcher_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isIOS) {
      try {
        IOSFlutterLocalNotificationsPlugin.registerWith();
      } catch (err) {
        print(
          '`flutter_local_notifications` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        GeolocatorApple.registerWith();
      } catch (err) {
        print(
          '`geolocator_apple` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        GoogleMapsFlutterIOS.registerWith();
      } catch (err) {
        print(
          '`google_maps_flutter_ios` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        SharedPreferencesFoundation.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_foundation` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        UrlLauncherIOS.registerWith();
      } catch (err) {
        print(
          '`url_launcher_ios` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isLinux) {
      try {
        LinuxFlutterLocalNotificationsPlugin.registerWith();
      } catch (err) {
        print(
          '`flutter_local_notifications_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        PathProviderLinux.registerWith();
      } catch (err) {
        print(
          '`path_provider_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        SharedPreferencesLinux.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        UrlLauncherLinux.registerWith();
      } catch (err) {
        print(
          '`url_launcher_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isMacOS) {
      try {
        MacOSFlutterLocalNotificationsPlugin.registerWith();
      } catch (err) {
        print(
          '`flutter_local_notifications` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        GeolocatorApple.registerWith();
      } catch (err) {
        print(
          '`geolocator_apple` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        SharedPreferencesFoundation.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_foundation` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        UrlLauncherMacOS.registerWith();
      } catch (err) {
        print(
          '`url_launcher_macos` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isWindows) {
      try {
        PathProviderWindows.registerWith();
      } catch (err) {
        print(
          '`path_provider_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        SharedPreferencesWindows.registerWith();
      } catch (err) {
        print(
          '`shared_preferences_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        UrlLauncherWindows.registerWith();
      } catch (err) {
        print(
          '`url_launcher_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    }
  }
}

// Configuracion de paquetes // 

{
  "configVersion": 2,
  "packages": [
    {
      "name": "_flutterfire_internals",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/_flutterfire_internals-1.3.35",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "archive",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/archive-4.0.3",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "args",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/args-2.6.0",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "async",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/async-2.12.0",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "boolean_selector",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/boolean_selector-2.1.2",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "characters",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/characters-1.4.0",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "checked_yaml",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/checked_yaml-2.0.3",
      "packageUri": "lib/",
      "languageVersion": "2.19"
    },
    {
      "name": "cli_util",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/cli_util-0.4.2",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "clock",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/clock-1.1.2",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "collection",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/collection-1.19.1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "crypto",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/crypto-3.0.6",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "csslib",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/csslib-1.0.2",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "cupertino_icons",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/cupertino_icons-1.0.8",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "dbus",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/dbus-0.7.11",
      "packageUri": "lib/",
      "languageVersion": "2.17"
    },
    {
      "name": "fake_async",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/fake_async-1.3.2",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "ffi",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/ffi-2.1.3",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "file",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/file-7.0.1",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "firebase_core",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_core-2.32.0",
      "packageUri": "lib/",
      "languageVersion": "2.18"
    },
    {
      "name": "firebase_core_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_core_platform_interface-5.4.0",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "firebase_core_web",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_core_web-2.21.0",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "firebase_messaging",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_messaging-14.7.10",
      "packageUri": "lib/",
      "languageVersion": "2.18"
    },
    {
      "name": "firebase_messaging_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_messaging_platform_interface-4.5.37",
      "packageUri": "lib/",
      "languageVersion": "2.18"
    },
    {
      "name": "firebase_messaging_web",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/firebase_messaging_web-3.5.18",
      "packageUri": "lib/",
      "languageVersion": "2.18"
    },
    {
      "name": "fixnum",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/fixnum-1.1.1",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "flutter",
      "rootUri": "file:///C:/Users/kevvskillx12/Documents/flutter_windows_3.27.1-stable/flutter/packages/flutter",
      "packageUri": "lib/",
      "languageVersion": "3.7"
    },
    {
      "name": "flutter_launcher_icons",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_launcher_icons-0.14.3",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "flutter_lints",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_lints-5.0.0",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "flutter_local_notifications",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_local_notifications-18.0.1",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "flutter_local_notifications_linux",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_local_notifications_linux-5.0.0",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "flutter_local_notifications_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_local_notifications_platform_interface-8.0.0",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "flutter_map",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_map-6.2.1",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "flutter_plugin_android_lifecycle",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/flutter_plugin_android_lifecycle-2.0.24",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "flutter_test",
      "rootUri": "file:///C:/Users/kevvskillx12/Documents/flutter_windows_3.27.1-stable/flutter/packages/flutter_test",
      "packageUri": "lib/",
      "languageVersion": "3.7"
    },
    {
      "name": "flutter_web_plugins",
      "rootUri": "file:///C:/Users/kevvskillx12/Documents/flutter_windows_3.27.1-stable/flutter/packages/flutter_web_plugins",
      "packageUri": "lib/",
      "languageVersion": "3.7"
    },
    {
      "name": "font_awesome_flutter",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/font_awesome_flutter-10.8.0",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "geolocator",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/geolocator-13.0.2",
      "packageUri": "lib/",
      "languageVersion": "2.15"
    },
    {
      "name": "geolocator_android",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/geolocator_android-4.6.1",
      "packageUri": "lib/",
      "languageVersion": "2.15"
    },
    {
      "name": "geolocator_apple",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/geolocator_apple-2.3.9",
      "packageUri": "lib/",
      "languageVersion": "2.15"
    },
    {
      "name": "geolocator_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/geolocator_platform_interface-4.2.4",
      "packageUri": "lib/",
      "languageVersion": "2.15"
    },
    {
      "name": "geolocator_web",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/geolocator_web-4.1.1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "geolocator_windows",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/geolocator_windows-0.2.3",
      "packageUri": "lib/",
      "languageVersion": "2.15"
    },
    {
      "name": "get",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/get-4.7.2",
      "packageUri": "lib/",
      "languageVersion": "2.15"
    },
    {
      "name": "google_maps",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/google_maps-8.1.1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "google_maps_flutter",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/google_maps_flutter-2.10.1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "google_maps_flutter_android",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/google_maps_flutter_android-2.14.13",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "google_maps_flutter_ios",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/google_maps_flutter_ios-2.13.2",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "google_maps_flutter_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/google_maps_flutter_platform_interface-2.11.1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "google_maps_flutter_web",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/google_maps_flutter_web-0.5.10+1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "html",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/html-0.15.5",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "http",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/http-1.3.0",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "http_parser",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/http_parser-4.1.2",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "image",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/image-4.5.3",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "intl",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/intl-0.20.2",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "js",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/js-0.6.7",
      "packageUri": "lib/",
      "languageVersion": "2.19"
    },
    {
      "name": "json_annotation",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/json_annotation-4.9.0",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "latlong2",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/latlong2-0.9.1",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "leak_tracker",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/leak_tracker-10.0.8",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "leak_tracker_flutter_testing",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/leak_tracker_flutter_testing-3.0.9",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "leak_tracker_testing",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/leak_tracker_testing-3.0.1",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "lints",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/lints-5.1.1",
      "packageUri": "lib/",
      "languageVersion": "3.6"
    },
    {
      "name": "lists",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/lists-1.0.1",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "logger",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/logger-2.5.0",
      "packageUri": "lib/",
      "languageVersion": "2.17"
    },
    {
      "name": "matcher",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/matcher-0.12.17",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "material_color_utilities",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/material_color_utilities-0.11.1",
      "packageUri": "lib/",
      "languageVersion": "2.17"
    },
    {
      "name": "meta",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/meta-1.16.0",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "mgrs_dart",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/mgrs_dart-2.0.0",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "path",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/path-1.9.1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "path_provider_linux",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/path_provider_linux-2.2.1",
      "packageUri": "lib/",
      "languageVersion": "2.19"
    },
    {
      "name": "path_provider_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/path_provider_platform_interface-2.1.2",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "path_provider_windows",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/path_provider_windows-2.3.0",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "permission_handler",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/permission_handler-11.4.0",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "permission_handler_android",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/permission_handler_android-12.1.0",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "permission_handler_apple",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/permission_handler_apple-9.4.6",
      "packageUri": "lib/",
      "languageVersion": "2.15"
    },
    {
      "name": "permission_handler_html",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/permission_handler_html-0.1.3+5",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "permission_handler_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/permission_handler_platform_interface-4.3.0",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "permission_handler_windows",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/permission_handler_windows-0.2.1",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "petitparser",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/petitparser-6.0.2",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "platform",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/platform-3.1.6",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "plugin_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/plugin_platform_interface-2.1.8",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "polylabel",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/polylabel-1.0.1",
      "packageUri": "lib/",
      "languageVersion": "2.13"
    },
    {
      "name": "posix",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/posix-6.0.1",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "proj4dart",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/proj4dart-2.1.0",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "sanitize_html",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/sanitize_html-2.1.0",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "shared_preferences",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/shared_preferences-2.5.2",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "shared_preferences_android",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/shared_preferences_android-2.4.6",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "shared_preferences_foundation",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/shared_preferences_foundation-2.5.4",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "shared_preferences_linux",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/shared_preferences_linux-2.4.1",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "shared_preferences_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/shared_preferences_platform_interface-2.4.1",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "shared_preferences_web",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/shared_preferences_web-2.4.3",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "shared_preferences_windows",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/shared_preferences_windows-2.4.1",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "sky_engine",
      "rootUri": "file:///C:/Users/kevvskillx12/Documents/flutter_windows_3.27.1-stable/flutter/bin/cache/pkg/sky_engine",
      "packageUri": "lib/",
      "languageVersion": "3.7"
    },
    {
      "name": "source_span",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/source_span-1.10.1",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "sprintf",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/sprintf-7.0.0",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "stack_trace",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/stack_trace-1.12.1",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "stream_channel",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/stream_channel-2.1.4",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "stream_transform",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/stream_transform-2.1.1",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "string_scanner",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/string_scanner-1.4.1",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "term_glyph",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/term_glyph-1.2.2",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "test_api",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/test_api-0.7.4",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "timezone",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/timezone-0.9.4",
      "packageUri": "lib/",
      "languageVersion": "2.19"
    },
    {
      "name": "typed_data",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/typed_data-1.4.0",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "unicode",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/unicode-0.3.1",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "url_launcher",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher-6.3.1",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "url_launcher_android",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher_android-6.3.14",
      "packageUri": "lib/",
      "languageVersion": "3.5"
    },
    {
      "name": "url_launcher_ios",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher_ios-6.3.2",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "url_launcher_linux",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher_linux-3.2.1",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "url_launcher_macos",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher_macos-3.2.2",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "url_launcher_platform_interface",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher_platform_interface-2.3.2",
      "packageUri": "lib/",
      "languageVersion": "3.1"
    },
    {
      "name": "url_launcher_web",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher_web-2.4.0",
      "packageUri": "lib/",
      "languageVersion": "3.6"
    },
    {
      "name": "url_launcher_windows",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/url_launcher_windows-3.1.4",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "uuid",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/uuid-4.5.1",
      "packageUri": "lib/",
      "languageVersion": "3.0"
    },
    {
      "name": "vector_math",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/vector_math-2.1.4",
      "packageUri": "lib/",
      "languageVersion": "2.14"
    },
    {
      "name": "vm_service",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/vm_service-14.3.1",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "web",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/web-1.1.0",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "wkt_parser",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/wkt_parser-2.0.0",
      "packageUri": "lib/",
      "languageVersion": "2.12"
    },
    {
      "name": "xdg_directories",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/xdg_directories-1.1.0",
      "packageUri": "lib/",
      "languageVersion": "3.3"
    },
    {
      "name": "xml",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/xml-6.5.0",
      "packageUri": "lib/",
      "languageVersion": "3.2"
    },
    {
      "name": "yaml",
      "rootUri": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache/hosted/pub.dev/yaml-3.1.3",
      "packageUri": "lib/",
      "languageVersion": "3.4"
    },
    {
      "name": "vetconnectapp",
      "rootUri": "../",
      "packageUri": "lib/",
      "languageVersion": "3.6"
    }
  ],
  "generated": "2025-02-25T23:10:08.736299Z",
  "generator": "pub",
  "generatorVersion": "3.7.0",
  "flutterRoot": "file:///C:/Users/kevvskillx12/Documents/flutter_windows_3.27.1-stable/flutter",
  "flutterVersion": "3.27.3",
  "pubCache": "file:///C:/Users/kevvskillx12/AppData/Local/Pub/Cache"
}


// Configuraciones para el arranque de las dependencias // 

<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="main.dart" type="FlutterRunConfigurationType" factoryName="Flutter">
    <option name="filePath" value="$PROJECT_DIR$/lib/main.dart" />
    <method />
  </configuration>
</component>

// Configuracion de Visual Studio //
{
    "java.configuration.updateBuildConfiguration": "interactive",
    "cmake.sourceDirectory": "C:/Users/kevvskillx12/Desktop/VetConnectapp/vetconnectapp/linux"
}

// buildeo de la aplicacion // 
group 'io.flutter.plugins.firebase.core'
version '1.0-SNAPSHOT'

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.2'
    }
}

apply plugin: 'com.android.library'

def getRootProjectExtOrDefaultProperty(name) {
    if (!rootProject.ext.has("FlutterFire")) return project.properties[name]
    if (!rootProject.ext.get("FlutterFire")[name]) return project.properties[name]
    return rootProject.ext.get("FlutterFire").get(name)
}

android {
    // Conditional for compatibility with AGP <4.2.
    if (project.android.hasProperty("namespace")) {
      namespace 'io.flutter.plugins.firebase.core'
    }

    compileSdk 34

    defaultConfig {
        minSdk 19
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    buildFeatures {
        buildConfig true
    }

    lintOptions {
        disable 'InvalidPackage'
    }

    dependencies {
        implementation platform("com.google.firebase:firebase-bom:${getRootProjectExtOrDefaultProperty("FirebaseSDKVersion")}")
        implementation "com.google.firebase:firebase-common"

        implementation 'androidx.annotation:annotation:1.7.0'
    }
}

apply from: file("./user-agent.gradle")

// Comando de JAVA //
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="io.flutter.plugins.firebase.core">

    <application>
        <service android:name="com.google.firebase.components.ComponentDiscoveryService">
            <meta-data
                android:name="com.google.firebase.components:io.flutter.plugins.firebase.core.FlutterFirebaseCoreRegistrar"
                android:value="com.google.firebase.components.ComponentRegistrar" />
        </service>
    </application>
</manifest>

// Programacion de dependencias de flutter //

# vetconnectapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
