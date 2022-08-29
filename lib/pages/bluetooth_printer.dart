
import 'package:flutter/material.dart' hide Image;
import 'dart:io' show Platform;
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class BlueToothPrinter extends StatefulWidget {
  const BlueToothPrinter({Key? key, required this.data}) : super(key: key);
  final List<Map<String, dynamic>> data;
  @override
  State<BlueToothPrinter> createState() => _BlueToothPrinterState();
}

class _BlueToothPrinterState extends State<BlueToothPrinter> {

  final PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  final List<PrinterBluetooth> _devices = [];
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    // if (Platform.isIOS) {
    //   bluetoothManager.state.listen((val) {
    //     print('state = $val');
    //     if (!mounted) return;
    //     if (val == 12) {
    //       print('on');
    //       initPrinter();
    //     } else if (val == 10) {
    //       print('off');
    //       setState(() => _devicesMsg = 'Bluetooth Disconnect!');
    //     }
    //   });
    // } else {
    //
    // }

    super.initState();
    initPrinter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print'),
      ),
      body: _devices.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: const Icon(Icons.print),
            title: Text(_devices[i].name.toString()),
            subtitle: Text(_devices[i].address.toString()),
            onTap: () {
              _startPrint(_devices[i]);
            },
          );
        },
      ),
    );
  }

  void initPrinter() {
    _printerManager.startScan(const Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices.addAll(val));
    });
    print(_devices);
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);
    final result = await _printerManager.printTicket(await testTicket());
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(result.msg),
      ),
    );
  }

  Future<List<int>> testTicket() async {
    // final List<int> bytes = [];
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    // bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));
    // bytes += generator.text('Special 2: blåbærgrød',
    //     styles: PosStyles(codeTable: PosCodeTable.westEur));

    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }

}

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) => {initPrinter()});

//   Future<void> initPrinter() async{
//     bluetoothPrint.startScan(timeout: const Duration(seconds: 2));
//
//     if(!mounted) return;
//     bluetoothPrint.scanResults.listen((event) {
//       if(!mounted) return;
//       setState(() {
//         _devices=event;
//       });
//       if(_devices.isEmpty){
//         setState(() {
//           devicesMessage = 'No device found';
//         });
//       }
//     });
//   }