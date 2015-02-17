//
//  TimerViewController.m
//  The Pomodoro
//
//  Created by Julien Guanzon on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TimerViewController.h"
#import "POTimer.h"
#import "RoundsViewController.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@end

@implementation TimerViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self registerForNotifications];
    } return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateTimerLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    RoundsViewController *roundsView = [[RoundsViewController alloc]
//                                        init];
//    
//    [roundsView setCurrentRound:0];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"secondTickNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"currentRoundNotification" object:nil];
    
}

- (IBAction)timerAction:(UIButton *)sender {
    [[POTimer sharedInstance] startTimer];
    self.timerButton.enabled = NO;
}
- (IBAction)pauseButton:(id)sender {
    [[POTimer sharedInstance] cancelTimer];
    self.timerButton.enabled = YES;
}

- (void)updateTimerLabel {
    NSInteger minutes = [POTimer sharedInstance].minutes;
    NSInteger seconds = [POTimer sharedInstance].seconds;
    self.timerLabel.text = [NSString stringWithFormat:@"%02li:%02li", minutes, seconds];

}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name:@"secondTickNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableEnableButton) name:disableButton object:nil];
    
}

-(void)disableEnableButton {
    self.timerButton.enabled = YES;
}

- (void)newRound {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roundSelected) name:@"currentRoundNotification" object:nil];
    [self updateTimerLabel];
//    self.timerButton.enabled = YES;
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
