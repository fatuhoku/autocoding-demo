//
//  MESLanguageDetailViewController.m
//  BDDReactiveCocoa
//
//  Created by Hok Shun Poon on 23/03/2014.
//  Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import "MESLanguageDetailViewController.h"
#import "MESLanguage.h"

@interface MESLanguageDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *numberOfSpeakersLabel;
@property (strong, nonatomic) IBOutlet UITextView *languageSampleTextView;
@property (strong, nonatomic) IBOutlet UISlider *numSpeakersSlider;
@end

@implementation MESLanguageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // RAC bindings
    RAC(self, title) = [RACObserve(self, language.name) map:^(NSString *name){
        return [NSString stringWithFormat:@"Language Details: %@", name];
    }];
    RAC(self.numberOfSpeakersLabel, text) = [RACObserve(self, language.numSpeakers) map:^(NSNumber *numSpeakers) {
        return numSpeakers == nil ? @"Unknown" : [NSString stringWithFormat:@"Number of speakers: %.f", [numSpeakers floatValue]];
    }];

    // Pseudo channel for the text view.
    RACChannelTerminal *modelTerminal = RACChannelTo(self, language.sample);
    RAC(self.languageSampleTextView, text) = modelTerminal;
    [[self.languageSampleTextView.rac_textSignal throttle:0.3] subscribe:modelTerminal];

    // Channel for the slider.
    RACChannelTerminal *modelChannel = RACChannelTo(self, language.numSpeakers);
    RACChannelTerminal *sliderChannel = [self.numSpeakersSlider rac_newValueChannelWithNilValue:@0];
    [modelChannel subscribe:sliderChannel];
    [[sliderChannel throttle:0.3] subscribe:modelChannel];
}

@end
