//
//  SplitViewShowSegue.h
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplitViewShowSegue : UIStoryboardSegue
+(NSArray *) splitScreenInHalf : (UIViewController *) sourceVC : (UIViewController *) destinationVC;
+ (void) fadeOutNavBar : (BOOL) fade view:(UIViewController *) vc;
@end
