import 'package:action_manager/repository/auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../models/app_lat_long.dart';
import '../models/app_location.dart';

class MapController extends GetxController implements AppLocation {
  static MapController get instance => Get.find();

  final queryTextController = TextEditingController();

  final defLocation = const KrasnoyarskLocation().obs;

  final selectedPoint = Rxn<SearchItem>();

  final query = "".obs;

  final yandexMapController = Rxn<YandexMapController>();

  @override
  void onInit() {
    ever(selectedPoint, (value) async {
      if (value == null || value.toponymMetadata == null) {
        Get.snackbar(
          "Ошибка",
          "Местоположение не сохранено, в API отсутсвует точная информация о данной точки",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
        return;
      }
      final appLatLong = AppLatLong(
          lat: value.toponymMetadata!.balloonPoint.latitude,
          long: value.toponymMetadata!.balloonPoint.longitude);
      await _moveToCurrentLocation(appLatLong, yandexMapController.value!);
      await AuthRepository.instance.saveGeoPosition(appLatLong);


    });
    super.onInit();
  }

  Future<List<SearchItem>> searchAsync(String filter) async {
    final resultWithSession = YandexSearch.searchByText(
      searchText: filter,
      geometry: Geometry.fromBoundingBox(const BoundingBox(
        southWest:
            Point(latitude: 55.76996383933034, longitude: 37.57483142322235),
        northEast:
            Point(latitude: 55.785322774728414, longitude: 37.590924677311705),
      )),
      searchOptions: const SearchOptions(
        searchType: SearchType.geo,
        geometry: false,
      ),
    );
    return (await resultWithSession.result).items ?? [];
  }

  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
      (_) => defLocation.value,
    );
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  Future<void> init() async {
    await _initPermission();
    final location = await _fetchCurrentLocation();
    await _moveToCurrentLocation(location, yandexMapController.value!);
  }

  Future<void> _initPermission() async {
    if (!await checkPermission()) {
      await requestPermission();
    }
  }

  Future<AppLatLong> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = KrasnoyarskLocation();
    try {
      location = await getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    return location;
  }

  Future<void> _moveToCurrentLocation(
      AppLatLong appLatLong, YandexMapController yandexMapController) async {
    // if (yandexMapController.value != null) return;
    yandexMapController.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 12,
        ),
      ),
    );
  }
}
