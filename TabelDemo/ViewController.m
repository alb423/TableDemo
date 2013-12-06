//
//  ViewController.m
//  TabelDemo
//
//  Created by albert on 2013/11/13.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import "ViewController.h"
#import "DailyProgramViewController.h"
@interface ViewController ()
{
NSString *pUserSelectedURL;
}
@end


@implementation ViewController
@synthesize URLListData, FavoriteTableView, FavoriteTableViewCell, IndexSelected;

#define DEFAULT_BROADCAST_URL @"hinet_radio_json.json"

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *pJsonDataPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:DEFAULT_BROADCAST_URL];
    NSData *pJsonData = [[NSFileManager defaultManager] contentsAtPath:pJsonDataPath];
    [self ProcessJsonDataForBroadCastURL:pJsonData];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - JSON parser
- (void)ProcessJsonDataForBroadCastURL:(NSData *)pJsonData
{
    //parse out the json data
    NSError* error;
    
    NSMutableDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:pJsonData //1
                                                                          options:NSJSONReadingAllowFragments
                                                                            error:&error];
    if(error!=nil)
    {
        NSLog(@"json transfer error %@", error);
        return;
        
    }
    
    // 1) retrieve the URL list into NSArray
    // A simple test of URLListData
    URLListData = [jsonDictionary objectForKey:@"url_list"];
    if(URLListData==nil)
    {
        NSLog(@"URLListData load error for %@!!", URLListData);
        return;
    }
}


#pragma mark - URL_list TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"[URLListData count]=%d",[URLListData count]);
    return [URLListData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //static NSString *tableIdentifier = @"FavoriteTable";
    static NSString *tableIdentifier = @"FavoriteRadio";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }    
    NSDictionary *URLDict = [URLListData objectAtIndex:indexPath.row];
    cell.textLabel.text = [URLDict valueForKey:@"title"];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    URLDict = nil;
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *URLDict = [URLListData objectAtIndex:indexPath.row];
    cell.textLabel.text = [URLDict valueForKey:@"title"];
    URLDict = nil;
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *URLDict = [URLListData objectAtIndex:indexPath.row];
    NSString *pRaidoId = [URLDict valueForKey:@"id"];
    NSString *pMyDateString;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    pMyDateString = [dateFormatter stringFromDate:now];
    
    // For different country, the program URL may be different
    // This is for taiwan only
    NSString *pUrl = [[NSString alloc]initWithFormat:@"http://hichannel.hinet.net/ajax/radio/program.do?id=%s&date=%s",
                      [pRaidoId UTF8String],
                      [pMyDateString UTF8String]];
    
#if 1    
    // Instantiating a Storyboard's View Controller Programmatically.
    UIStoryboard *us = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DailyProgramViewController *pDailyProgram = [us instantiateViewControllerWithIdentifier:@"DailyProgram"];
    id NextViewController = pDailyProgram;

    [NextViewController setValue:pUrl forKey:@"pRadioProgramUrl"];
    
    [self presentViewController:pDailyProgram animated:YES completion:nil];
#else
    
    // Test for triggering a Segue Programmatically.
    // performSegueWithIdentifier: the id should a segue rather than a storyboard identifier
    [self performSegueWithIdentifier:@"ShowMiscView" sender:self.view];
    
#endif
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: play the radio that user select
    NSLog(@"didSelectRowAtIndexPath %@",indexPath);
}


@end
