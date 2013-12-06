//
//  MiscViewController.m
//  TabelDemo
//
//  Created by Liao KuoHsun on 2013/11/30.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import "MiscViewController.h"

@interface MiscViewController ()

@end

@implementation MiscViewController
@synthesize MiscTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview: MiscTableView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MiscBackButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:TRUE completion:^(void){
        ;
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==1)
        return 1;
    else
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int num = indexPath.row;
    UITableViewCell *cell;
    
//    switch (num) {
//        case 0:
//            cell = self.myFirstCell;
//            break;
//        case 1:
//            cell = self.mySecondCell;
//            break;
//    }
    
    cell = _Cell1;
    return cell;
}




@end
