//
//  NMapViewQuartz.h
//  MapViewer
//
//  Created by KJ KIM on 08. 10. 24.
//  Copyright 2008 NHN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

 
// CONSTANTS:

#define TILE_TYPE_NORMAL		0
#define TILE_TYPE_SATELLITE		1
#define TILE_TYPE_OVERLAY		2
#define TILE_TYPE_TRAFFIC		3
#define TILE_TYPE_PANORAMA		4
#define TILE_TYPE_BICYCLE		5
#define TILE_TYPE_MAX			6

// INTERFACES:

@class NMapViewQuartzInternal;

@interface NMapViewQuartz : UIView 
{		
	
	BOOL _isVisibleState; // true between viewWillAppear and viewDidDisappear
	
    // map view status
	BOOL _isAnimating;
	BOOL _isPanning;
	
	CGRect _viewFrame;
	CGRect _viewBounds;
					
	// scale factor from points to pixels
	CGFloat _scaleFactor;
	
	NMapViewQuartzInternal *_quartzInternal;
}

@property (nonatomic, assign) BOOL isVisibleState;

@property (nonatomic, readonly) CGRect viewFrame;
@property (nonatomic, readonly) CGRect viewBounds;

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL isPanning;

@end //NMapViewQuartz


