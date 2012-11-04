//
//  ANNaverMapView.h
//  ADVNote
//
//  Created by nhn on 12. 11. 3..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import <CoreLocation/CoreLocation.h>

@interface ANNaverMapView : UIView <CLLocationManagerDelegate, MKMapViewDelegate>
{
    MKMapView *mapView; //지도
    CLLocationManager *locationManager;
}

- (void)loadMapViewWithCoordinate2D:(CLLocationCoordinate2D)aCoordinate;

- (void)closeMap;

@end
