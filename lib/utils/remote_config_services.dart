import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';

const String _canUpdateVersion = 'can_update_version';
const String _forceUpdateVersion = 'force_update_version';

class RemoteConfigServices {
  var thisAppMajor;
  var thisAppMinor;
  var thisAppPatch;

  Future<void> getThisAppVersion() async {
    // This device App version
    PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    var splitThisAppVersion = _packageInfo.version.split('.');
    thisAppMajor = int.parse(splitThisAppVersion[0]);
    thisAppMinor = int.parse(splitThisAppVersion[1]);
    thisAppPatch = int.parse(splitThisAppVersion[2]);
    print('versi this app: ${_packageInfo.version}');
  }

  Future<bool> isForceUpdate() async {
    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: Duration(seconds: 1));
      await remoteConfig.activateFetched();

      await getThisAppVersion();

      //  Production App Version
      var androidAppVersion = remoteConfig.getString(_forceUpdateVersion);
      var splittedAndroidAppVersion = androidAppVersion.split('.');
      var productionMajor = int.parse(splittedAndroidAppVersion[0]);
      var productionMinor = int.parse(splittedAndroidAppVersion[1]);
      var productionPatch = int.parse(splittedAndroidAppVersion[2]);
      print('versi production: ${remoteConfig.getString(_forceUpdateVersion)}');

      // Check is newer update available
      if (productionMajor > thisAppMajor) {
        print('production major: ${productionMajor}');
        print('this app major: ${thisAppMajor}');
        return true;
      } else if (productionMajor == thisAppMajor) {
        if (productionMinor > thisAppMinor) {
          print('production minor: ${productionMinor}');
          print('this app minor: ${thisAppMinor}');
          return true;
        } else if (productionMinor == thisAppMinor) {
          if (productionPatch > thisAppPatch) {
            print('production patch: ${productionPatch}');
            print('this app patch: ${thisAppPatch}');
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on FetchThrottledException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> isNewerUpdateAvailable() async {
    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: Duration(seconds: 1));
      await remoteConfig.activateFetched();

      await getThisAppVersion();

      //  Production App Version
      var androidAppVersion = remoteConfig.getString(_canUpdateVersion);
      var splittedAndroidAppVersion = androidAppVersion.split('.');
      var productionMajor = int.parse(splittedAndroidAppVersion[0]);
      var productionMinor = int.parse(splittedAndroidAppVersion[1]);
      var productionPatch = int.parse(splittedAndroidAppVersion[2]);
      print('versi production: ${remoteConfig.getString(_canUpdateVersion)}');

      // Check is newer update available
      if (productionMajor > thisAppMajor) {
        print('production major: ${productionMajor}');
        print('this app major: ${thisAppMajor}');
        return true;
      } else if (productionMajor == thisAppMajor) {
        if (productionMinor > thisAppMinor) {
          print('production minor: ${productionMinor}');
          print('this app minor: ${thisAppMinor}');
          return true;
        } else if (productionMinor == thisAppMinor) {
          if (productionPatch > thisAppPatch) {
            print('production patch: ${productionPatch}');
            print('this app patch: ${thisAppPatch}');
            return true;
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on FetchThrottledException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return false;
  }
}
