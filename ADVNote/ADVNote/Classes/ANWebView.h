//
//  ANWebView.h
//  ADVNote
//
//  Created by nhn on 12. 11. 3..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANWebView : UIView
{
    UIWebView *webView;
}

- (void)loadSearchWithKeyWord:(NSString*)aKey;


@end
