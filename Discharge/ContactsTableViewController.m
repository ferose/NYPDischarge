//
//  ContactsTableViewController.m
//  Discharge
//
//  Created by Ferose Babu on 3/13/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "ContactsTableViewController.h"

@interface ContactsTableViewController ()

@property (nonatomic) NSArray* contactInfos;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contactInfos = @[@{@"c": @"Milstein Hospital", @"a": @[
                                    @{@"n": @"Main", @"p": @"(212) 305-2500"},
                                    @{@"n": @"Patient Services", @"p": @"(212) 305-2553"},
                                    @{@"n": @"Social Work", @"p": @"(212) 305-5904"},
                                    @{@"n": @"Food & Nutrition Dept.", @"p": @"(212) 305-9094"}
                                    ]},
                          @{@"c": @"Allen Pavilion", @"a": @[
                                    @{@"n": @"Main", @"p": @"(212) 932-4000"},
                                    @{@"n": @"Patient Services", @"p": @"(212) 932-4255"},
                                    @{@"n": @"Social Work", @"p": @"(212) 932-4321"},
                                    @{@"n": @"Food & Nutrition Dept.", @"p": @"(212) 932-5180"}
                                    ]},
                          @{@"c": @"Milstein Hospital", @"a": @[
                                    @{@"n": @"Main", @"p": @"(212) 305-2500"},
                                    @{@"n": @"Patient Services", @"p": @"(212) 305-1753"},
                                    @{@"n": @"Social Work", @"p": @"(212) 305-5904"},
                                    @{@"n": @"Food & Nutrition Dept.", @"p": @"(212) 305-4901"}
                                    ]}
                          ];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.contactInfos.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.contactInfos[section][@"c"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *contacts = self.contactInfos[section][@"a"];
    return contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell" forIndexPath:indexPath];
    
    NSArray *contacts = self.contactInfos[indexPath.section][@"a"];
    NSDictionary *contact = contacts[indexPath.row];
    cell.textLabel.text = contact[@"n"];
    cell.detailTextLabel.text = contact[@"p"];
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
