//
//  CommunicationTableViewController.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "CommunicationTableViewController.h"
#import "CommunicationTableViewCell.h"
#import "ContactTableViewCell.h"

@interface CommunicationTableViewController ()




@end

@implementation CommunicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // dummy data:
    self.image = @[@"0", @"1", @"2", @"3", @"4", @"5"];
    self.date = @[@"Monday, March 14, 2016",
                  @"Wednesday, March 16, 2016",
                  @"Thursday, March 31, 2016",
                  @"Monday, April 4, 2016",
                  @"Monday, April 4, 2016",
                  @"Tuesday, April 5, 2016"];
    self.time = @[@"4:00pm",
                  @"11:15am",
                  @"3:45pm",
                  @"11:05am",
                  @"4:30pm",
                  @"2:20pm"];
    self.treatment = @[@"Blood Tests with Dr. Dorian",
                       @"Examination with Dr. Scully",
                       @"Allergy Test with Dr. Evil",
                       @"Vaccination with Dr. Quinn",
                       @"Blood Tests with Dr. Spock",
                       @"X-Rays with Dr. Mario"];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Communication";
    }
    else if (section == 1) {
        return @"My Appointments";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;

    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CummunicationsCell" forIndexPath:indexPath];
        
    }
    else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
        
        // dummy data:
        NSInteger row = [indexPath row];
        cell.imageView.image = [UIImage imageNamed:self.image[row]];
    
    }
    
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
