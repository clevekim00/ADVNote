//
//  ANNoteListView.m
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 28..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANNoteListView.h"

#define kTABLEViewTag 90

@implementation ANNoteListView

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
