//
//  RoundsViewController.h
//  The Pomodoro
//
//  Created by Julien Guanzon on 2/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundsViewController : UIViewController
@property(nonatomic, assign)NSInteger currentRound;
- (void) roundSelected;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
