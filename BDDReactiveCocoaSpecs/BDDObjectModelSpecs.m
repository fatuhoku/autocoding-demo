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
#import "MESLanguage.h"
#import "MESCountry.h"
#import "MESContinent.h"
#import "HRCoder.h"
#import "NSArray+F.h"
#import "MagicalRecord+Setup.h"
#import "NSManagedObject+MagicalRecord.h"
#import "NSManagedObjectContext+MagicalRecord.h"
#import "NSManagedObjectContext+MagicalSaves.h"
#import "AutoCoding.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#define MOCKITO_SHORTHAND

#import <OCMockito/OCMockito.h>


SpecBegin(BDDObjectModel)

describe(@"Serializing Core Data objects with AutoCoding", ^{
    beforeEach(^{
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
    });
    afterEach(^{
        [MagicalRecord cleanUp];
    });
    context(@"when working with AutoCoding", ^{
        it(@"should be able to encode Core Data objects with NSKeyedArchiver and NSKeyedUnarchiver", ^{
            MESContinent *europe = [MESContinent MR_createEntity];
            europe.name = @"Europe";
            MESCountry *germany = [MESCountry MR_createEntity];
            germany.name = @"Germany";
            [europe addCountriesObject:germany];
            MESCountry *austria = [MESCountry MR_createEntity];
            austria.name = @"Austria";
            [europe addCountriesObject:austria];
            MESLanguage *german = [MESLanguage MR_createEntity];
            german.name = @"Deutsch";
            [germany addOfficialLanguagesObject:german];
            [austria addOfficialLanguagesObject:german];

            // Save the context.
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];

            void (^makeAssertions)(MESContinent *continent) = ^(MESContinent *continent) {
                NSArray *countries = [continent.countries allObjects];
                NSArray *countryNames = [countries map:^id(MESCountry *country) {
                    return country.name;
                }];
                expect(countryNames).to.contain(@"Austria");
                expect(countryNames).to.contain(@"Germany");

                // There should be two countries; and both countries should point to one German instance
                expect([countries count]).to.equal(2);
                MESCountry * c1 = countries[0];
                MESCountry * c2 = countries[0];
                MESLanguage *firstCountryLanguage = [c1.officialLanguages allObjects][0];
                MESLanguage *secondCountryLanguage = [c2.officialLanguages allObjects][0];
                expect(firstCountryLanguage).to.beIdenticalTo(secondCountryLanguage);
                expect(firstCountryLanguage.name).to.equal(@"Deutsch");
            };

            makeAssertions(europe);

            // Store 'europe' Continent data with the NSKeyedArchiver
            NSData *outgoingData = [NSKeyedArchiver archivedDataWithRootObject:europe];
            // Pretend that we've stored it somewhere we're not retrieving it
            NSData *incomingData = outgoingData;
            MESContinent *incomingEurope = [NSKeyedUnarchiver unarchiveObjectWithData:incomingData];
            makeAssertions(incomingEurope);
        });
    });
});

SpecEnd
