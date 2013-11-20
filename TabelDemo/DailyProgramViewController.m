//
//  DailyProgramViewController.m
//  TabelDemo
//
//  Created by albert on 2013/11/19.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import "DailyProgramViewController.h"
#import "ViewController.h"
#import "GetRadioProgram.h"

@interface DailyProgramViewController ()
{
    NSArray *pRadioProgram;
}
@end



@implementation DailyProgramViewController

@synthesize pRadioProgramUrl;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)fetchedDataForHttpGet:(NSData *)responseData {
    NSError* error;
    NSMutableDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                                          options:NSJSONReadingAllowFragments
                                                                            error:&error];
    if(error!=nil)
    {
        NSLog(@"json transfer error %@", error);
        return;
    }
    
    NSLog(@"json : %@",jsonDictionary);
    // 1) retrieve the URL list into NSArray
    // A simple test of URLListData
    pRadioProgram = [jsonDictionary objectForKey:@"program"];
    if(pRadioProgram==nil)
    {
        NSLog(@"URLListData load error!!");
        return;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    NSLog(@"pRadioProgramUrl=%@",self.pRadioProgramUrl);
//    [GetRadioProgram GetRequest:pRadioProgramUrl];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        {
            NSData* pJsonData;
            pJsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:self.pRadioProgramUrl]];
            [self performSelectorOnMainThread:@selector(fetchedDataForHttpGet:) withObject:pJsonData waitUntilDone:YES];
//        }
//    });
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pRadioProgram count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *URLDict = [pRadioProgram objectAtIndex:indexPath.row];
    cell.textLabel.text = [URLDict valueForKey:@"programName"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
