//
//  ViewController.h
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowInfo.h"

@interface WelcomeVC : UIViewController

@property (strong, nonatomic) RowInfo *rowOptions1,*rowOptions2;                // declare row object
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;

@end

