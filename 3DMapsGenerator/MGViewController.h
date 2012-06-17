//
//  MGViewController.h
//  3DMapsGenerator
//
//  Created by M2Mobi on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MGViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *xTextField;
@property (nonatomic, retain) IBOutlet UITextField *yTextField;
@property (nonatomic, retain) IBOutlet UITextField *widthTextField;
@property (nonatomic, retain) IBOutlet UITextField *heightTextField;
@property (nonatomic, retain) IBOutlet UITextField *lenghtTextField;

-(IBAction)addBlockPressed:(id)sender;

@end
