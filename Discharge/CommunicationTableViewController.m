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
#import "Networking.h"
#import "Encounter.h"

@interface CommunicationTableViewController ()




@end

@implementation CommunicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // dummy data:
    self.image = @[@"1", @"2", @"3", @"4", @"5"];
    self.encounters = [[NSMutableArray alloc] init];
    
    
    
    //https://navhealth.herokuapp.com/api/fhir/Encounter?patient=
    
    [[Networking shared] queryResource:@"Encounter" withParams:nil success:^(NSDictionary *result) {
        for (NSDictionary *encounter in [result objectForKey:@"entry"]) {
            
            Encounter *encounterObject = [[Encounter alloc] init];
            
           NSString *dateString = [[[encounter objectForKey:@"resource"] objectForKey:@"period"] objectForKey:@"start"];
            //2013-10-11T00:00:00.000Z
            NSRange startRange = [dateString rangeOfString:@"T"];
            dateString = [dateString substringToIndex:startRange.location];

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *formattedDateString = [dateFormatter dateFromString:dateString];
            NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
            [weekday setDateFormat: @"EEEE, "];
            NSString *weekdayString = [weekday stringFromDate:formattedDateString];
            
            NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
            dateF.timeStyle = NSDateFormatterNoStyle;
            dateF.dateStyle = NSDateFormatterMediumStyle;

            NSString *finalDateString = [weekdayString stringByAppendingString:[dateF stringFromDate:formattedDateString]];
            encounterObject.date = finalDateString;
            encounterObject.cause = [[encounter objectForKey:@"resource"] objectForKey:@"class"];
            [self.encounters addObject:encounterObject];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"fail");
    }];
    
    
    
    
    
    
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
    return self.encounters.count;
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
        return cell;
    }
    else if (indexPath.section == 1) {
        CommunicationTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"AppointmentCell" forIndexPath:indexPath];
        
        // dummy data:
        Encounter *obj = [self.encounters objectAtIndex:indexPath.row];
        cell2.imageView.image = [UIImage imageNamed:self.image[indexPath.row]];
        cell2.labelDate.text = obj.date;
        cell2.labelTreatment.text = obj.cause;
        return cell2;
    
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
