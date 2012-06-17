//
//  MGViewController.m
//  3DMapsGenerator
//
//  Created by M2Mobi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGViewController.h"
#import "OpenGLView.h"
#import "Constants.h"
#import "Block.h"

@interface MGViewController ()

@property (nonatomic, retain) OpenGLView *glView;

-(IBAction)addBlockPressed:(id)sender;

@end

@implementation MGViewController

@synthesize glView = _glView;
@synthesize xTextField = _xTextField, yTextField = _yTextField, widthTextField = _widthTextField, heightTextField = _heightTextField, lenghtTextField = _lenghtTextField;

#define N_FINGERS_MOVING 1
#define N_FINGERS_ROTATING 2


#define ORIGIN_GLVIEW 200


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //Add the openGL View
    self.glView = [[[OpenGLView alloc] initWithFrame:CGRectMake(ORIGIN_GLVIEW, 0,self.view.frame.size.width - ORIGIN_GLVIEW , self.view.frame.size.height)] autorelease];
    [self.view addSubview:self.glView];
    
    
    //Add the edition view
//    UIView *editionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ORIGIN_GLVIEW, self.view.frame.size.width)];
//    editionView.backgroundColor = [UIColor colorWithRed:0.2 green:0.8 blue:1 alpha:1];
//
//    
//    //Edition mode button
//    UIButton *addBlock = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    addBlock.frame = CGRectMake(ORIGIN_GLVIEW/5, 500, ORIGIN_GLVIEW - ORIGIN_GLVIEW/2.5, 50);
//    [addBlock addTarget:self action:@selector(addBlockPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [editionView addSubview:addBlock];
//    
//    [self.view addSubview:editionView];
//    [editionView release];

    //Add the gesture recognizer
    //Pinching for the zoom
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    
    //Draging with one finger the position, draging with two fingers for the perspective
    UIPanGestureRecognizer *dragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
    dragRecognizer.minimumNumberOfTouches = N_FINGERS_MOVING;
    dragRecognizer.maximumNumberOfTouches = N_FINGERS_ROTATING;

    [self.glView addGestureRecognizer:pinchRecognizer];
    [self.glView addGestureRecognizer:dragRecognizer];
    
    [pinchRecognizer release];
    [dragRecognizer release];
    
    
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


#pragma mark Gesture Recognizers

-(IBAction)handlePinch:(id)sender{
    
    UIPinchGestureRecognizer *pinchGesture = (UIPinchGestureRecognizer *)sender;
    
    NSLog(@"%f", pinchGesture.scale);
    
    ((OpenGLView *)self.view).zoom = pinchGesture.scale;
}

-(IBAction)handleDrag:(id)sender{
    
    UIPanGestureRecognizer *dragGesture = (UIPanGestureRecognizer *)sender;
    
    //NSLog(@"%@", NSStringFromCGPoint([dragGesture translationInView:self.view]));
    
    switch (dragGesture.numberOfTouches) {
        case N_FINGERS_MOVING:{
    
            CGPoint velocity = [dragGesture velocityInView:self.view];
            
            if (velocity.y > 0){
                
                //Gesture goes from 0 to self.view.frame.size.height
                //Rotation Goes from 0 to 360
                float angle = [dragGesture translationInView:self.view].y/self.view.frame.size.height*360;
                NSLog(@"y %f %f", [dragGesture translationInView:self.view].y, angle);
                self.glView.rotationY = angle;
                
            }
            else if (velocity.x > 0){
                
                float angle = [dragGesture translationInView:self.view].x/self.view.frame.size.height*360;
                NSLog(@"x %f %f", [dragGesture translationInView:self.view].x, angle);
                self.glView.rotationX = angle;
            }
            
            break;
        }
            
            
        case N_FINGERS_ROTATING:{
            //TODO
           
           
           
            

        
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark Button Actions

-(IBAction)addBlockPressed:(id)sender{
    
    //check if the values are correct
    float x = [self.xTextField.text floatValue];
    float y = [self.yTextField.text floatValue];
    float width = [self.widthTextField.text floatValue];
    float length =[self.lenghtTextField.text floatValue];
    float height = [self.heightTextField.text floatValue];
    
    //Data is between -1 and 1, so we need to recalculate the data that will come from 0 to 100 (for example), and 0 to 10 for height
    float floorFloat = FLOOR_SIZE;
    float realFloat = REAL_SIZE;
    float baseRatio = (floorFloat/2)/realFloat;
    float x2 = (x*baseRatio) - FLOOR_SIZE/2;
    float x1 = ((x + width)*baseRatio) - FLOOR_SIZE/2;
    float y1 = (y*baseRatio) - FLOOR_SIZE/2;
    float y2 = ((y + length)*baseRatio) - FLOOR_SIZE/2;
    float z = height;
    
    //self.glView.editModeEnabled = !self.glView.editModeEnabled;
    NSLog(@"Adding: x2 %f, x1 %f, y1 %f, y2 %f", x2, x1, y1, y2);
    Block *block = [[Block alloc] initWithCoordinatesx1:x1 x2:x2 y1:y1 y2:y2 z:z];
    [self.glView addNewBlock:block];

    
}

@end
