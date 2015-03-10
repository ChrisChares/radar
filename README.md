#Radar

Making iBeacon region monitoring work the way it should

+ Why not the default implementation?
+ What does radar do
+ Installation
+ Getting started

##Why not the default implementation?

CoreLocation iBeacon API's don't behave quite the way you would think.  For example, say you want to get
notified every time you encounter any beacons with a certain UUID.  

    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:beaconUUID identifier:@"shit"]
    [locationManager startMonitoringForRegion:region];

You now walk in the vicinity of one of those beacons and your delegate's locationManager:didEnterRegion:
is called.  

    - (void)locationManager:(CLLocationManager *)lm didEnterRegion:(CLBeaconRegion):region {
        NSLog(@"%@", region.uuid); // beaconUUID
        NSLog(@"%@", region.major); // nil
        NSLog(@"%@", region.minor); // nil
    }

That beacon certainly had a major and minor, but you do not get that information in your delegate.  In
fact it returns the exact CLBeaconRegion instance you supplied it.  

##What does Radar do?

Use Radar to get get full beacon data back with the same <CLLocationManagerDelegate> delegate.

    //...
    [radar startMonitoringBeaconRegion:region];
    //...

    - (void)locationManager:(CLLocationManager *)lm didEnterRegion:(CLBeaconRegion):region {
        NSLog(@"%@", region.uuid); // beaconUUID
        NSLog(@"%@", region.major); // real major
        NSLog(@"%@", region.minor); // real minor
    }

##Installation

Currently only available via Carthage