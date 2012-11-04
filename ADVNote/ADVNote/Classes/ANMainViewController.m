//
//  ANMainViewController.m
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 28..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANMainViewController.h"
#import "ANNoteListView.h"
#import "ANEditorView.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define kNOTE_LIST_TAG 100
#define kEDIT_TAG 101

@interface ANMainViewController ()

@end

@implementation ANMainViewController

- (id)init
{
    self = [super init];
    if( self )
    {
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(editNoteList:)]];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(addNewNote:)]];
    //[[self navigationItem] setTitle:@"ADVNote"];
    [self setTitle:@"ADVNote"];
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:63.0/255
                                                                              green:175.0/255
                                                                               blue:15.0/255
                                                                              alpha:1]];
    
    [[[self navigationController] navigationBar] setBarStyle:UIBarStyleBlackTranslucent]; //스타일 적용
    //[[[self navigationController] navigationBar] setTranslucent:YES]; // 반투명 효과 주기
    
    ANNoteListView *aNoteList = [[ANNoteListView alloc] initWithFrame:[[self view] frame]];
    [aNoteList setTag:kNOTE_LIST_TAG];
    [[self view] addSubview:aNoteList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)editNoteList:(id)aSender
{
    UIView *sView = [[self view] viewWithTag:kNOTE_LIST_TAG];
    if( sView )
    {
        ANNoteListView *sNoteList = (ANNoteListView*)sView;
        if( [sNoteList data] && [[sNoteList data] count] > 0 )
        {
            [sNoteList tableEdit];
            
            [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                                         style:UIBarButtonItemStylePlain
                                                                                        target:self
                                                                                        action:@selector(editNoteListDone:)]];
        }
    }
}

- (IBAction)editNoteListDone:(id)aSender
{
    UIView *sView = [[self view] viewWithTag:kNOTE_LIST_TAG];
    if( sView )
    {
        ANNoteListView *sNoteList = (ANNoteListView*)sView;
        if( [sNoteList data] && [[sNoteList data] count] > 0 )
        {
            [sNoteList endTableEdit];
            
            [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                                         style:UIBarButtonItemStylePlain
                                                                                        target:self
                                                                                        action:@selector(editNoteList:)]];
        }
    }
}

- (IBAction)addNewNote:(id)aSender
{
    
    UIView *view = [[self view] viewWithTag:kEDIT_TAG];
    if( view )
    {
        [view removeFromSuperview];
    }
    
    CGRect sViewFrame = [[self view] frame];
    ANEditorView *sEditView = [[ANEditorView alloc] initWithFrame:CGRectMake(0, sViewFrame.size.height, sViewFrame.size.width, 460)];
    [sEditView setTag:kEDIT_TAG];
    [sEditView setDelegate:self];
    [[self view] addSubview:sEditView];
    
    [UIView animateWithDuration:0.5f animations:^{
        [sEditView setFrame:CGRectMake(0, 0, sViewFrame.size.width, 480)];
    } completion:^(BOOL finished) {
        if( finished )
        {
            [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                                         style:UIBarButtonItemStylePlain
                                                                                        target:self
                                                                                        action:@selector(popMenu:)]];
            [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                                          style:UIBarButtonItemStylePlain
                                                                                         target:self
                                                                                         action:@selector(editDone:)]];
            
        }
    }];
}

- (IBAction)popMenu:(id)sender
{
    
}

- (IBAction)editDone:(id)aSender
{
    UIView *sView = [[self view] viewWithTag:kEDIT_TAG];
    if( sView )
    {
        ANEditorView *sEditView = (ANEditorView *)sView;
        [UIView animateWithDuration:0.5f animations:^{
            [sEditView setFrame:CGRectMake(0, 480, 320, 480)];
        } completion:^(BOOL finished) {
            if( finished )
            {
                [sEditView saveNote];
                [sEditView viewRemove];
                [sEditView removeFromSuperview];
                
                UIView *sView = [[self view] viewWithTag:kNOTE_LIST_TAG];
                if( sView )
                {
                    ANNoteListView *sNoteList = (ANNoteListView*)sView;
                    [sNoteList endTableEdit];
                    [sNoteList tableReload];
                }
                
                [[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                                             style:UIBarButtonItemStylePlain
                                                                                            target:self
                                                                                            action:@selector(editNoteList:)]];
                [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                                              style:UIBarButtonItemStylePlain
                                                                                             target:self
                                                                                             action:@selector(addNewNote:)]];
            }
        }];
    }
}

#pragma imagepicker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        [self dismissViewControllerAnimated:YES completion:^{
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIView *sView = [[self view] viewWithTag:kEDIT_TAG];
            if( sView )
            {
                ANEditorView *sEditView = (ANEditorView *)sView;
                [sEditView setImage:image];
                [sEditView loadImage];
                [sEditView setHidden:NO];
            }
        }];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIView *sView = [[self view] viewWithTag:kEDIT_TAG];
        if( sView )
        {
            ANEditorView *sEditView = (ANEditorView *)sView;
            [sEditView setHidden:NO];
        }
    }];
}

- (void)photoGetter
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.mediaTypes = [NSArray arrayWithObjects:
                              (NSString *) kUTTypeImage,
                              (NSString *) kUTTypeMovie, nil];
    
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

@end
