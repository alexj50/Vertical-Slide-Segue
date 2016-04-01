//
//  ViewController.m
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import "WelcomeVC.h"
#import "ChooseTextVC.h"

@interface WelcomeVC ()

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rowOptions1             = [RowInfo new];                                   // initilize both row data classes
    _rowOptions1.options     = @[@"Foo", @"Hello", @"The quick brown fox"];
    _rowOptions1.selected    = @"Hello";
    _rowOptions1.selectedRow = 1;
    
    _rowOptions2             = [RowInfo new];
    _rowOptions2.options     = @[@"Bar", @"World", @"jumps over the lazy dog"];
    _rowOptions2.selected    = @"World";
    _rowOptions2.selectedRow = 1;
}

#pragma segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{            // pass row data to next controller
    ChooseTextVC *vc = [segue destinationViewController];
    
    vc.rowOptions1 = _rowOptions1;
    vc.rowOptions2 = _rowOptions2;
}

- (IBAction)unwindToMain:(UIStoryboardSegue *)unwindSegue                       // handle unwind from choose text view controller
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
