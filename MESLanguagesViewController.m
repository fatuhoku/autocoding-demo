//
//  MESLanguagesViewController.m
//  BDDReactiveCocoa
//
//  Created by Hok Shun Poon on 25/03/2014.
//  Copyright (c) 2014 MakeEatSee. All rights reserved.
//

#import "MESLanguagesViewController.h"
#import "MESLanguage.h"
#import "MESCountry.h"
#import "MESLanguageDetailViewController.h"

@interface MESLanguagesViewController () <UIAlertViewDelegate, NSFetchedResultsControllerDelegate>

@property(nonatomic, strong) id fetchedResultsController;
@end

@implementation MESLanguagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // The below performs an initial fetch.
    // TODO Determine whether this caches or not
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY countries == %@", self.country.objectID];
    self.fetchedResultsController = [MESLanguage MR_fetchAllSortedBy:@"name"
                                                           ascending:YES
                                                       withPredicate:predicate
                                                             groupBy:nil delegate:self];

    // RAC bindings
    RAC(self, title) = [RACObserve(self, country) map:^(MESCountry *country){
        return [NSString stringWithFormat:@"Languages spoken in %@", country.name];
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segue_languageDetail"]) {
        MESLanguageDetailViewController *upcoming = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        upcoming.language = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
}


#pragma mark - Actions

- (IBAction)didTouchNewLanguageButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name your new country..."
                                                    message:@"  "
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark - Helper Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // OK
        NSString *name = [alertView textFieldAtIndex:0].text;
        // For now, create a new language. Always.
        MESLanguage *newLanguage = [MESLanguage MR_createEntity];
        newLanguage.name = name;
        // This should automatically add the inverse relationship as well.
        [newLanguage addCountriesObject:self.country];
        // TODO Insert update mechanisms here that would update the listing automatically.
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    MESLanguage *language = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = language.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.f speakers", [language.numSpeakers floatValue]];
}

- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"£££ Context successfully saved (language)");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

#pragma mark - Table View Data Source (Boilerplate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:(NSUInteger) section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ruid_language"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MESLanguage *language = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [language MR_deleteEntity];
        [self saveContext];
    }
}


#pragma mark — Fetched Results Controller Delegate (Boilerplate)

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;

        case NSFetchedResultsChangeMove:
            [tableView                   deleteRowsAtIndexPaths:[NSArray
                    arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView                      insertRowsAtIndexPaths:[NSArray
                    arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    [self saveContext];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
