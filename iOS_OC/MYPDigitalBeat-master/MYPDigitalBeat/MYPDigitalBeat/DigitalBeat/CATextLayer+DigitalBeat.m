//
//  CATextLayer+DigitalBeat.m
//  MYPDigitalBeat
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 MengYP. All rights reserved.
//

#import "CATextLayer+DigitalBeat.h"

//默认值设置
#define kPointsNumber 100 // 数字跳100次
#define kDurationTime 5.0 // 动画时间
#define kStartNumber  0   // 起始数字
#define kEndNumber    1000// 结束数字

typedef struct
{
    float x;
    float y;
} Point2D;

@interface BezierCurve : NSObject
Point2D PointOnCubicBezier(Point2D* cp, float t);
@end
@implementation BezierCurve
/* cp 在此是四个元素的数组:
 cp[0] 为起点，或上图中的 P0
 cp[1] 为第一控制点，或上图中的 P1
 cp[2] 为第二控制点，或上图中的 P2
 cp[3] 为结束点，或上图中的 P3
  t 为参数值，0 <= t <= 1
 */
Point2D PointOnCubicBezier( Point2D* cp, float t )
{
    //    x = (1-t)^3 *x0 + 3*t*(1-t)^2 *x1 + 3*t^2*(1-t) *x2 + t^3 *x3
    //    y = (1-t)^3 *y0 + 3*t*(1-t)^2 *y1 + 3*t^2*(1-t) *y2 + t^3 *y3
    float   ax, bx, cx;
    float   ay, by, cy;
    float   tSquared, tCubed;
    Point2D result;
    
    
    cx = 3.0 * (cp[1].x - cp[0].x);
    bx = 3.0 * (cp[2].x - cp[1].x) - cx;
    ax = cp[3].x - cp[0].x - cx - bx;
    
    cy = 3.0 * (cp[1].y - cp[0].y);
    by = 3.0 * (cp[2].y - cp[1].y) - cy;
    ay = cp[3].y - cp[0].y - cy - by;
    
    
    tSquared = t * t;
    tCubed = tSquared * t;
    
    result.x = (ax * tCubed) + (bx * tSquared) + (cx * t) + cp[0].x;
    result.y = (ay * tCubed) + (by * tSquared) + (cy * t) + cp[0].y;
    
    return result;
}
@end


@implementation CATextLayer (DigitalBeat)

NSMutableArray *numberPoints;  //记录每次textLayer更改值的间隔时间及输出值。
float lastTime;
int indexNumber;

Point2D startPoint;
Point2D controlPoint1;
Point2D controlPoint2;
Point2D endPoint;

int _duration;
float _startNumber;
float _endNumber;

- (void)clearValue{
    lastTime = 0;
    indexNumber = 0;
    self.string = [NSString stringWithFormat:@"%.0f",_startNumber];
}

#pragma mark - 接口
- (void)digitalBeatWithDuration:(int)duration
                    fromNumber:(float)startNumber
                      toNumber:(float)endNumber {
    _duration = duration;
    _startNumber = startNumber;
    _endNumber = endNumber;
    
    [self clearValue];
    [self setupPoints];
    [self changeNumberBySelector];
}


- (void)digitalBeat{
    [self digitalBeatWithDuration:kDurationTime fromNumber:kStartNumber toNumber:kEndNumber];
}

#pragma mark - 初始化
- (void)setupPoints {
    // 贝塞尔曲线
    [self setupBezierPoints];
    
    Point2D bezierCurvePoints[4] = {startPoint, controlPoint1, controlPoint2, endPoint};
    numberPoints = [[NSMutableArray alloc] init];
    
    float dt;
    dt = 1.0 / (kPointsNumber - 1);
    
    for (int i = 0; i < kPointsNumber; i++) {
        Point2D point = PointOnCubicBezier(bezierCurvePoints, i*dt);
        float durationTime = point.x * _duration;
        float value = point.y * (_endNumber - _startNumber) + _startNumber;
        [numberPoints addObject:[NSArray arrayWithObjects:[NSNumber numberWithFloat:durationTime], [NSNumber numberWithFloat:value], nil]];
    }
}

- (void)setupBezierPoints {
    
    startPoint.x = 0;
    startPoint.y = 0;
    
    controlPoint1.x = 0.25;
    controlPoint1.y = 0.1;
    
    controlPoint2.x = 0.25;
    controlPoint2.y = 1;
    
    endPoint.x = 1;
    endPoint.y = 1;
}

- (void)changeNumberBySelector {
    
    if (indexNumber >= kPointsNumber) {
        self.string = [NSString stringWithFormat:@"%.0f",_endNumber];
        return;
        
    } else {
        NSArray *pointValues = [numberPoints objectAtIndex:indexNumber];
        indexNumber++;
        float value = [(NSNumber *)[pointValues objectAtIndex:1] intValue];
        float currentTime = [(NSNumber *)[pointValues objectAtIndex:0] floatValue];
        float timeDuration = currentTime - lastTime;
        lastTime = currentTime;
        self.string = [NSString stringWithFormat:@"%.0f",value];
        
        [self performSelector:@selector(changeNumberBySelector) withObject:nil afterDelay:timeDuration];
    }
}

@end
