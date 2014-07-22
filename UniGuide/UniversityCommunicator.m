//
//  UniversityCommunicator.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 22/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "UniversityCommunicator.h"
#import "UniversityCommunicatorDelegate.h"

#define API_KEY @"GLXMATX1ZCVS91MN1HYG"


@implementation UniversityCommunicator

-(void)searchAllUniversities
{
    //basic HTTP authentication
    NSURL *url = [NSURL URLWithString:@"http://data.unistats.ac.uk/api/v2/KIS/Institution/{PUBUKPRN}"];
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                  timeoutInterval:12];
    //[self.webView openRequest:request];
    (void)[NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://data.unistats.ac.uk/api/v2/KIS/Institution/{PUBUKPRN}"];
    NSURL *url2 = [[NSURL alloc]initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url2] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingUniversitiesFailedWithError:error];
        } else {
            [self.delegate receivedUniversitiesJSON:data];
        }
    }];
}


//some methods from Abbas' link, no idea where they come in or what they do

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSURLCredential * cred = [NSURLCredential credentialWithUser:@"username"
                                                        password:@"password"
                                                     persistence:NSURLCredentialPersistenceForSession];
    [[NSURLCredentialStorage sharedCredentialStorage]setCredential:cred forProtectionSpace:[challenge protectionSpace]];
    
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection;
{
    return YES;
}

@end
