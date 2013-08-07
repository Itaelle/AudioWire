//
//  SubPlayer.m
//  AudioWireApp
//
//  Created by Derivery Guillaume on 8/2/13.
//  Copyright (c) 2013 Derivery Guillaume. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ANPopOverSlider.h"
#import "PlayerViewController.h"
#import "SubPlayer.h"

@implementation SubPlayer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

-(id) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

-(void) myInit
{
    isPlaying = false;
    isSoundOpen = false;
    
    // Test
    [_lbMusicPlaying setText:@" Paul Kalkbrenner - Peet [Berlin Calling] Et ca c'est du blabla pour voir si ca passe ou ca casse !!!"];
    [_lbMusicTime setText:@"2:35 / 1:08:29"];

    [self setUpViews];
}

- (void) setUpViews
{
    // Slider Volume Placement
    _sliderVolume.popupView.hidden = true;
    CGRect sliderPos = _viewSlider.frame;
    sliderPos.origin.x = _viewSlider.frame.origin.x + _viewSlider.frame.size.width;
    [_viewSlider setFrame:sliderPos];
    _viewSlider.layer.borderWidth = 1;
    _viewSlider.layer.borderColor = [[UIColor blackColor] CGColor];
    _viewSlider.layer.cornerRadius = 10;
    [_viewSlider setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    
    CGRect label = _lbMusicPlaying.frame;
    label.size = [_lbMusicPlaying.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [_lbMusicPlaying setFrame:label];
    
    if (!_timer)
    {
        NSDate *run = [NSDate dateWithTimeIntervalSinceNow:DELAY_BEFORE_SLIDING_TITLE];
        
        _timer = [[NSTimer alloc] initWithFireDate:run interval:0.05 target:self selector:@selector(timerFinish:) userInfo:nil repeats:true];
        
        NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
        [theRunLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    else
    {
        // Quand il relancé.
    }
}

-(IBAction) timerFinish:(id) sender
{
    CGRect labelTopFrame = _lbMusicPlaying.frame;
    if (labelTopFrame.origin.x + labelTopFrame.size.width > 0)
    {
        labelTopFrame.origin.x -= 2;
    }
    else
    {
        labelTopFrame.origin.x = 269;
    }
    
    [_lbMusicPlaying setFrame:labelTopFrame];
}

- (IBAction)clickVolumeIcon:(id)sender
{
    if (_isSliderVolumeOpened == false)
    {
        CGRect sliderOpened = _viewSlider.frame;
        sliderOpened.origin.x = 10;
        _isSliderVolumeOpened = true;
        
        [UIView animateWithDuration:(0.1) animations:^{
            //[_lbMusicPlaying setAlpha:0];
            //[_lbMusicTime setAlpha:0];
            [_playButton setAlpha:0];
            [_prevButton setAlpha:0];
            [_nextButton setAlpha:0];
        } completion:^(BOOL finished)
        {
            if (finished)
            {
                [UIView animateWithDuration:(0.5) animations:^{
                    [_viewSlider setFrame:sliderOpened];
                }];
            }
        }];
    }
    else
    {
        CGRect sliderPos = _viewSlider.frame;
        sliderPos.origin.x = _viewSlider.frame.origin.x + _viewSlider.frame.size.width;
        
        
        [UIView animateWithDuration:(0.5) animations:^{
            [_viewSlider setFrame:sliderPos];
        } completion:^(BOOL finished) {
            if (finished)
            {
                [UIView animateWithDuration:(0.2) animations:^{
//                    [_lbMusicPlaying setAlpha:1];
//                    [_lbMusicTime setAlpha:1];
                    [_playButton setAlpha:1];
                    [_prevButton setAlpha:1];
                    [_nextButton setAlpha:1];
                }];
                _isSliderVolumeOpened = false;
            }
        }];
        
    }
}
- (IBAction)clickPlay:(id)sender
{
    isPlaying = !isPlaying;
    if (isPlaying == true)
    {
        // Play Music
        [_playButton setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)clickTitleGoToPlayer:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectPlayer)])
    {
        [_delegate performSelector:@selector(didSelectPlayer)];
    }
}

- (IBAction)editSliderVolume:(id)sender
{
    if (sender && [sender isKindOfClass:[ANPopoverSlider class]])
    {
        ANPopoverSlider *temp = sender;
        float value = temp.value;
        NSLog(@"Value volume %f", value);
    }
}

@end
