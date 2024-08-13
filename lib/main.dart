// import 'package:app_monitaz/add_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   final initFuture = MobileAds.instance.initialize();
//   final ad = AddModel(initializaation: initFuture);
//   runApp(Provider.value(value: ad, child: const MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//    BannerAd? bannerAd;
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     print("object");
//     final adState=Provider.of<AddModel>(context);
//     adState.initializaation.then((value) {
//       bannerAd=BannerAd(
//           size: AdSize.banner,
//           adUnitId: adState.bannreAdUnitId,
//           listener: adState.adListner,
//           request: AdRequest()
//       )..load();
//     },);
//     super.didChangeDependencies();
//   }
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text("okok"),
//               );
//             },itemCount: 22,
//             ),
//           ),
//           if(bannerAd==null)
//             SizedBox(height: 60,)
//           else
//             SizedBox(
//               height: 50,
//               child: AdWidget(ad: bannerAd!,),
//             )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
// ca-app-pub-3940256099942544/6300978111
/*
import 'package:app_monitaz/InterstitialId_screen.dart';
import 'package:app_monitaz/add_model.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initAd = MobileAds.instance.initialize();
  final adMobService = AddModel(initializaation: initAd);

  runApp(MultiProvider(
    providers: [Provider.value(value: adMobService)],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 100,),

            SizedBox(
              height: 200,
              child: BannerAdWidget(),
            ),
            SizedBox(
              height: 400,
              child: BannerdAD(),
            )
          ],
        ),
      ),
    );
  }
}

class BannerdAD extends StatefulWidget {
  const BannerdAD({super.key});

  @override
  State<BannerdAD> createState() => _BannerdADState();
}

class _BannerdADState extends State<BannerdAD> {
  late AddModel addModel;
  BannerAd? _bannerAd;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addModel = context.read<AddModel>();
    addModel.initializaation.then(
      (value) {
        setState(() {
          _bannerAd = BannerAd(
              size: AdSize.fullBanner,
              adUnitId: addModel.bannreAdUnitId,
              listener: addModel.adListener,
              request: AdRequest())
            ..load();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InterstitialidScreen(),));

            }, child: Text("Tap")),
            if(_bannerAd==null)
              Container(color: Colors.red,),
            if(_bannerAd!=null)
              Container(
                // height: 90,
                alignment: Alignment.center,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(
                  ad: _bannerAd!,
                ),


              )
          ],
        ),
      ),
    );
  }
}




class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-3940256099942544/6300978111', // Replace with your actual Ad Unit ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad failed to load: $error');
          setState(() {
            _isAdLoaded = false;
          });
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
            alignment: Alignment.center,
            child: AdWidget(ad: _bannerAd!),
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
          )
        : Text('Ad failed to load.');
  }
}
*/
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the app's theme
      theme: ThemeData(
        primarySwatch: Colors.green, // Set the app's primary theme color
      ),
      debugShowCheckedModeBanner: false,
      home: GyroscopeExample(), // Use GyroscopeExample as the home screen
    );
  }
}
class GyroscopeExample extends StatefulWidget {
  @override
  _GyroscopeExampleState createState() => _GyroscopeExampleState();
}

class _GyroscopeExampleState extends State<GyroscopeExample> {
// Declare variables to store gyroscope data
  double _gyroX = 0.0;
  double _gyroY = 0.0;
  double _gyroZ = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen to gyroscope data stream
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroX = event.x;
        _gyroY = event.y;
        _gyroZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Example'), // Set the app bar title
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gyroscope Data:'), // Display a label
            Text('X: $_gyroX'), // Display gyroscope X data
            Text('Y: $_gyroY'), // Display gyroscope Y data
            Text('Z: $_gyroZ'), // Display gyroscope Z data
          ],
        ),
      ),
    );
  }
}
