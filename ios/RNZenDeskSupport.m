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

RCT_EXPORT_METHOD(callSupport:(NSDictionary *)identity customFields:(NSDictionary *)customFields) {
    NSString *customerName = [RCTConvert NSString:identity[@"customerName"]];
    NSString *customerEmail = [RCTConvert NSString:identity[@"customerEmail"]];

    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];
    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKAnonymousIdentity *identity = [ZDKAnonymousIdentity new];
        identity.email = customerEmail;
        identity.name = customerName;

        NSMutableArray *fields = [[NSMutableArray alloc] init];

        for (NSString* key in customFields) {
            id value = [customFields objectForKey:key];
            [fields addObject: [[ZDKCustomField alloc] initWithFieldId:@(key.intValue) andValue:value]];
        }

        [ZDKConfig instance].userIdentity = identity;
        [ZDKConfig instance].customTicketFields = fields;
        [ZDKRequests presentRequestCreationWithViewController:vc];
    });
}

RCT_EXPORT_METHOD(supportHistory:(NSDictionary *)params){
    NSString *customerName = [RCTConvert NSString:params[@"customerName"]];
    NSString *customerEmail = [RCTConvert NSString:params[@"customerEmail"]];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = [window rootViewController];
    dispatch_async(dispatch_get_main_queue(), ^{
        ZDKAnonymousIdentity *identity = [ZDKAnonymousIdentity new];
        identity.email = customerEmail;
        identity.name = customerName;
        [ZDKConfig instance].userIdentity = identity;
        [ZDKRequests presentRequestListWithViewController:vc];

    });
}
@end
