//
//  ANAnnotationPin.h
//  ADVNote
//
//  Created by nhn on 12. 11. 3..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ANAnnotationPin : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}

@end
