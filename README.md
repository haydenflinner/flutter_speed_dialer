# flutter_speed_dialer

A FAB Speed Dialer for flutter that actually works.


## Getting Started

Just add a SpeedDialer as your FAB within a scaffold, like this:
```dart
floatingActionButton:
    new SpeedDialer(children: modeButtons));
```

where you define the buttons that will pop out like this:
```dart
    List<Widget> modeButtons = [
      new SpeedDialerButton(backgroundColor: Colors.blue,
          icon: Icons.directions_bike, onPressed: () => print("Clicked"), text: "hi!")];
```

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).
