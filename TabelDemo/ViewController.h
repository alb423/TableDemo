//
//  ViewController.h
//  TabelDemo
//
//  Created by albert on 2013/11/13.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *FavoriteTableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *FavoriteTableViewCell;
@property (strong, nonatomic) NSArray *URLListData;
@property NSInteger IndexSelected;
- (void)ProcessJsonDataForBroadCastURL:(NSData *)pJsonData;
@end
