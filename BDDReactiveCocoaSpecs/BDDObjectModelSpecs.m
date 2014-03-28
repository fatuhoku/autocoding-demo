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

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

SpecBegin(BDDObjectModel)

describe(@"Complex data models", ^{
    context(@"when encoded into JSON", ^{
        it(@"should yield its JSON representation", ^{
            MESLanguage *english = [MESLanguage languageWithName:@"English"]; // mutate to British English
            MESLanguage *french = [MESLanguage languageWithName:@"French"];
            MESLanguage *german = [MESLanguage languageWithName:@"German"];

            MESCountry *uk = [MESCountry countryWithName:@"United Kingdom" officialLanguages:@[english]];
            MESCountry *germany = [MESCountry countryWithName:@"Germany" officialLanguages:@[german]];
            MESCountry *switzerland = [MESCountry countryWithName:@"Switzerland" officialLanguages:@[french, german]];


            MESContinent *europe = [MESContinent continentWithName:@"Europe" countries:@[uk, germany, switzerland]];

            // Invariant Property
            expect(germany.officialLanguages[0]).to.equal(switzerland.officialLanguages[1]);

            // Okay. Get the string for this
            id dictionary = [HRCoder archivedJSONWithRootObject:europe];

            // Okay, now the string represe
            NSError *error;
            NSData *x = [NSJSONSerialization dataWithJSONObject:dictionary options:nil error:&error];
            if (error) {
                [NSException raise:@"Serialization problem." format:@"%@", error.localizedDescription];
            }
            // Let's load the object back out.
            id thing = [NSJSONSerialization JSONObjectWithData:x options:nil error:&error];
            if (error) {
                [NSException raise:@"Deserialization problem." format:@"%@", error.localizedDescription];
            }
            MESContinent *continent = [HRCoder unarchiveObjectWithPlistOrJSON:thing];
            NSLog(@"Continent: %@", continent);
            // Great. If we edit the language of the UK to 'British English'...
            MESCountry *uk2 = [continent.countries firstObject];
            MESCountry *germany2 = continent.countries[1];
            MESCountry *switzerland2 = continent.countries[2];
            expect(uk2.name).to.equal(@"United Kingdom");
            expect(switzerland2.name).to.equal(@"Switzerland");
            expect(germany2.name).to.equal(@"Germany");
            MESLanguage *english2 = uk2.officialLanguages.first;
            // We should see that the Germans have changed their language too.

            expect(germany2.officialLanguages[0]).to.equal(switzerland2.officialLanguages[1]);
            NSLog(@"The second official language of Switzerland is: %@", switzerland2.officialLanguages[1]);
            ((MESLanguage *)switzerland2.officialLanguages[1]).name = @"Swissdootch";
            NSString *nameOfGermanyOfficialLanguage = ((MESLanguage *)germany2.officialLanguages[0]).name;
            expect(nameOfGermanyOfficialLanguage).to.equal(@"Swissdootch");
        });
    });
});

SpecEnd
