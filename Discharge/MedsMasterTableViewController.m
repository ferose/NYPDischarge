//
//  MedsMasterTableViewController.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

//https://navhealth.herokuapp.com/api/fhir/MedicationOrder?patient=

#import "MedsMasterTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Networking.h"
#import "MedTableViewCell.h"
#import "Medication.h"
#import "Networking.h"

@interface MedsMasterTableViewController ()

@property (nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic) NSMutableArray *medications;

@end

@implementation MedsMasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 121;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableFooterView = [UIView new];
    self.manager = [[AFHTTPSessionManager alloc] init];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.medications = [[NSMutableArray alloc] init];
    [self populateTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) populateTableView{

    [self.medications removeAllObjects];
    
    [[Networking shared] queryResource:@"MedicationOrder" withParams:nil success:^(NSDictionary *json) {
        
        if ([[json objectForKey:@"entry"] count] > 0) {
            for (NSDictionary* med in [json objectForKey:@"entry"]) {
                Medication *medication = [[Medication alloc] init];
                
                
                
                NSDictionary * dosageInstruction = [[[med objectForKey:@"resource"] objectForKey:@"dosageInstruction"] firstObject];
                NSDictionary * repeat = [[dosageInstruction objectForKey:@"timing"] objectForKey:@"repeat"];
                NSDictionary * doseQuantity = [dosageInstruction objectForKey:@"doseQuantity"];
                
                NSString * dosage = [NSString stringWithFormat:@"%@%@", [doseQuantity objectForKey:@"value"], [doseQuantity objectForKey:@"unit" ]];
                NSString * frequency = [NSString stringWithFormat:@"%@ %@", [repeat objectForKey:@"frequency"], [repeat objectForKey:@"periodUnits" ]];
                medication.dosage = dosage;
                medication.frequency = frequency;
                
                NSString *medURL = [[[med objectForKey:@"resource"] objectForKey:@"medicationReference"] objectForKey:@"reference"];
                
                NSString *newURL = [NSString stringWithFormat:@"https://navhealth.herokuapp.com/api/fhir/%@", medURL];
                
                [self.manager GET:newURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    NSLog(@"progress");
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSError *error;
                    NSDictionary *medData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                    NSString *drugName = [[[[medData objectForKey:@"code"] objectForKey:@"coding"] firstObject] objectForKey:@"display"];
                    NSString *drugName2;
                    
                    
                    NSScanner *scanner = [NSScanner scannerWithString:drugName];
                    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                    
                    // Throw away characters before the first number.
                    [scanner scanUpToCharactersFromSet:numbers intoString:&drugName2];
                    
                    
                    medication.name = drugName2;
                    
                    [self.medications addObject:medication];
                    
                    [self.tableView reloadData];
                    
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"fail");
                }];
                
            }
            
        }

        
    } failure:^(NSError *error) {
        
    }];
    
    
    
//    NSString * url = [[NSString stringWithFormat:@"https://navhealth.herokuapp.com/api/fhir/MedicationOrder?patient=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"id"]] stringByAddingPercentEscapesUsingEncoding:
//                      NSASCIIStringEncoding];
//    
//    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSError *error;
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
//        if ([[json objectForKey:@"entry"] count] > 0) {
//            for (NSDictionary* med in [json objectForKey:@"entry"]) {
//                Medication *medication = [[Medication alloc] init];
//                
//                
//                
//                NSDictionary * dosageInstruction = [[[med objectForKey:@"resource"] objectForKey:@"dosageInstruction"] firstObject];
//                NSDictionary * repeat = [[dosageInstruction objectForKey:@"timing"] objectForKey:@"repeat"];
//                NSDictionary * doseQuantity = [dosageInstruction objectForKey:@"doseQuantity"];
//                
//                NSString * dosage = [NSString stringWithFormat:@"%@%@", [doseQuantity objectForKey:@"value"], [doseQuantity objectForKey:@"unit" ]];
//                NSString * frequency = [NSString stringWithFormat:@"%@ %@", [repeat objectForKey:@"frequency"], [repeat objectForKey:@"periodUnits" ]];
//                medication.dosage = dosage;
//                medication.frequency = frequency;
//                
//                NSString *medURL = [[[med objectForKey:@"resource"] objectForKey:@"medicationReference"] objectForKey:@"reference"];
//                
//                NSString *newURL = [NSString stringWithFormat:@"https://navhealth.herokuapp.com/api/fhir/%@", medURL];
//                [self.manager GET:newURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//                    NSLog(@"progress");
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    NSError *error;
//                    NSDictionary *medData = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
//                    NSString *drugName = [[[[medData objectForKey:@"code"] objectForKey:@"coding"] firstObject] objectForKey:@"display"];
//                    NSString *drugName2;
//                    
//                    
//                    NSScanner *scanner = [NSScanner scannerWithString:drugName];
//                    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//                    
//                    // Throw away characters before the first number.
//                    [scanner scanUpToCharactersFromSet:numbers intoString:&drugName2];
//                    
//                    
//                    medication.name = drugName2;
//
//                    [self.medications addObject:medication];
//                    
//                    [self.tableView reloadData];
//                    
//                    
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    NSLog(@"fail");
//                }];
//               
//            }
//            
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//        
//    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.medications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedCell" forIndexPath:indexPath];
    Medication * med =[self.medications objectAtIndex:indexPath.row];
    cell.drugName.text = med.name;
    cell.dosage.text = med.dosage;
    cell.frequency.text = med.frequency;
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
