import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

class PrinterController{

  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;

  Future<List<BluetoothDevice>> getDevice() async {
    devices = await printer.getBondedDevices();
    // print(devices);
    return devices;
    // setState(() {
    //
    // });
  }

  // getConnect() {
  // printer.connect(selectedDevice!);
  // }

  printInvo() async{

    if((await printer.isConnected)!){
      printer.printQRcode('Hi There', 200, 200, 1);
    }
  }

  Widget buildBluetoothDeviceList(){
    return SizedBox(
      height: 50,
      width: 200,
      child: DropdownButton(
        items: devices.map((e) => DropdownMenuItem(value: e,child: Text(e.name.toString()),)).toList(),
        onChanged: (value) {
          selectedDevice = value as BluetoothDevice?;
          printer.connect(selectedDevice!);

          // setState(() {});
        },
      ),
    );
  }
}