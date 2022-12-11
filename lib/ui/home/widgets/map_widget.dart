import 'package:naql/models/ad.dart';
import 'package:naql/ui/ad_details/ad_details_screen.dart';
import 'package:naql/utils/commons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class MapWidget extends StatefulWidget {
  final List<Ad> adList;

  const MapWidget({Key key, this.adList}) : super(key: key);
   @override
   State<StatefulWidget> createState() => MapWidgetState();
}
class MapWidgetState extends State<MapWidget> {
 
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
      super.initState();
      setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/pin.png');
  }

  @override
  Widget build(BuildContext context) {
    var initalLocation = widget.adList[0].adsLocation.
     split(','); 
    LatLng pinPosition = LatLng(double.parse(initalLocation[0]), double.parse(initalLocation[1]));
    
    // these are the minimum required values to set 
    // the camera position 
    CameraPosition initialLocation = CameraPosition(
        zoom: 10,
        bearing: 30,
        target: pinPosition
    );

    return GoogleMap(

      myLocationEnabled: true,
      compassEnabled: true,
      markers: _markers,
      initialCameraPosition: initialLocation,
      onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(Commons.mapStyles);
          _controller.complete(controller);
          widget.adList.forEach((item) {
 
   var loc = item.adsLocation.split(',');
 

 pinPosition = LatLng(double.parse(loc[0]), double.parse(loc[1]));
   setState(() {
            _markers.add(
                Marker(
                  markerId: MarkerId(item.adsId),
                  position: pinPosition,
                  icon: pinLocationIcon,
                     onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdDetailsScreen(
                                                        ad:item ,
                                                          )));
                                            },
                )
            );
          });

});
         
      });
  }

  
}
