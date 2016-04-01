//
//  RowInfo.h
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RowInfo : NSObject

@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) NSString *selected;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property NSInteger selectedRow;

@end
