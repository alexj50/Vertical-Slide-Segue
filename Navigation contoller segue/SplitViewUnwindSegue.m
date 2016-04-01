//
//  SplitViewUnwindSegue.m
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import "SplitViewUnwindSegue.h"
#import "SplitViewShowSegue.h"

@implementation SplitViewUnwindSegue

-(void)perform{
    UIViewController *sourceVC = self.sourceViewController;
    UIViewController *destinationVC = self.destinationViewController;
                                                                                // split the screen in half minus the nav bar
    NSArray *halfsOfScreen = [SplitViewShowSegue splitScreenInHalf:sourceVC:destinationVC];
    
    UIImageView *leftImageView  = halfsOfScreen[0];
    UIImageView *rightImageView = halfsOfScreen[1];

    [SplitViewShowSegue fadeOutNavBar:YES view:sourceVC];                       // fade out nav bar elements
    
    [sourceVC.navigationController popViewControllerAnimated:NO];               // present next controller
    
    [SplitViewShowSegue fadeOutNavBar:NO view:destinationVC];                   // fade in nav bar elements
    
    [UIView animateWithDuration:0.5 animations:^{                               // do the image animations
        leftImageView.frame  = CGRectMake(0, -leftImageView.frame.size.height, leftImageView.frame.size.width, leftImageView.frame.size.height);
        rightImageView.frame = CGRectMake(rightImageView.frame.size.width, rightImageView.frame.size.height, rightImageView.frame.size.width, rightImageView.frame.size.height);
    }];
}

@end
