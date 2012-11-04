//
//  ANNoteListView.m
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 28..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANNoteListView.h"

#define kTABLEViewTag 90

static const NSString *gTableName = @"ANNoteTable";

@interface  ANNoteListView (Private)

- (void)loadData;

@end

@implementation ANNoteListView

@synthesize data = mData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        mData = [[NSMutableArray alloc] initWithCapacity:1];
        
        UITableView *sTableView = [[UITableView alloc] initWithFrame:frame];
        [sTableView setDelegate:self];
        [sTableView setDataSource:self];
        [sTableView setTag:kTABLEViewTag];
        [self addSubview:sTableView];
        
        [self loadData];
        [self initTableView];
    }
    return self;
}

- (void)initTableView
{
    if( mData && [mData count] > 0 )
    {
        UIView *sView = [self viewWithTag:kTABLEViewTag];
        if( sView )
        {
            [((UITableView*)sView) reloadData];
        }
    }
}

- (void)tableEdit
{
    UIView *sView = [self viewWithTag:kTABLEViewTag];
    if( sView )
    {
        UITableView *sTbl = (UITableView*)sView;
        [sTbl setEditing:true animated:true];
    }
}

- (void)endTableEdit
{
    UIView *sView = [self viewWithTag:kTABLEViewTag];
    if( sView )
    {
        UITableView *sTbl = (UITableView*)sView;
        [sTbl setEditing:false animated:true];
    }
}

#pragma mark - UITableViewDataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( mData )
    {
        return [mData count];
    }
    else
    {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( [indexPath row] % 2 == 0 )
    {
        [cell setBackgroundColor:[UIColor colorWithRed:63.0/255
                                                  green:175.0/255
                                                   blue:15.0/255
                                                  alpha:0.3]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *sCell = [tableView dequeueReusableCellWithIdentifier:@"ANNoteTable"];
    if( sCell == nil )
    {
        sCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        
        [sCell setEditingAccessoryType:UITableViewCellEditingStyleDelete];
        [sCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        UILabel *sNoteTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 60)];
        [sNoteTitle setTextAlignment:NSTextAlignmentLeft];
        [sNoteTitle setFont:[UIFont systemFontOfSize:15.0]];
        if( [indexPath row] % 2 == 0 )
        {
            [sNoteTitle setBackgroundColor:[UIColor colorWithRed:63.0/255
                                                           green:175.0/255
                                                            blue:15.0/255
                                                           alpha:0.15]];
        }
        
        [sNoteTitle setText:(NSString *)[mData objectAtIndex:[indexPath row]]];
        [sCell addSubview:sNoteTitle];
        
        UIButton *sM2dayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sM2dayBtn setFrame:CGRectMake(205, 15, 30, 30)];
        [sM2dayBtn setImage:[UIImage imageNamed:@"img_20120418165143_e5772fb6.png"] forState:UIControlStateNormal];
        [sM2dayBtn addTarget:self action:@selector(me2share) forControlEvents:UIControlEventTouchUpInside];
        [sCell addSubview:sM2dayBtn];
        
        UIButton *sTwitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sTwitterBtn setFrame:CGRectMake(235, 15, 30, 30)];
        [sTwitterBtn setImage:[UIImage imageNamed:@"1061260918.png"] forState:UIControlStateNormal];
        [sTwitterBtn addTarget:self action:@selector(twittershare) forControlEvents:UIControlEventTouchUpInside];
        [sCell addSubview:sTwitterBtn];
        
        UIButton *sFabookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sFabookBtn setFrame:CGRectMake(265, 15, 30, 30)];
        [sFabookBtn setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
        [sFabookBtn addTarget:self action:@selector(fabookshare) forControlEvents:UIControlEventTouchUpInside];
        [sCell addSubview:sFabookBtn];
        
        UIButton *sLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sLineBtn setFrame:CGRectMake(170, 15, 30, 30)];
        [sLineBtn setImage:[UIImage imageNamed:@"line.png"] forState:UIControlStateNormal];
        [sLineBtn addTarget:self action:@selector(lineShare) forControlEvents:UIControlEventTouchUpInside];
        [sCell addSubview:sLineBtn];
        
    }
    
    return sCell;
}

- (void)me2share
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"알림"
                                                  message:@"me2Day 공유 성공"
                                                 delegate:self
                                        cancelButtonTitle:@"확인"
                                        otherButtonTitles:nil, nil];
    [alert show];
}
- (void)twittershare
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"알림"
                                                  message:@"twitter 공유 성공"
                                                 delegate:self
                                        cancelButtonTitle:@"확인"
                                        otherButtonTitles:nil, nil];
    [alert show];
}
- (void)fabookshare
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"알림"
                                                  message:@"facebook 공유 성공"
                                                 delegate:self
                                        cancelButtonTitle:@"확인"
                                        otherButtonTitles:nil, nil];
    [alert show];
}
- (void)lineShare
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"알림"
                                                  message:@"Line 공유 성공"
                                                 delegate:self
                                        cancelButtonTitle:@"확인"
                                        otherButtonTitles:nil, nil];
    [alert show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mData removeObjectAtIndex:[indexPath row]];
    [tableView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma data manager
- (void)loadData
{
    for( int s = 0; s < 10; s++ )
    {
        [mData addObject:[NSString stringWithFormat:@"note %d", s]];
    }
}

- (void)tableReload
{
    UIView *sView = [self viewWithTag:kTABLEViewTag];
    if( sView )
    {
        UITableView *sTbl = (UITableView*)sView;
        [sTbl reloadData];
    }
}

@end
