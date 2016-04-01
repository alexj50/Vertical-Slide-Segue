//
//  RowInfo.m
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import "RowInfo.h"

@implementation RowInfo

-(id)copy {
    RowInfo *info    = [RowInfo new];
    info.options     = _options;
    info.selected    = _selected;
    info.indexPath   = _indexPath;
    info.selectedRow = _selectedRow;
    return info;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"Options count: %ld\nSelected Text: %@\nIndex Path.row: %@\nSelected Row: %ld", _options.count,_selected, _indexPath, _selectedRow];
}
@end
