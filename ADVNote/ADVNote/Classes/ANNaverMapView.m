//
//  ANNaverMapView.m
//  ADVNote
//
//  Created by nhn on 12. 11. 3..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANNaverMapView.h"

@implementation ANNaverMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        mapView = [[MKMapView alloc] initWithFrame:frame];
        
        mapView.showsUserLocation = YES; //내 위치 표시.
        [mapView setMapType:MKMapTypeStandard]; //지도 형태는 기본.
        [mapView setZoomEnabled:YES];	//줌가능
        [mapView setScrollEnabled:YES];	//스크롤가능
        
        mapView.delegate = self; //딜리게이트 설정 (anotation 의 메소드를 구현한다.)
        
        [locationManager startUpdatingLocation];
        
    }
    return self;
}

- (void)closeMap
{
    [locationManager stopUpdatingLocation];
    [self removeFromSuperview];
}

- (void)loadMapViewWithCoordinate2D:(CLLocationCoordinate2D)aCoordinate
{
    MKCoordinateRegion region;
    MKCoordinateSpan span; //보여줄 지도가 처리하는 넓이 정의.
    span.latitudeDelta = 0.02; //숫자가 적으면 좁은영역 까지 보임.
    span.longitudeDelta = 0.02;
    
    CLLocationCoordinate2D location = mapView.userLocation.coordinate;
    
    //위치정보를 못가져왔을때 기본으로 보여줄 위치.
    location.latitude = aCoordinate.latitude; //37.490481 이건 우리집
    location.longitude = aCoordinate.longitude; //126.857790
    
    region.span = span; //크기 설정.
    region.center = location; //위치 설정.
    
    [mapView setRegion:region animated:TRUE]; //지도 뷰에 지역 설정.
    [mapView regionThatFits:region];	//지도 화면에 맞게 크기 조정.
    
    [self addSubview:mapView]; //서브 뷰로 지도를 추가함.
    
    UIButton *sCloseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sCloseBtn setFrame:CGRectMake(10, 10, 30, 30)];
    [sCloseBtn setTitle:@"X" forState:UIControlStateNormal];
    [sCloseBtn addTarget:self action:@selector(closeMap) forControlEvents:UIControlEventTouchUpInside];
    [mapView addSubview:sCloseBtn];
}


#pragma mark MKMapViewDelegate
//맵의 어노테이션 (마커) 표시.
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id<MKAnnotation>)annotation
{
	if( annotation == mapView.userLocation)
    {
 		[mV.userLocation setTitle:@"현재 위치"]; //현재위치 마커에 표시할 타이틀.
		return nil; //현재 위치 마커일경우 커스텀 마커를 사용하지 않는다.
	}
	
    MKPinAnnotationView *dropPin = nil; //마커 준비
	static NSString *reusePinID = @"TargetPin"; //마커 객체를 재사용 하기위한 ID
	
	//마커 초기화
	dropPin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reusePinID];
	if( dropPin == nil )
    {
        dropPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reusePinID];
    }
	
	//핀이 떨어지는 애니메이션
	dropPin.animatesDrop = YES;
	
	//마커 오른쪽에 (>) 모양 버튼 초기화.
	UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	
	dropPin.userInteractionEnabled = TRUE;
	dropPin.canShowCallout = YES;
	dropPin.rightCalloutAccessoryView = infoBtn;
    dropPin.pinColor = MKPinAnnotationColorGreen;
	
	return dropPin;
}

//어노테이션의 더보기
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	return;
}

#pragma mark LocationManager
//위치가 변경되었을때 호출.
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation {
    
	NSString *strInfo = [NSString stringWithFormat:@"didUpdateToLocation: latitude = %f, longitude = %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
	NSLog(@"%@",strInfo);
    
	MKCoordinateRegion region; //레젼설정
	region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 2000, 2000);
	
	MKCoordinateRegion adjustedRegion = [mapView regionThatFits:region];
	[mapView setRegion:adjustedRegion animated:YES];
	
	//한번 위치를 잡으면 로케이션 매니저 정지.
	[locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"locationManager error!!!");
	
	//에러 다이얼로그 표시.
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"위치기반 지점찾기" message:@"현재위치를 검색할수 없습니다.\n설정 > 일반 > 위치서비스 가 활성화 되어있는지 확인해주세요.\n\n위치정보를 가져올수 없어도 하단의 아이콘을 통하여 현재 지도의\n영업점/ATM 위치는 검색하실수\n있습니다." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"확인",nil];
	[alert show];
}

@end
