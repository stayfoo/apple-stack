//
//  CATextLayer+DigitalBeat.h
//  MYPDigitalBeat
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface CATextLayer (DigitalBeat)

- (void)digitalBeatWithDuration:(int)duration
                    fromNumber:(float)startNumber
                      toNumber:(float)endNumber;

- (void)digitalBeat;

@end
