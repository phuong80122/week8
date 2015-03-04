//
//  ViewController.h
//  IT-CoreData
//
//  Created by Phuong Nguyen on 2/21/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITextField *stitle;
@property (weak, nonatomic) IBOutlet UITextField *skey;
@property (weak, nonatomic) IBOutlet UITextField *slyric;

@property (weak, nonatomic) IBOutlet UITableView *TableView;

- (IBAction)saveSong:(id)sender;

- (IBAction)deleteSong:(id)sender;

@end
