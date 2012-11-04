//
//  NMapPathPoint.h
//  NaverMap
//
//  Created by KJ KIM on 10. 10. 20..
//  Copyright 2010 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NMapGeometry.h"

typedef enum {
	NMapPathPointStatusUnknown,
	NMapPathPointStatusHide,
	NMapPathPointStatusShow,
} NMapPathPointStatus;

typedef enum {
	NMapPathLineTypeSolid = 1,
	NMapPathLineTypeDash,
} NMapPathLineType;


@class NMapView;

@interface NMapPathPoint : NSObject {

	// UTMK coordinates.
	NPoint _utmk;
	
	// screen coordinates.
	CGPoint _position;
	
	// path point status
//	NMapPathPointStatus _status; 
	
	// zoom level at which _position evaluated.
	int _zoomLevel;
}

- (id)initWithUtmkX:(int)utmkX utmkY:(int)utmkY;

- (CGPoint) screenPosition:(NMapView *)mapView viewPortOrigin:(NGRect *)viewPortOrigin;

- (void) layoutChanged;

@end
