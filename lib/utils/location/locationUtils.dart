import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart' as GeoCoding;

class LocationUtil{
  LocationUtil._();

  /// get full address from given position
  static Future<String> getAddressLocation(Position position) async {
    final addressInfo = await GeoCoding.placemarkFromCoordinates(position.latitude, position.longitude);
    return _getFullAddress(addressInfo.first);
  }

  /// mapping address to get suited result
  static String _getFullAddress(GeoCoding.Placemark location) {
    var customAddress = "";
    location.street?.isNotEmpty == true
        ? customAddress += location.street!
        : location.thoroughfare?.isNotEmpty == true
        ? {
      customAddress += location.thoroughfare!,
      location.subThoroughfare?.isNotEmpty == true
          ? customAddress += " No ${location.subThoroughfare!}"
          : null
    }
        : null;
    location.subLocality?.isNotEmpty == true
        ? customAddress += ", ${location.subLocality}"
        : null;
    location.locality?.isNotEmpty == true
        ? customAddress += ", ${location.locality}"
        : null;
    location.subAdministrativeArea?.isNotEmpty == true
        ? customAddress += ", ${location.subAdministrativeArea}"
        : null;
    location.administrativeArea?.isNotEmpty == true
        ? customAddress +=
    ", ${location.administrativeArea} ${location.postalCode}"
        : null;
    location.country?.isNotEmpty == true
        ? customAddress += ", ${location.country}"
        : null;

    return customAddress.matchAsPrefix(", ") != null
        ? customAddress.substring(", ".length)
        : customAddress;
  }

  /// get current position
  static Future<Either<String, Position>> getCurrentLocation(BuildContext context) async {
    final isCanGetLocation = await _isLocationEnable(context);

    if (isCanGetLocation) {
      try {
        var result = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
        return right(result);
      } catch (e) {
        return left(e.toString());
      }
    }
    return left("Gagal ambil data lokasi");
  }

  static Future<bool> _isLocationEnable(BuildContext context) async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("GPS tidak aktif. Tolong aktifkan gps untuk melanjutkan.")));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ijin lokasi ditolak. Tidak bisa melanjukan bila ijin ditolak.")));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ijin lokasi ditolak permanen. Data lokasi tidak bisa diambil")));
      return false;
    }

    return true;
  }

  /// get distance in meter
  static double getDistanceLocation(Position currentPosition, double targetLat, double targetLong){
    var location = Geolocator.distanceBetween(currentPosition.latitude, currentPosition.longitude, targetLat, targetLong);
    return double.parse(location.toStringAsFixed(2));
  }
}
