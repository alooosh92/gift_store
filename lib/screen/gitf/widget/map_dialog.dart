import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gift_store/controller/store_cubit/store_cubit.dart';
import 'package:gift_store/data/colors.dart';
import 'package:gift_store/screen/gitf/widget/text_field_def.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDialog extends StatelessWidget {
  const MapDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LatLng? local;
    return InkWell(
      onTap: () {
        final Completer<GoogleMapController> mapControllerMap =
            Completer<GoogleMapController>();
        Set<Marker> markers = {};
        Get.dialog(
          AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<StoreCubit>(context).changeLocal(local);
                  Get.back();
                },
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorsManager.primary)),
                child: const Text("تحديد مكان التوصيل"),
              ),
            ],
            insetPadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            title: const Text('حدد عنوان التوصيل'),
            content: SizedBox(
              width: MediaQuery.sizeOf(context).width - 20,
              height: MediaQuery.sizeOf(context).width - 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) =>
                      GoogleMap(
                          onMapCreated: (controller) async {
                            mapControllerMap.complete(controller);
                          },
                          markers: markers,
                          onTap: (argument) {
                            setState(() {
                              local = argument;
                              markers.add(Marker(
                                  markerId: const MarkerId('local'),
                                  position: argument));
                            });
                          },
                          initialCameraPosition: const CameraPosition(
                              target: LatLng(35, 39), zoom: 6)),
                ),
              ),
            ),
          ),
        );
      },
      child: BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          TextEditingController late = TextEditingController(
              text: BlocProvider.of<StoreCubit>(context)
                  .local
                  ?.latitude
                  .toString());
          TextEditingController long = TextEditingController(
              text: BlocProvider.of<StoreCubit>(context)
                  .local
                  ?.longitude
                  .toString());
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2 - 80,
                child: TextFieldDef(
                  name: late,
                  label: 'خط العرض',
                  enabled: false,
                  lines: 1,
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2 - 80,
                child: TextFieldDef(
                  name: long,
                  label: 'خط الطول',
                  enabled: false,
                  lines: 1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
