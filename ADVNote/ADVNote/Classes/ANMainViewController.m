//
//  ANMainViewController.m
//  ADVNote
//
//  Created by youngwhan kim on 12. 10. 28..
//  Copyright (c) 2012년 youngwhan kim. All rights reserved.
//

#import "ANMainViewController.h"

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
    if (self) {
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
    
    [[[self navigationController] navigationBar] setTintColor:[UIColor colorWithRed:255.0/255
                                                                              green:10.0/255
                                                                               blue:100.0/255
                                                                              alpha:1]];
    
    [[[self navigationController] navigationBar] setBarStyle:UIBarStyleBlackTranslucent]; //스타일 적용
    [[[self navigationController] navigationBar] setTranslucent:YES]; // 반투명 효과 주기
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)editNoteList:(id)aSender
{
    
}

- (IBAction)addNewNote:(id)aSender
{
    
}

@end
