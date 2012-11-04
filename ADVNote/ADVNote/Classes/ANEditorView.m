//
//  ANEditorView.m
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 29..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANEditorView.h"
#import "ANNaverMapView.h"
#import "ANWebView.h"

#define kIMAGEVIEW 200
#define kTEXTVIEW  201
#define kTEXTFIELD 202
#define kMAPSEARCHVIEW 203
#define kSEARCHBTN 310

@implementation ANEditorView

@synthesize delegate;
@synthesize image = mImage;
@synthesize store;
@synthesize manager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        location.longitude = 0.0;
        location.latitude  = 0.0;
        
        store = [[EKEventStore alloc] init];
        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
            if (!granted)
                NSLog(@"Access to store not granted");
        }];
        
        manager = [[CLLocationManager alloc]init];
        manager.delegate = self;
        manager.distanceFilter = kCLDistanceFilterNone;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [manager startUpdatingLocation];
        
        [self setBackgroundColor:[UIColor grayColor]];
        
        UIButton *sSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sSearchButton setTag:kSEARCHBTN];
        [sSearchButton setFrame:CGRectMake(10, 10, 30, 30)];
        [sSearchButton setBackgroundColor:[UIColor whiteColor]];
        [sSearchButton setTitle:@"검색" forState:UIControlStateNormal];
        [sSearchButton setTitle:@"검색" forState:UIControlStateHighlighted];
        [sSearchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sSearchButton addTarget:self action:@selector(showSearchInput) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sSearchButton];
        
        UIButton *sAddressChangeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sAddressChangeButton setFrame:CGRectMake(50, 10, 60, 30)];
        [sAddressChangeButton setBackgroundColor:[UIColor whiteColor]];
        [sAddressChangeButton setTitle:@"주소찾기" forState:UIControlStateNormal];
        [sAddressChangeButton setTitle:@"주소찾기" forState:UIControlStateHighlighted];
        [sAddressChangeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sAddressChangeButton addTarget:self action:@selector(showAddressChangeInput) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sAddressChangeButton];
        
        UIButton *sMapSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sMapSearchButton setFrame:CGRectMake(120, 10, 60, 30)];
        [sMapSearchButton setBackgroundColor:[UIColor whiteColor]];
        [sMapSearchButton setTitle:@"지도검색" forState:UIControlStateNormal];
        [sMapSearchButton setTitle:@"지도검색" forState:UIControlStateHighlighted];
        [sMapSearchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sMapSearchButton addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sMapSearchButton];
        
        UIButton *sAddImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sAddImageButton setFrame:CGRectMake(190, 10, 60, 30)];
        [sAddImageButton setBackgroundColor:[UIColor whiteColor]];
        [sAddImageButton setTitle:@"Image" forState:UIControlStateNormal];
        [sAddImageButton setTitle:@"Image" forState:UIControlStateHighlighted];
        [sAddImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sAddImageButton addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sAddImageButton];
        
        UIButton *sAlertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [sAlertButton setFrame:CGRectMake(260, 10, 60, 30)];
        [sAlertButton setBackgroundColor:[UIColor whiteColor]];
        [sAlertButton setTitle:@"알림등록" forState:UIControlStateNormal];
        [sAlertButton setTitle:@"알림등록" forState:UIControlStateHighlighted];
        [sAlertButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sAlertButton addTarget:self action:@selector(saveAlert) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sAlertButton];
        
        UITextField *sTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 41, 320, 20)];
        [sTextField setDelegate:self];
        [sTextField setFont:[UIFont systemFontOfSize:10]];
        [sTextField setPlaceholder:@"Title"];
        [sTextField setBackgroundColor:[UIColor whiteColor]];
        [sTextField setTag:kTEXTFIELD];
        [self addSubview:sTextField];
        
        UITextView *sTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 62, 320, 216 - 62)];
		[sTextView setDelegate:self];
		[sTextView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        [sTextView setBackgroundColor:[UIColor colorWithRed:63.0/255
                                                      green:175.0/255
                                                       blue:15.0/255
                                                      alpha:0.5]];
        [sTextView setTag:kTEXTVIEW];
        [sTextView setKeyboardType:UIKeyboardTypeDefault];
		[self addSubview:sTextView];
        
        UIImageView *sImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 216, 320, 460 - 216)];
        [sImageView setTag:kIMAGEVIEW];
        [self addSubview:sImageView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyBoardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)keyBoardWillShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIButton *sBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sBtn setTitle:@"닫기" forState:UIControlStateNormal];
    [sBtn addTarget:self action:@selector(keyBoardClose) forControlEvents:UIControlEventTouchUpInside];
    [sBtn setTag:301];
    [sBtn setFrame:CGRectMake(0, kbSize.height - 42, 30, 30)];
    [self addSubview:sBtn];
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    UIView *sView = [self viewWithTag:301];
    [sView removeFromSuperview];
}

- (void)keyBoardClose
{
    UITextView *sTView = (UITextView*)[self viewWithTag:kTEXTVIEW];
    [sTView resignFirstResponder];
    
    UITextField *sTF = (UITextField*)[self viewWithTag:kTEXTFIELD];
    [sTF resignFirstResponder];
}

- (void)viewRemove
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)showSearchInput
{
    UITextField *sTF = (UITextField*)[self viewWithTag:kTEXTFIELD];
    [sTF setPlaceholder:@"Input Search Keyword"];
    [sTF setText:@""];
    [sTF becomeFirstResponder];
    
    UIButton *sBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sBtn setFrame:CGRectMake(290, 41, 30, 20)];
    [sBtn setTitle:@"Search" forState:UIControlStateNormal];
    [sBtn addTarget:self action:@selector(naverSearch) forControlEvents:UIControlEventTouchUpInside];
    [sBtn setTag:kMAPSEARCHVIEW];
    [self addSubview:sBtn];
}

- (void)naverSearch
{
    UITextField *sTF = (UITextField*)[self viewWithTag:kTEXTFIELD];
    [sTF resignFirstResponder];
    
    ANWebView *sWebView = [[ANWebView alloc] initWithFrame:[self frame]];
    [sWebView loadSearchWithKeyWord:[sTF text]];
    [self addSubview:sWebView];
}

- (void)showAddressChangeInput
{
    UITextField *sTF = (UITextField*)[self viewWithTag:kTEXTFIELD];
    [sTF setPlaceholder:@"Input Address"];
    [sTF setText:@""];
    [sTF becomeFirstResponder];
    
    UIButton *sBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sBtn setFrame:CGRectMake(290, 41, 30, 20)];
    [sBtn setTitle:@"Search" forState:UIControlStateNormal];
    [sBtn addTarget:self action:@selector(mapSearch) forControlEvents:UIControlEventTouchUpInside];
    [sBtn setTag:kMAPSEARCHVIEW];
    [self addSubview:sBtn];
}

- (void)mapSearch
{
    UITextField *sTxt = (UITextField*)[self viewWithTag:kTEXTFIELD];
    [sTxt resignFirstResponder];
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSString *urlStr = [NSString stringWithFormat:@"http://map.naver.com/api/geocode.php?key=8c36c72309be8ab6abd5d527cb472e0f&encoding=utf-8&coord=tm128&query=%@",  [sTxt text]];
    
    NSString * encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"ERROR:%@", error.description);
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"STR:%@", str);
    
    UIView *sBtn = [self viewWithTag:kMAPSEARCHVIEW];
    [sBtn removeFromSuperview];
    
    NSXMLParser * parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - 
#pragma mark UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqual:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
    
}

#pragma mark -
#pragma mark NSXMLParser delegate
//xml 시작태그을 읽으면 호출
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	//초기화작업
}

//태그내 데이터를 값을  모두읽을동안 호출
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if( findX )
    {
        location.latitude = [string doubleValue];
        findX = false;
    }
    
    if( findY )
    {
        location.longitude = [string doubleValue];
        findY = false;
    }
}

//xml End태그를 읽으면 호출
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // 태크처리
    if( [elementName isEqualToString:@"x"])
    {
        NSLog(@"point:::: x:");
        findX = true;
        findY = false;
        location.latitude = 37.35937119198403;
    }
    
    if( [elementName isEqualToString:@"y"])
    {
        NSLog(@"point:::: y");
        findX = false;
        findY = true;
        location.longitude = 127.10518598556519;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"주소 검색 완료"
                                                  message:[NSString stringWithFormat:@"x:%f, y:%f", 37.35937119198403, 127.10518598556519]
                                                 delegate:self
                                        cancelButtonTitle:@"확인"
                                        otherButtonTitles:@"취소", nil];
    [alert show];
}


- (void)showMap
{
    ANNaverMapView *sMapView = [[ANNaverMapView alloc] initWithFrame:[self frame]];
    CLLocationCoordinate2D sLocation;
    sLocation.latitude = 37.35937119198403;
	sLocation.longitude = 127.10518598556519;
    
    location = sLocation;
    
    [sMapView loadMapViewWithCoordinate2D:sLocation];
    [self addSubview:sMapView];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if( [[alertView title] isEqualToString:@"도착할때 알림?"] )
    {
        UITextField *sTitleField = (UITextField*)[self viewWithTag:kTEXTFIELD];
        UITextView  *sTextView   = (UITextView*)[self viewWithTag:kTEXTVIEW];
        EKReminder *reminder = [EKReminder reminderWithEventStore:store];
        reminder.title = [sTitleField text];
        reminder.calendar = [store defaultCalendarForNewReminders];
        reminder.notes = [sTextView text];
        
        CLLocationDegrees sLatitude  = 37.35937119198403;
        CLLocationDegrees sLongitude = 127.10518598556519;
        
        CLLocation *sTargetLocation = [[CLLocation alloc] initWithLatitude:sLatitude longitude:sLongitude];
        
        EKStructuredLocation *sEventLocation = [EKStructuredLocation locationWithTitle:[sTitleField text]];
        [sEventLocation setGeoLocation:sTargetLocation];
        
        EKAlarm *alarm = [[EKAlarm alloc]init];
        alarm.structuredLocation = sEventLocation;
        
        if(buttonIndex==0)
        {
            alarm.proximity = EKAlarmProximityEnter;
        }
        else
        {
            alarm.proximity = EKAlarmProximityEnter;
        }
        [reminder addAlarm:alarm];
        
        NSError *error = nil;
        
        [store saveReminder:reminder commit:YES error:&error];
        
        if (error)
            NSLog(@"Failed to set reminder: %@", error);
    }
    
}

- (void)saveAlert
{
    if( location.latitude == 0.0 || location.longitude == 0.0 )
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"알림"
                                                      message:@"지도검색을 하세요."
                                                     delegate:self
                                            cancelButtonTitle:@"네"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"도착할때 알림?"
                                                      message:[NSString stringWithFormat:@"x:%f, y:%f", 37.35937119198403, 127.10518598556519]
                                                     delegate:self
                                            cancelButtonTitle:@"네"
                                            otherButtonTitles:@"아니오", nil];
        [alert show];
    }
}

- (void)saveNote
{
    
}

- (void)addImage
{
    [self setHidden:YES];
    [delegate photoGetter];
}

- (void)loadImage
{
    UIImageView *sImageView = (UIImageView *)[self viewWithTag:kIMAGEVIEW];
    [sImageView setImage:mImage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)aManager
    didUpdateLocations:(NSArray *)locations
{
    [manager stopUpdatingLocation];
}

@end
