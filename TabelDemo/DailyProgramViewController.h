//
//  DailyProgramViewController.h
//  TabelDemo
//
//  Created by albert on 2013/11/19.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>
//@interface DailyProgramViewController: UITableViewController
@interface DailyProgramViewController : UIViewController <UITableViewDelegate>
{;
}
- (IBAction)RadioProgramBackButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *pDailyProgramToday;

@property (weak, nonatomic) IBOutlet UITableView *DailyProgramDayTable;
@property (weak, nonatomic) IBOutlet UITableView *pDailyProgramTable;

@property (strong) NSString *pRadioProgramUrl;
@end
