//
//  ViewController.m
//  MYPDigitalBeat
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "ViewController.h"
#import "CATextLayer+DigitalBeat.h"

@interface ViewController ()
@property (nonatomic,strong) CATextLayer *textLayer;

@end

@implementation ViewController
- (IBAction)startClick:(id)sender {
    
    [self.textLayer digitalBeatWithDuration:5 fromNumber:0 toNumber:10000];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.string = @"0";
    textLayer.frame = CGRectMake(15, 100, [UIScreen mainScreen].bounds.size.width-30, 100);
    textLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:textLayer];
    self.textLayer = textLayer;
}




@end
