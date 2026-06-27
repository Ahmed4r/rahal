import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'dart:developer';

class LocationService {
  /// Check and request location permissions.
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('LocationService: GPS is disabled');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      log('LocationService: Permission permanently denied');
      return false;
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Returns the city name based on coordinates with smart fallback.
  static Future<String?> getCityFromCoordinates(double lat, double lon) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        lat,
        lon,
      ).timeout(const Duration(seconds: 5));

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;

        // Helper to find the first non-empty field
        final cityCandidates = [
          p.locality,
          p.subAdministrativeArea,
          p.administrativeArea,
          p.subLocality,
          p.name,
        ];

        for (final name in cityCandidates) {
          if (name != null && name.trim().isNotEmpty) {
            return name.trim();
          }
        }
      }
    } catch (e) {
      log('LocationService: Geocoding failed for ($lat, $lon) - $e');
    }
    return null;
  }

  /// Returns the current city name as a complete flow.
  static Future<String> getCurrentCity() async {
    try {
      bool hasPermission = await LocationService().requestLocationPermission();
      if (!hasPermission) {
        log('LocationService: Permission denied');
        return 'Permission Denied';
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 5));

      String? city = await getCityFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return city ?? 'Unknown City';
    } catch (e) {
      log('LocationService: Failed to get current city - $e');
      return 'Error';
    }
  }
}
