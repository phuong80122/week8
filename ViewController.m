//
//  ViewController.m
//  IT-CoreData
//
//  Created by Phuong Nguyen on 2/21/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ViewController.h"

#import "Song.h"
//#import "SongSvcCache.h"
#import "SongSvcSqlite.h"


@interface ViewController ()

@end

@implementation ViewController

//SongSvcCache *songSvc = nil;
SongSvcSQLite *songSvc = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
//    songSvc = [[SongSvcCache alloc] init];
    
    songSvc = [[SongSvcSQLite alloc] init];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[songSvc retrieveAllSongs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:simpleTableIdentifier];
    }
    Song *song = [[songSvc retrieveAllSongs]
                  objectAtIndex:indexPath.row];
    cell.textLabel.text = song.stitle;
    return cell;
}



- (IBAction)saveSong:(id)sender {
    
    NSLog(@"saveSong: entering");
    [self.view endEditing:YES];
    
    Song *song = [[Song alloc] init];
    song.stitle = _stitle.text;
    song.skey = _skey.text;
    song.slyric = _slyric.text;
    [songSvc createSong:song];
    
    
    [self.TableView reloadData];
    
 //   NSLog(@"saveSong");
    
}

- (IBAction)deleteSong:(id)sender {
    
    NSLog(@"deleteSong");
    [self.view endEditing:YES];
}
@end
