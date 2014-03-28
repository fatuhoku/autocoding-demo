//
// Created by Hok Shun Poon on 16/03/2014.
// Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MESCounterViewModel : NSObject {
    NSString *_stringRepresentation;
}

@property(nonatomic, readonly) NSString *stringRepresentation;
- (void)increment;
- (void)decrement;

@end