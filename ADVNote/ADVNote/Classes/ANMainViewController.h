//
//  ANMainViewController.h
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 28..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANControlDelegate.h"
#import "UIPopover+iPhone.h"

@interface ANMainViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ANControlDelegate, UIPopoverControllerDelegate>
{
    UIViewController *popOver;
    
}

- (IBAction)editNoteList:(id)aSender;
- (IBAction)addNewNote:(id)aSender;
- (IBAction)editNoteListDone:(id)aSender;
- (IBAction)editDone:(id)aSender;
- (void)photoGetter;
@end
