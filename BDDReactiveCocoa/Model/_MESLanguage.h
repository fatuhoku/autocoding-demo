// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MESLanguage.h instead.

#import <CoreData/CoreData.h>


extern const struct MESLanguageAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *numSpeakers;
	__unsafe_unretained NSString *sample;
} MESLanguageAttributes;

extern const struct MESLanguageRelationships {
	__unsafe_unretained NSString *countries;
} MESLanguageRelationships;

extern const struct MESLanguageFetchedProperties {
} MESLanguageFetchedProperties;

@class MESCountry;





@interface MESLanguageID : NSManagedObjectID {}
@end

@interface _MESLanguage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MESLanguageID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* numSpeakers;



@property float numSpeakersValue;
- (float)numSpeakersValue;
- (void)setNumSpeakersValue:(float)value_;

//- (BOOL)validateNumSpeakers:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* sample;



//- (BOOL)validateSample:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *countries;

- (NSMutableSet*)countriesSet;





@end

@interface _MESLanguage (CoreDataGeneratedAccessors)

- (void)addCountries:(NSSet*)value_;
- (void)removeCountries:(NSSet*)value_;
- (void)addCountriesObject:(MESCountry*)value_;
- (void)removeCountriesObject:(MESCountry*)value_;

@end

@interface _MESLanguage (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveNumSpeakers;
- (void)setPrimitiveNumSpeakers:(NSNumber*)value;

- (float)primitiveNumSpeakersValue;
- (void)setPrimitiveNumSpeakersValue:(float)value_;




- (NSString*)primitiveSample;
- (void)setPrimitiveSample:(NSString*)value;





- (NSMutableSet*)primitiveCountries;
- (void)setPrimitiveCountries:(NSMutableSet*)value;


@end
