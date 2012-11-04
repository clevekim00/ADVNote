//
//  ANAnnotationPin.m
//  ADVNote
//
//  Created by nhn on 12. 11. 3..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANAnnotationPin.h"

@implementation ANAnnotationPin

- (NSString *)subtitle
{
	return nil;
}

- (NSString *)title
{
	return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c
{
	coordinate=c;
	return self;
}

@end
