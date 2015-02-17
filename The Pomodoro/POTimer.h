//
//  POTimer.h
//  The Pomodoro
//
//  Created by Julien Guanzon on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *disableButton = @"disableButton";

@interface POTimer : NSObject

@property (nonatomic, assign)NSInteger minutes;
@property (nonatomic, assign)NSInteger seconds;
@property (nonatomic) BOOL isOn;

+ (POTimer *)sharedInstance;

- (void)startTimer;

- (void)cancelTimer;

@end
