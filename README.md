# Mobile Queries

The New York City Taxi and Limousine Commission (TLC) deals with yellow cabs, green cabs and rental cars. TLC regularly records information for each completed taxi ride. Within the scope of this project, yellow taxi data published in December 2020 will be used.

## Features

- Show days and distances for 5 longest trips.
- Show number of vehicles departing from a given location between two dates
- Show the longest trips of the selected date

## Plugins

- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_database](https://pub.dev/packages/firebase_database)
- [firebase_dart](https://pub.dev/packages/firebase_dart)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [intl](https://pub.dev/packages/intl)
- [date_range_picker](https://pub.dev/packages/date_range_picker)
- [flutter_custom_clippers](https://pub.dev/packages/flutter_custom_clippers)
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter)
- [flutter_polyline_points](https://pub.dev/packages/flutter_polyline_points)
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)

## Usage
 - Clone the repository.
   ```
   git clone https://github.com/emrearik/mobile_queries.git
   ```

 - Go to android/local.properties file and add your API key here.
   ```
   googleMap.apiKey=<API_KEY_HERE>
   ```
   
 - Create root/lib/.env file and add your API key here.
   ```
   GOOGLE_MAP_API_KEY="<API_KEY_HERE>"
   ```
   
 - Go to terminal and run flutter.
   ```
   flutter run
   ```
   


## Design
![Design](https://i.imgur.com/WWo5uFE.jpeg "Design")
