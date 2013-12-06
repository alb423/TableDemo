//
//  MiscViewController.h
//  TabelDemo
//
//  Created by Liao KuoHsun on 2013/11/30.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiscViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    ;
}
@property (strong, nonatomic) IBOutlet UITableViewCell *Cell1;

@property (strong, nonatomic) IBOutlet UITableView *MiscTableView;

@property (weak, nonatomic) IBOutlet UILabel *TestLabel;


- (IBAction)MiscBackButtonClicked:(id)sender;
@end
