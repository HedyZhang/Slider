//
//  RootViewController.m
//  Slider
//
//  Created by 张海迪 on 14-7-21.
//  Copyright (c) 2014年 haidi. All rights reserved.
//

#import "RootViewController.h"
@interface RootViewController ()
{
    UIImageView *_thumbnail;
    UISlider *_slider;
}
@end

#define kSliderThumbSize 32.0
#define THUMBNAIL_THUMB_MAGIN 15.0

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(30, 40, 500, 5)];

    [_slider addTarget:self action:@selector(scrubbingDidBegin) forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self action:@selector(scrubberIsScrolling) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(scrubbingDidEnd) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel];

    [self.view addSubview:_slider];
 
    
}

- (CGPoint)getThumbCenter
{
    CGFloat availableWidth = _slider.frame.size.width - kSliderThumbSize;
    CGFloat inset = kSliderThumbSize / 2;
    
    CGFloat y = _slider.frame.origin.y + _slider.frame.size.height / 2.f;
    CGFloat x = floorf(_slider.value / _slider.maximumValue * availableWidth) + _slider.frame.origin.x + inset;
    return CGPointMake(x, y);
    //当前拇指的坐标的point

}

//按下开始滑动
- (void)scrubbingDidBegin
{
    CGPoint point = [self getThumbCenter];
    _thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _thumbnail.center = CGPointMake(point.x, point.y + _thumbnail.frame.size.height / 2.f  + THUMBNAIL_THUMB_MAGIN);
    _thumbnail.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_thumbnail];
}
//滑动中
- (void)scrubberIsScrolling
{
    CGPoint point = [self getThumbCenter];
    _thumbnail.center = CGPointMake(point.x, point.y + _thumbnail.frame.size.height / 2.f  + THUMBNAIL_THUMB_MAGIN);

}
//结束滑动
- (void)scrubbingDidEnd
{
    [_thumbnail removeFromSuperview];
    _thumbnail = nil;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
