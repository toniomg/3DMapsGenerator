//
//  MGViewController.m
//  3DMapsGenerator
//
//  Created by M2Mobi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGViewController.h"
#import "OpenGLView.h"

@interface MGViewController ()

@end

@implementation MGViewController


-(void)loadView{
    
    //Create the OpenGL view and add it to this view controller
    CGRect screenBounds = [[UIScreen mainScreen] bounds];    
    OpenGLView *glView = [[[OpenGLView alloc] initWithFrame:screenBounds] autorelease];
    self.view = glView;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
