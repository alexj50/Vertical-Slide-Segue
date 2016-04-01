//
//  ChooseTextVC.m
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import "ChooseTextVC.h"
#import "MainNavController.h"
#import "WelcomeVC.h"

@interface ChooseTextVC () <UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate, UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerBottom;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) RowInfo *rowOptions1Copy,*rowOptions2Copy;
@property int pickerAnimationHeight;
@property NSInteger rowSelected;

@end

@implementation ChooseTextVC

-(void)viewDidLoad{
    [super viewDidLoad];
    _rowSelected           = 0;
    _pickerAnimationHeight = -(_picker.frame.size.height + 44);
    _pickerBottom.constant = _pickerAnimationHeight;                            // hide picker view
    
    _rowOptions1Copy = [_rowOptions1 copy];                                     // make temp copy if user goes back
    _rowOptions2Copy = [_rowOptions2 copy];
    
    [_tableView reloadData];                                                    // reload table with new/old data
}

#pragma picker animation

- (IBAction)pickerDone:(id)sender {
    [self slidePickerUp:NO complete:nil];                                       // done button on picker handler
}

-(void) slidePickerUp : (BOOL) up complete: (void(^)(void)) complete {          // animate picker up and down
    if (up){
        [_picker reloadAllComponents];
        switch (_rowSelected) {                                                 // set selected rows
            case 1:  [_picker selectRow:_rowOptions1.selectedRow inComponent:0 animated:NO]; break;
            case 2:  [_picker selectRow:_rowOptions2.selectedRow inComponent:0 animated:NO]; break;
            default: break;
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{                               // commit animations
        _pickerBottom.constant = (up) ? 0 :_pickerAnimationHeight;
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        if (complete != NULL) {
            complete();
        }
    }];
}

#pragma picker data                                                             // fill in picker data

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (_rowSelected) {
        case 1:
            return _rowOptions1.options.count;
        case 2:
            return _rowOptions2.options.count;
        default:
            return 0;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (_rowSelected) {
        case 1:
            return _rowOptions1.options[row];
        case 2:
            return _rowOptions2.options[row];
        default:
            return 0;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITableViewCell *cell;                                                      // set values for display on welcome screen
    switch (_rowSelected) {
        case 1:
            _rowOptions1.selected    = _rowOptions1.options[row];
            _rowOptions1.selectedRow = row;
            cell                     = [_tableView cellForRowAtIndexPath:_rowOptions1.indexPath];
            cell.textLabel.text      = _rowOptions1.selected;
            break;
        case 2:
            _rowOptions2.selected    = _rowOptions2.options[row];
            _rowOptions2.selectedRow = row;
            cell                     = [_tableView cellForRowAtIndexPath:_rowOptions2.indexPath];
            cell.textLabel.text      = _rowOptions2.selected;
            break;
        default:
            break;
    }
}

#pragma segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{            // set welcome screen label, ignored if back pushed
    WelcomeVC *vc = [segue destinationViewController];
    vc.mainTextLabel.text = [NSString stringWithFormat:@"%@ %@", _rowOptions1.selected, _rowOptions2.selected];
    vc.rowOptions1 = _rowOptions1;
    vc.rowOptions2 = _rowOptions2;
}


-(BOOL)navigationShouldPopOnBackButton {                                        // overide default navigation back button and use custom segue
    _rowOptions1 = [_rowOptions1Copy copy];                                     // delete any changes made
    _rowOptions2 = [_rowOptions2Copy copy];
    
    [self performSegueWithIdentifier:@"UnwindToWelcome" sender:nil];
    return NO;
}

#pragma table view                                                              // fill table data

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"OptionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {                                                    // fill table with selected data and indent 
        case 0:
            cell.textLabel.text = @"New Text:";
            break;
        case 1:
            cell.textLabel.text = _rowOptions1.selected;
            cell.indentationWidth = 20.0;
            break;
        case 2:
            cell.textLabel.text = _rowOptions2.selected;
            cell.indentationWidth = 20.0;
            break;
        default:
            break;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    
    _rowSelected = indexPath.row;                                               // set row selected to decipher rowOptions and table row for updating
    
    switch (_rowSelected) {
        case 1:
            _rowOptions1.indexPath = indexPath;
            break;
        case 2:
            _rowOptions2.indexPath = indexPath;
            break;
        default:
            break;
    }
    
    [self slidePickerUp:YES complete:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

@end
