//
//  ANNoteListView.h
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 28..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANNoteListView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *mData;
}

@property (nonatomic, retain) NSMutableArray *data;

- (void)initTableView;
- (void)tableEdit;
- (void)endTableEdit;
- (void)tableReload;

@end
