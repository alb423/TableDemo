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

@end


@implementation ViewController
@synthesize URLListData, FavoriteTableView, FavoriteTableViewCell;

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
        //NSString* aStr;
        //aStr = [[NSString alloc] initWithData:pJsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"str=%@",aStr);
        
        NSLog(@"json transfer error %@", error);
        return;
        
    }
    
    // 1) retrieve the URL list into NSArray
    // A simple test of URLListData
    URLListData = [jsonDictionary objectForKey:@"url_list"];
    if(URLListData==nil)
    {
        NSLog(@"URLListData load error!!");
        return;
    }
    //NSLog(@"URLListData=%@",URLListData);
    
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    URLDict = nil;
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *URLDict = [URLListData objectAtIndex:indexPath.row];
    cell.textLabel.text = [URLDict valueForKey:@"title"];
    URLDict = nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set the URL_TO_PLAY to the url user select
    NSDictionary *URLDict = [URLListData objectAtIndex:indexPath.row];
    //[[DailyProgramViewController alloc]initWithStyle:UITableViewStylePlain];
//    pUserSelectedURL = [URLDict valueForKey:@"url"];
//    URLNameToDisplay.text = [URLDict valueForKey:@"title"];
//    URLNameToDisplay.textAlignment = NSTextAlignmentCenter;
//    
}



@end
