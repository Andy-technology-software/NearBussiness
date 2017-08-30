//
//  CLAnimationView.m
//  E展汇
//
//  Created by lingnet on 16/1/22.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import "CLAnimationView.h"
#import "CLView.h"
#define  HH  60
#define SCREENWIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height


@interface CLAnimationView ()
@property (nonatomic,strong) UIView *largeView;
@property (nonatomic) CGFloat count;
@end

@implementation CLAnimationView



- (id)initWithTitleArray:(NSArray *)titlearray picarray:(NSArray *)picarray{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.largeView = [[UIView alloc]init];
        [_largeView  setFrame:CGRectMake(0, [MyController getScreenHeight] ,SCREENWIDTH,HH)];
        [_largeView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_largeView];
        
        __weak typeof (self) selfBlock = self;
        for (int i = 0; i < 3; i ++) {
            CLView *rr = [[CLView alloc]initWithFrame:CGRectMake(i % 3 *(SCREENWIDTH / 3), 0, SCREENWIDTH/3, 60)];
            rr.tag = 10 + i;
            rr.sheetBtn.tag = i + 1;
            [rr.sheetBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picarray[i]]] forState:UIControlStateNormal];
            [rr.sheetLab setText:[NSString stringWithFormat:@"%@",titlearray[i]]];
            [rr selectedIndex:^(NSInteger index) {
                [self dismiss];
                self.block(index);
            }];
            
            [self.largeView addSubview:rr];
        }
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc]initWithTarget:selfBlock action:@selector(dismiss)];
        [selfBlock addGestureRecognizer:dismissTap];
    }
    return self;
}

- (void)selectedWithIndex:(CLBlock)block
{
    self.block = block;
}


//- (void)btnClick:(UIButton *)btn
//{
    //self.block(self.sheetBtn.tag);
//}

//- (void)selectedIndex:(RRBlock)block
//{
    //self.block = block;
//}



- (void)CLBtnBlock:(CLBtnBlock)block
{
    self.btnBlock = block;
}


- (void)chooseBtnClick:(UIButton *)sender
{
    self.btnBlock(sender);
     [self dismiss];
}


-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _largeView.transform = CGAffineTransformMakeTranslation(0,  - HH);
    } completion:^(BOOL finished) {
        for (int i = 0; i < 3; i ++) {
            
            CGPoint location = CGPointMake(SCREENWIDTH/3* (i%3) + (SCREENWIDTH/6), 35);
            
            CLView *rr =  (CLView *)[self viewWithTag:10 + i];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    rr.center=location; //CGPointMake(160, 284);
                } completion:nil];
  
            });
        }
    }];
    
    
    
}

- (void)tap:(UITapGestureRecognizer *)tapG {
    [self dismiss];
}



- (void)dismiss {
    [UIView animateWithDuration:0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        _largeView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
