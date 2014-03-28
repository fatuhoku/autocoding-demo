//
// Created by Hok Shun Poon on 18/03/2014.
// Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import "MESModel.h"


@implementation MESModel {

}
- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        self.string = string;
    }

    return self;
}

+ (instancetype)modelWithString:(NSString *)string {
    return [[self alloc] initWithString:string];
}

@end