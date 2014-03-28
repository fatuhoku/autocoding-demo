//
// Created by Hok Shun Poon on 16/03/2014.
// Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import "MESCounterViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>



@interface MESCounterViewModel ()
@property(nonatomic, strong) NSNumber *value;
@end

@implementation MESCounterViewModel
- (id)init {
    self = [super init];
    if (self) {
        self.value = [NSNumber numberWithInt:0];
        RAC(self, stringRepresentation) = [RACObserve(self, value) map:^(NSNumber *n) {
            return [n description];
        }];
    }

    return self;
}

- (void)increment {
    self.value = [NSNumber numberWithInt:[self.value intValue] + 1];
}

- (void)decrement {
    self.value = [NSNumber numberWithInt:[self.value intValue] - 1];
}

- (NSString *)stringRepresentation {
    return [self.value description];
}

@end