import 'package:connectivity/connectivity.dart';
import 'package:permission_handler/permission_handler.dart';

/// Is "location always" permission granted?
Future<bool> isLocationAlwaysGranted() async =>
await Permission.locationAlways.isGranted;

/// Tries to ask for "location always" permissions from the user.
/// Returns `true` if successful, `false` othervise.
///
Future<bool> askForLocationAlwaysPermission() async {
bool granted = await Permission.locationAlways.isGranted;
if (!granted) {
if (await Permission.locationWhenInUse.request() ==
PermissionStatus.granted) {
// Use location.

granted =
await Permission.locationAlways.request() == PermissionStatus.granted;
}
}
return granted;
}

void ask()  {
askForLocationAlwaysPermission();
}