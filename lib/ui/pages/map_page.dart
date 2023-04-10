import 'package:action_manager/utils/hex_color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../controllers/map_controller.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);

  final _mapController = MapController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: DropdownSearch<SearchItem>(
                    asyncItems: (query) => _mapController.searchAsync(query),
                    onChanged: (item) {
                      if(item != null){
                        _mapController.selectedPoint(item);
                      }
                    },
                    itemAsString: (item) => item.toponymMetadata?.address.formattedAddress ?? item.name,
                    popupProps: PopupProps.dialog(
                      searchDelay: const Duration(milliseconds: 1500),
                      showSearchBox: true,
                      isFilterOnline: true,
                      searchFieldProps: TextFieldProps(
                        controller: _mapController.queryTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                width: 1, color: HexColor.fromHex("#554AF0")),
                          ),
                        ),
                      ),
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "Выберите ваше местоположение",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: 1, color: HexColor.fromHex("#554AF0")),
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: YandexMap(
                onMapCreated: (controller) {
                  _mapController.yandexMapController(controller);
                  _mapController.init();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
