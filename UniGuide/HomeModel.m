//
//  HomeModel.m
//  UniGuide
//
//  Created by AlexTsaptsinos on 21/07/2014.
//  Copyright (c) 2014 ATsaptsinos. All rights reserved.
//

#import "HomeModel.h"
#import "University.h"

@interface HomeModel() {
    
    NSMutableData *_downloadedData;
    
}
@end

@implementation HomeModel

- (void)downloadItems {
    
    //download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"https://accesstoken@data.unistats.ac.uk/api/v2/KIS/Institution/{ukprn}/Course/{kisCourseId}"];
    
    //create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    //create the NSURL connection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    //Initialize the data object
    _downloadedData = [[NSMutableData alloc]init];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //Append the newly downloaded data
    [_downloadedData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //create an array to store the locations
    NSMutableArray *_universities = [[NSMutableArray alloc]init];
    
    //parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    //loop through json objects, create question objects and add them to our questions array
    for (int i=0; i < jsonArray.count; i++) {
        NSDictionary *jsonElement = jsonArray[i];
        
        //create a new location object and set its props to json element propertes
        University *newUniversity = [[University alloc]init];
        newUniversity.universityName = jsonElement[@"Name"];
        newUniversity.universityLocation = jsonElement[@"Location"];
        
        //add this question to the universities array
        [_universities addObject:newUniversity];
    }
    
    //ready to notify delegate that data is ready and pass back items
    if (self.delegate) {
        [self.delegate itemsDownloaded:_universities];
    }
}


@end
