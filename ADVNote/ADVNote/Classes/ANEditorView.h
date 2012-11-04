//
//  ANEditorView.h
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 29..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <EventKit/EventKit.h>
#import <EventKit/EventKitDefines.h>

#import "ANControlDelegate.h"

#import "NMapView.h"
#import "NMapLocationManager.h"

#import "UIPopover+iPhone.h"

@interface ANEditorView : UIView <UITextViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate, NSXMLParserDelegate, UIPopoverControllerDelegate>
{
    UIImage *mImage;
    
    NMapView *_mapView;
    
    CLLocationCoordinate2D location;
    
    UIViewController *popOver;
    
    bool findX;
    bool findY;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) id<ANControlDelegate> delegate;

@property (nonatomic, retain) CLLocationManager *manager;
@property (nonatomic, retain) EKEventStore      *store;

- (void)showSearchInput;

- (void)showAddressChangeInput;

- (void)showMap;

- (void)saveAlert;

- (void)saveNote;

- (void)addImage;

- (void)loadImage;

- (void)viewRemove;

- (void)keyBoardWillShow:(NSNotification*)aNotification;
- (void)keyboardWillHide:(NSNotification*)aNotification;
@end
