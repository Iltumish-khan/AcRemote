In this Project we can create AC remote with BLE Implementation. 

Installation
First make sure you have a Flutter SDK installed. if not install it by Flutter SDK v3.10.3.
Clone this repository, checkout to the main branch.
For vsCode Configuration
Under launch.json file on vsCode and update below environment variables under configurations.
{
"version": "0.2.0",
"configurations": [
{
"name": "demo-flutter",
"request": "launch",
"type": "dart",
"program": "lib/flavor/main_dev.dart"
},
{
"name": "demo-flutter (profile mode)",
"request": "launch",
"type": "dart",
"flutterMode": "profile"
},
{
"name": "demo-flutter (release mode)",
"request": "launch",
"type": "dart",
"program": "lib/flavor/main_prod.dart"
}
]
}
For Android Studio Configuration
Open Run Configuration and add(+) new configuration with flutter.
on dart entrypoint add your project lib/flavor/main_dev.dart path.
