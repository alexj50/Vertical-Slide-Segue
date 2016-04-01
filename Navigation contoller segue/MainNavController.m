//
//  MainNavController.m
//  Navigation controller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import "MainNavController.h"

@implementation MainNavController

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {            // reset nav bar when its the parent view
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];                            // get top view controller
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {    // check if method is implemented in top controller
        shouldPop = [vc navigationShouldPopOnBackButton];                       // get value if shouldPop
    }
    
    if(shouldPop) {
        [self popViewControllerAnimated:YES];                                   // pop to parent view controller
    } else {
        for(UIView *view in navigationBar.subviews) {                           // if no, reset back button to full alpha
            if(0.0 < view.alpha && view.alpha < 1.0) {
                [UIView animateWithDuration:.25 animations:^{
                    view.alpha = 1.0;
                }];
            }
        }
    }
    
    return NO;
}



@end
