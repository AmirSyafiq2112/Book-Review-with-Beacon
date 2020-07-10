import 'dart:async';
import 'dart:io';

import 'package:book_beacon/services/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';


class Nearby extends StatefulWidget {
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> with WidgetsBindingObserver{

  final StreamController<BluetoothState> streamController = StreamController();
  StreamSubscription<BluetoothState> _streamBluetooth;
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  bool authorizationStatusOk = false;
  bool locationServiceEnabled = false;
  bool bluetoothEnabled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();

    listeningState();
  }

  listeningState() async {
    print('Listening to bluetooth state');
    _streamBluetooth = flutterBeacon
        .bluetoothStateChanged()
        .listen((BluetoothState state) async {
      print('BluetoothState = $state');
      streamController.add(state);

      switch (state) {
        case BluetoothState.stateOn:
          initScanBeacon();
          break;
        case BluetoothState.stateOff:
          await pauseScanBeacon();
          await checkAllRequirements();
          break;
      }
    });
  }

  checkAllRequirements() async {
    final bluetoothState = await flutterBeacon.bluetoothState;
    final bluetoothEnabled = bluetoothState == BluetoothState.stateOn;
    final authorizationStatus = await flutterBeacon.authorizationStatus;
    final authorizationStatusOk =
        authorizationStatus == AuthorizationStatus.allowed ||
            authorizationStatus == AuthorizationStatus.always;
    final locationServiceEnabled =
    await flutterBeacon.checkLocationServicesIfEnabled;

    setState(() {
      this.authorizationStatusOk = authorizationStatusOk;
      this.locationServiceEnabled = locationServiceEnabled;
      this.bluetoothEnabled = bluetoothEnabled;
    });
  }

  initScanBeacon() async {
    await flutterBeacon.initializeScanning;
    await checkAllRequirements();
    if (!authorizationStatusOk ||
        !locationServiceEnabled ||
        !bluetoothEnabled) {
      print('RETURNED, authorizationStatusOk=$authorizationStatusOk, '
          'locationServiceEnabled=$locationServiceEnabled, '
          'bluetoothEnabled=$bluetoothEnabled');
      return;
    }
    final regions = <Region>[
      Region(
        identifier: 'WGX_iBeacon',
        proximityUUID: 'fda50693-a4e2-4fb1-afcf-c6eb07647825',
      ),
    ];

    if (_streamRanging != null) {
      if (_streamRanging.isPaused) {
        _streamRanging.resume();
        return;
      }
    }

    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
          print(result);
          if (result != null && mounted) {
            setState(() {
              _regionBeacons[result.region] = result.beacons;
              _beacons.clear();
              _regionBeacons.values.forEach((list) {
                _beacons.addAll(list);
              });
              _beacons.sort(_compareParameters);
            });
          }
        });
  }

  pauseScanBeacon() async {
    _streamRanging?.pause();
    if (_beacons.isNotEmpty) {
      setState(() {
        _beacons.clear();
      });
    }
  }

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);

    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }

    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }

    return compare;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState = $state');
    if (state == AppLifecycleState.resumed) {
      if (_streamBluetooth != null && _streamBluetooth.isPaused) {
        _streamBluetooth.resume();
      }
      await checkAllRequirements();
      if (authorizationStatusOk && locationServiceEnabled && bluetoothEnabled) {
        await initScanBeacon();
      } else {
        await pauseScanBeacon();
        await checkAllRequirements();
      }
    } else if (state == AppLifecycleState.paused) {
      _streamBluetooth?.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    streamController?.close();
    _streamRanging?.cancel();
    _streamBluetooth?.cancel();
    flutterBeacon.close;

    super.dispose();
  }

  Book instance = Book(name: 'Harry Potter', author: 'J.K. Rowling', publish: '2010', image: 'book 2.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
            'Nearby Books',
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
        ),
        centerTitle: false,
        actions: <Widget>[
          StreamBuilder<BluetoothState>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final state = snapshot.data;

                if (state == BluetoothState.stateOn) {
                  return IconButton(
                    icon: Icon(Icons.bluetooth_connected),
                    onPressed: () {},
                    color: Colors.orangeAccent,
                  );
                }

                if (state == BluetoothState.stateOff) {
                  return IconButton(
                    icon: Icon(Icons.bluetooth),
                    onPressed: () async {
                      if (Platform.isAndroid) {
                        try {
                          await flutterBeacon.openBluetoothSettings;
                        } on PlatformException catch (e) {
                          print(e);
                        }
                      } else if (Platform.isIOS) {

                      }
                    },
                    color: Colors.red,
                  );
                }

                return IconButton(
                  icon: Icon(Icons.bluetooth_disabled),
                  onPressed: () {},
                  color: Colors.grey,
                );
              }

              return SizedBox.shrink();
            },
            stream: streamController.stream,
            initialData: BluetoothState.stateUnknown,
          ),
        ],
      ),
      body: _beacons == null || _beacons.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: ListTile.divideTiles(
            context: context,
            tiles: _beacons.map((beacon) {
              return FlatButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/bookInfo', arguments: {
                    'name' : instance.name,
                    'author':instance.author,
                    'publish': instance.publish,
                    'image': instance.image,
                  });
                },
                child: ListTile(
                  title: Text('You found a book!'),
                  subtitle: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/harry potter.jpg'),
                          radius: 30.0,
                        ),
                      ),
                      Flexible(
                          child: Text(
                              '${instance.name}',
                              style: TextStyle(fontSize: 13.0)),
                          flex: 1,
                          fit: FlexFit.tight),
                      Flexible(
                          child: Text(
                              '${instance.author}',
                              style: TextStyle(fontSize: 13.0)),
                          flex: 2,
                          fit: FlexFit.tight
                      ),
                      Flexible(
                          child: Text(
                              beacon.proximityUUID,
                              style: TextStyle(fontSize: 13.0)),
                          flex: 2,
                          fit: FlexFit.tight)
                    ],
                  ),
                ),
              );
            })).toList(),
      ),
    );
  }
}

