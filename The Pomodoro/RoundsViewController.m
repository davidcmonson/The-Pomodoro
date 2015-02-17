//
//  RoundsViewController.m
//  The Pomodoro
//
//  Created by Julien Guanzon on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"
#import "POTimer.h"
#import "TimerViewController.h"

static NSString *reuseID = @"reuseID";

@interface RoundsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation RoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    
    
}

- (NSArray *) timesArray {
    NSArray *times = @[@25, @5, @25, @5, @25, @5, @25, @15];
    return times;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self timesArray].count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentRound = indexPath.row;
    [self roundSelected];
    [[POTimer sharedInstance]cancelTimer];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ MINUTES", [self timesArray][indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)roundSelected {
//    WTF?????
    [POTimer sharedInstance].minutes = [[self timesArray][self.currentRound] integerValue];
    [POTimer sharedInstance].seconds = 0;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"currentRoundNotification" object:nil];
    
}

-(void)roundComplete {
    if (self.currentRound != [self timesArray].count - 1) {
        self.currentRound++;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self roundSelected];
    }
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

@end
