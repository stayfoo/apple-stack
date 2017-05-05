//
//  LockView.h
//  MYPGestureUnlock
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LockView;

@protocol LockViewDelegate <NSObject>
@optional
- (void)lockView:(LockView *)lockView didFinshPath:(NSString *)path;
@end
@interface LockView : UIView

@property (nonatomic,weak) IBOutlet id<LockViewDelegate> delegate;//代理属性

@end
