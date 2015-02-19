//
//  POTimer.m
//  The Pomodoro
//
//  Created by Julien Guanzon on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimer.h"
#import "TimerViewController.h"



@interface POTimer ()

@property (strong, nonatomic) NSDate *expirationDate;


- (void)endTimer;
- (void)decreaseSecond;
- (void)isActive;

@end

@implementation POTimer

+ (POTimer *)sharedInstance {
    static POTimer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [POTimer new];
    });
    return sharedInstance;
}

- (void)startTimer {
    self.isOn = YES;
    
    UILocalNotification *timerExpiredNotification = [UILocalNotification new];
    
    NSTimeInterval interval = self.minutes * 60 + self.seconds;
    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    timerExpiredNotification.fireDate = self.expirationDate;
    timerExpiredNotification.timeZone = [NSTimeZone defaultTimeZone];
    timerExpiredNotification.soundName = UILocalNotificationDefaultSoundName;
    timerExpiredNotification.alertBody = @"Round Complete. Continue with next round?";
    timerExpiredNotification.alertAction = @"view";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:timerExpiredNotification];
    
    [self isActive];
}

- (void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:disableButton object:nil];

}

- (void)endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"roundCompleteNotification" object:nil];
    TimerViewController *timerViewController = [TimerViewController new];
    [timerViewController newRound];
    [timerViewController updateTimerLabel];
    [self cancelTimer];
    
}

-(void)decreaseSecond {
    if (self.seconds > 0) {
        self.seconds--;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"secondTickNotification" object:nil];
    } else if (self.minutes > 0) {
        self.seconds = 60;
        self.minutes--;
    } else if (self.seconds == 0 && self.minutes == 0) {
        [self endTimer];
    }
}

- (void)isActive {
    if (self.isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(isActive) withObject:nil afterDelay:1];

    }
}

@end
