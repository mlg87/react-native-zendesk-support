//
//  RNZenDeskSupport.m
//
//  Created by Patrick O'Connor on 8/30/17.
//

#import "RNZenDeskSupport.h"
#import <React/RCTConvert.h>
#import <ZendeskSDK/ZendeskSDK.h>
@implementation RNZenDeskSupport

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showHelpCenterWithOptions:(NSDictionary *)options) {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];
    BOOL articleVotingEnabled = YES;
    BOOL hideContactSupport = false;
    if (options[@"articleVotingEnabled"]) {
        articleVotingEnabled = [RCTConvert BOOL:options[@"articleVotingEnabled"]];
    }
    if (options[@"hideContactSupport"]) {
        hideContactSupport = [RCTConvert BOOL:options[@"hideContactSupport"]];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKHelpCenterOverviewContentModel *helpCenterContentModel = [ZDKHelpCenterOverviewContentModel defaultContent];
        helpCenterContentModel.hideContactSupport = hideContactSupport;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [ZDKConfig instance].articleVotingEnabled = articleVotingEnabled;
        [ZDKHelpCenter presentHelpCenterOverview:vc withContentModel:helpCenterContentModel];
    });
}

RCT_EXPORT_METHOD(showCategoriesWithOptions:(NSArray *)categories options:(NSDictionary *)options) {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];
    BOOL articleVotingEnabled = YES;
    BOOL hideContactSupport = false;
    if (options[@"articleVotingEnabled"]) {
        articleVotingEnabled = [RCTConvert BOOL:options[@"articleVotingEnabled"]];
    }
    if (options[@"hideContactSupport"]) {
        hideContactSupport = [RCTConvert BOOL:options[@"hideContactSupport"]];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKHelpCenterOverviewContentModel *helpCenterContentModel = [ZDKHelpCenterOverviewContentModel defaultContent];
        helpCenterContentModel.groupType = ZDKHelpCenterOverviewGroupTypeCategory;
        helpCenterContentModel.groupIds = categories;
        helpCenterContentModel.hideContactSupport = hideContactSupport;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [ZDKConfig instance].articleVotingEnabled = articleVotingEnabled;
        [ZDKHelpCenter presentHelpCenterOverview:vc withContentModel:helpCenterContentModel];
    });
}

RCT_EXPORT_METHOD(showSectionsWithOptions:(NSArray *)sections options:(NSDictionary *)options) {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];
    BOOL articleVotingEnabled = YES;
    BOOL hideContactSupport = false;
    if (options[@"articleVotingEnabled"]) {
        articleVotingEnabled = [RCTConvert BOOL:options[@"articleVotingEnabled"]];
    }
    if (options[@"hideContactSupport"]) {
        hideContactSupport = [RCTConvert BOOL:options[@"hideContactSupport"]];
    }


    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKHelpCenterOverviewContentModel *helpCenterContentModel = [ZDKHelpCenterOverviewContentModel defaultContent];
        helpCenterContentModel.groupType = ZDKHelpCenterOverviewGroupTypeSection;
        helpCenterContentModel.groupIds = sections;
        helpCenterContentModel.hideContactSupport = hideContactSupport;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [ZDKConfig instance].articleVotingEnabled = articleVotingEnabled;
        [ZDKHelpCenter presentHelpCenterOverview:vc withContentModel:helpCenterContentModel];
    });
}

RCT_EXPORT_METHOD(showLabelsWithOptions:(NSArray *)labels options:(NSDictionary *)options) {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];
    BOOL articleVotingEnabled = YES;
    BOOL hideContactSupport = false;
    if (options[@"articleVotingEnabled"]) {
        articleVotingEnabled = [RCTConvert BOOL:options[@"articleVotingEnabled"]];
    }
    if (options[@"hideContactSupport"]) {
        hideContactSupport = [RCTConvert BOOL:options[@"hideContactSupport"]];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKHelpCenterOverviewContentModel *helpCenterContentModel = [ZDKHelpCenterOverviewContentModel defaultContent];
        helpCenterContentModel.labels = labels;
        helpCenterContentModel.hideContactSupport = hideContactSupport;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [ZDKConfig instance].articleVotingEnabled = articleVotingEnabled;
        [ZDKHelpCenter presentHelpCenterOverview:vc withContentModel:helpCenterContentModel];
    });
}

RCT_EXPORT_METHOD(showHelpCenter) {
    [self showHelpCenterWithOptions:nil];
}

RCT_EXPORT_METHOD(showCategories:(NSArray *)categories) {
    [self showCategoriesWithOptions:categories options:nil];
}

RCT_EXPORT_METHOD(showSections:(NSArray *)sections) {
    [self showSectionsWithOptions:sections options:nil];
}

RCT_EXPORT_METHOD(showLabels:(NSArray *)labels) {
    [self showLabelsWithOptions:labels options:nil];
}

RCT_EXPORT_METHOD(callSupport:(NSDictionary *)identity customFields:(NSDictionary *)customFields) {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];

    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKAnonymousIdentity *zdIdentity = [ZDKAnonymousIdentity new];
        zdIdentity.email = [RCTConvert NSString:identity[@"customerEmail"]];
        zdIdentity.name = [RCTConvert NSString:identity[@"customerName"]];

        NSMutableArray *fields = [[NSMutableArray alloc] init];

        for (NSString* key in customFields) {
            id value = [customFields objectForKey:key];
            [fields addObject: [[ZDKCustomField alloc] initWithFieldId:@(key.intValue) andValue:value]];
        }

        [ZDKConfig instance].userIdentity = zdIdentity;
        [ZDKConfig instance].customTicketFields = fields;
        [ZDKRequests presentRequestCreationWithViewController:vc];
    });
}

RCT_EXPORT_METHOD(supportHistory:(NSDictionary *)identity){
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];

    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKAnonymousIdentity *zdIdentity = [ZDKAnonymousIdentity new];
        zdIdentity.email = [RCTConvert NSString:identity[@"customerEmail"]];
        zdIdentity.name = [RCTConvert NSString:identity[@"customerName"]];
        [ZDKConfig instance].userIdentity = zdIdentity;
        [ZDKRequests presentRequestListWithViewController:vc];

    });
}
@end
