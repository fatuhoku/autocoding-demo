//
//  MESJsonViewController.m
//  BDDReactiveCocoa
//
//  Created by Hok Shun Poon on 28/03/2014.
//  Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import "MESJsonViewController.h"

@interface MESJsonViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MESJsonViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    // RAC bindings
    RAC(self.textView, text) = RACObserve(self, jsonText);
}

- (IBAction)didTouchDoneButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
