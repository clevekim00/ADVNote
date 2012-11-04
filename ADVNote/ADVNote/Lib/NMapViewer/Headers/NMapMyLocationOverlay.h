//
//  NMapMyLocationOverlay.h
//  NaverMap
//
//  Created by KJKIM on 10. 10. 21..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NMapPOIdataOverlay.h"

@interface NMapMyLocationOverlay : NMapPOIdataOverlay {

	NGeoPoint _location; // in GRS coordinates	
	float _locationAccuracy; // in meters
	float _locationAccuracyVisibleRadius; // in meters
		
	NPoint _locationInUtmk;	// in UTMK 	coordinates;
	int _locationAccuracyInPixels;
	
	BOOL _locationAccuracyVisible;
	
	float _compassHeading;
	
	NSTimer *_locationAnimationTimer;
	NSTimeInterval _locationUpdateTime;
	int _locationAnimationLevel;
}

@property (nonatomic, assign) NGeoPoint location;

@property (nonatomic, assign) float locationAccuracy;

@property (nonatomic, assign) float compassHeading;

@end
