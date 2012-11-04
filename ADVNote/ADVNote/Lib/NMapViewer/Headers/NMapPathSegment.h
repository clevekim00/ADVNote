//
//  NMapPathSegment.h
//  NaverMap
//
//  Created by KJ KIM on 10. 10. 20..
//  Copyright 2010 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NMapPathPoint.h"

@interface NMapPathSegment : NSObject {

	// path points in this path segment.
	NSMutableArray *_pathPoints;
	
	// path line type for this segment
	NMapPathLineType _lineType;
}

@property (nonatomic, assign) NMapPathLineType lineType;

- (id)initWithLineType:(int)lineType;

/**
 * 	returns count of path points in this path segment
 */
- (int) countOfPathPoints;

- (NMapPathPoint *) pathPointAtIndex:(int)index;
- (NMapPathPoint *) pathPointAtLast;

- (void) addPathPointInUtmkX:(int)utmkX utmkY:(int)utmkY;

@end
