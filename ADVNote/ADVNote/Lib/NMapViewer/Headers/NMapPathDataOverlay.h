//
//  NMapPathDataOverlay.h
//  NaverMap
//
//  Created by KJ KIM on 10. 10. 20..
//  Copyright 2010 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "NMapOverlay.h"

#import "NMapPathData.h"

@class NMapOverlayManager;

@interface NMapPathDataOverlay : NMapOverlay {

	NMapView *_mapView;
	NMapOverlayManager *_mapOverlayManager;
	
	NMapPathData *_pathData;
	
	float _lineWidth;
	float _lineColor[4];
}

@property (nonatomic, readonly) NMapPathData *pathData;

@property (nonatomic, assign) NMapView *mapView;
@property (nonatomic, assign) NMapOverlayManager *mapOverlayManager;


- (id)initWithPathData:(NMapPathData *)pathData;

// set line width in points
- (void) setLineWidth:(float)width;

// set line color
- (void) setLineColorWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;

/**
 *  Show all path data. 
 *  
 *  @param zoomLevel 0 to show all path data in the NMapView, otherwise it is centered with the given zoom level.
 */
- (void) showAllPathDataAtLevel:(int)zoomLevel;
- (void) showAllPathData;

// check if bounds of path data contains a location
- (BOOL) containsLocation:(NGeoPoint)location;

@end
