//
//  NMapOverlayManager.h
//  NaverMap
//
//  Created by KJ KIM on 10. 10. 12..
//  Copyright 2010 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NMapPOIdataOverlay.h"
#import "NMapMyLocationOverlay.h"
#import "NMapPathDataOverlay.h"
#import "NMapRadiusSettingOverlay.h"

@protocol NMapViewDelegate;

@interface NMapOverlayManager : NMapOverlay {
	
	id<NMapViewDelegate, NMapPOIdataOverlayDelegate> _delegate; // delegate for map host
	NMapView *_mapView;
	
	CALayer *_overlayLayer;
	
	NSMutableArray *_overlays;
	NMapPOIdataOverlay *_focusedPOIdataOverlay;
	NMapMyLocationOverlay *_myLocationOverlay;
	
	BOOL _movePinObject;
	BOOL _preventForwordEvent;
	BOOL _pinDataMoved;
	
	// for offline map
	int _pathDataBoundsLevel;
	float _pathDataBoundsRadius;
	NGeoPoint _pathDataBoundsCenter;	
			
	// last reported point of the focused pin object
	NGeoPoint _reportedPinPosition; 
		
	CALayer *_imgXLayer;
	UIImage *_poiImageX;
	
	NSMutableArray *_pinDataOverlapped; 
	int _curPageOverlapped;
	BOOL _spreadPinObjects;
	CALayer *_spreadLayer;
}

@property (nonatomic, readonly) NMapMyLocationOverlay *myLocationOverlay;

// internally used
@property (nonatomic, assign) BOOL movePinObject;
@property (nonatomic, assign) BOOL preventForwordEvent;
@property (nonatomic, assign) BOOL pinDataMoved;

@property (nonatomic, assign) id<NMapViewDelegate, NMapPOIdataOverlayDelegate> delegate;
@property (nonatomic, assign) CALayer *overlayLayer;
@property (nonatomic, assign) NMapView *mapView;


// add overlay to overlay layers of map view.
- (void) addOverlay:(NMapOverlay *)overlay;
// remove overlay from overlay layers of map view.
- (void) removeOverlay:(NMapOverlay *)overlay;
// remove overlay from overlay layers of map view and release it.
- (void) releaseOverlay:(NMapOverlay *)overlay;
// check if overlay layers of map view has overlay
- (BOOL) hasOverlay:(NMapOverlay *)overlay;

// create POI data overlay and add to the overlay layers
// returned object should be released by the caller.
- (NMapPOIdataOverlay *) createPOIdataOverlay;
- (NMapPOIdataOverlay *) createPOIdataOverlay:(BOOL)spreadable;
// zPositionClass adjust zPosition of layers 
- (NMapPOIdataOverlay *) createPOIdataOverlay:(BOOL)spreadable zPosition:(NMapOverlayZPosition)zPosition;

// create Path data overlay and add to the overlay layers
// returned object should be released by the caller.
- (NMapPathDataOverlay *) createPathDataOverlay:(NMapPathData *)pathData;
// zPositionClass adjust zPosition of layers 
- (NMapPathDataOverlay *) createPathDataOverlay:(NMapPathData *)pathData zPosition:(NMapOverlayZPosition)zPosition;
// create Path data overlay and add to the overlay layers
// returned object is autoreleased.
- (NMapPathDataOverlay *) addPathDataOverlay:(NMapPathData *)pathData;

// create radius data overlay and add to the overlay layers
// returned object should be released by the caller.
- (NMapRadiusSettingOverlay *) createRadiusSettingOverlay;


// clear overlay data without a persistent POI flag
- (void) clearOverlays;
// clear myLocation overlay
- (void) clearMyLocationOverlay;

- (NMapPOIdataOverlay *) findFocusedPOIdataOverlay;
 
// set myLocation
- (void) setMyLocation:(NGeoPoint)location locationAccuracy:(float)locationAccuracy;
- (BOOL) hasMyLocationOverlay;

- (BOOL) canRefreshOverlayData;
- (BOOL) canRefreshOverlayData:(BOOL)checkCallout;

@end

@interface NMapOverlayManager ( NMapOfflineData )

// set bounds only for path data
- (void) setPathDataBounds:(NRect)boundsInUtmk;
// retrieve tiles key list for the overall path data
- (NSArray *) retrieveTilesKeyListForOfflineMapForPathData;
- (int) zoomLevelForOfflinePathData;

@end

@interface NMapOverlayManager ( NMapOverlappedOverlay )

- (BOOL) hasSpreadPins;
- (void) changePageOfSpreadPins:(int)pageIdx;
- (void) closeSpreadPins;

@end
