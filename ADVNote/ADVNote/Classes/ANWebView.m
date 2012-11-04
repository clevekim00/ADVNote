//
//  ANWebView.m
//  ADVNote
//
//  Created by nhn on 12. 11. 3..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANWebView.h"

@implementation ANWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        webView = [[UIWebView alloc] initWithFrame:frame];
        [self addSubview:webView];
    }
    return self;
}

- (void)loadSearchWithKeyWord:(NSString*)aKey
{
    NSString *urlStr = [NSString stringWithFormat:@"http://m.search.naver.com/search.naver?query=%@&where=m&sm=mtp_hty", aKey];
    
    NSString * encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [webView loadRequest:request];
    
    UIButton *sCloseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sCloseBtn setFrame:CGRectMake(10, 10, 30, 30)];
    [sCloseBtn setTitle:@"X" forState:UIControlStateNormal];
    [sCloseBtn addTarget:self action:@selector(closeMap) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:sCloseBtn];
}

- (void)closeMap
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
