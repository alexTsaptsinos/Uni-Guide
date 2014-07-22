//
//  RightPanelViewController.h
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightPanelViewControllerDelegate <NSObject>


@end

@interface RightPanelViewController : UIViewController

@property (nonatomic, assign) id<RightPanelViewControllerDelegate> delegate;

@end
