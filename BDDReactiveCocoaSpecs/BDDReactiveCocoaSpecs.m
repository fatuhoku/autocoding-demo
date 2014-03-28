//
//  BDDReactiveCocoaSpecs.m
//  BDDReactiveCocoaSpecs
//
//  Created by Hok Shun Poon on 13/03/2014.
//  Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import "MESPickerViewDemoViewController.h"
#import "MESAppDelegate.h"
#import "MESCounter.h"
#import "MESCounterViewModel.h"

SpecBegin(MESAppDelegateSpec)

describe(@"Main Storyboard", ^{
    __block UIStoryboard *storyboard;

    beforeEach(^{
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    });

    context(@"when first loaded", ^{
        __block id initialViewController;
        beforeEach(^{
            // Instantiate the initial view controller.
            // See point 5. under "Configuring the Initial View Controller at Launch"
            // https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/ManagingDataFlowBetweenViewControllers/ManagingDataFlowBetweenViewControllers.html
            initialViewController = storyboard.instantiateInitialViewController;
        });
        // This is a dated test. The Counter controller has long since been blitzed out of existence!
        pending(@"should display the counter view", ^{
            expect(initialViewController).to.beInstanceOf([MESPickerViewDemoViewController class]);
        });
    });
});


describe(@"AppDelegate", ^{
    __block MESAppDelegate *delegate;

    beforeEach(^{
        delegate = [[MESAppDelegate alloc] init];
    });
    context(@"when the app is finished loading", ^{
        __block id mockCounterViewController;
        beforeEach(^{
            // Set up window; attach a view controller to the rootViewController property.
            // See point 2., 3., 6. and 7. under "Configuring the Initial View Controller at Launch"
            // https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/ManagingDataFlowBetweenViewControllers/ManagingDataFlowBetweenViewControllers.html

            id mockWindow = mock([UIWindow class]);
            delegate.window = mockWindow;

            mockCounterViewController = mock([MESPickerViewDemoViewController class]);
            [given([mockWindow rootViewController]) willReturn:mockCounterViewController];

            [delegate application:nil didFinishLaunchingWithOptions:nil];
        });
    });
});

// Basically, here we focus on testing logic of interaction & transformation.
describe(@"Counter Exercise", ^{
    context(@"counter", ^{
        __block MESCounterViewModel *viewModel;
        beforeEach(^{
            viewModel = [[MESCounterViewModel alloc] init];
        });
        it(@"should start with 0", ^{
            expect(viewModel.stringRepresentation).to.equal(@"0");
        });

        context(@"incrementing", ^{
            beforeEach(^{
                [viewModel increment];
            });
            it(@"should increment the counter by 1", ^{
                expect(viewModel.stringRepresentation).to.equal(@"1");
            });
            context(@"twice", ^{
                beforeEach(^{
                    [viewModel increment];
                });
                it(@"should increment the counter by 2", ^{
                    expect(viewModel.stringRepresentation).to.equal(@"2");
                });
            });
        });
        context(@"decrementing", ^{
            beforeEach(^{
                [viewModel decrement];
            });
            it(@"should decrement the counter by 1", ^{
                expect(viewModel.stringRepresentation).to.equal(@"-1");
            });
            context(@"twice", ^{
                beforeEach(^{
                    [viewModel decrement];
                });
                it(@"should increment the counter by 2", ^{
                    expect(viewModel.stringRepresentation).to.equal(@"-2");
                });
            });
        });
    });
});

SpecEnd
