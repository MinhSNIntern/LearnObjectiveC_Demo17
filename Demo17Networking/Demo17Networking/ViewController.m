//
//  ViewController.m
//  Demo17Networking
//
//  Created by vfa on 8/26/22.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

SOCIAL_EXTERN NSString *const SLServiceTypeTwitter;
SOCIAL_EXTERN NSString *const SLServiceTypeFacebook;
SOCIAL_EXTERN NSString *const SLServiceTypeSinaWeibo;
SOCIAL_EXTERN NSString *const SLServiceTypeTencentWeibo;
SOCIAL_EXTERN NSString *const SLServiceTypeLinkedIn;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadContentSyncOnInternetExample];
    //[self loadContentAsyncOnInternetExample];
    //[self getRequest];
    //[self postRequest];
    //[self deleteRequest];
    //[self serializingArrayAndDictionaryIntoJSON];
    [self jsonToArrayAndDictionary];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Macbook Airs are amazingly thin!"];
        [controller addImage:[UIImage imageNamed:@"MacBookAir"]];
        [controller addURL:[NSURL URLWithString:@"http://www.apple.com"]];
        
        controller.completionHandler = ^(SLComposeViewControllerResult result) {
            NSLog(@"Complete");
        };
        
        [self presentViewController:controller animated:animated completion:nil];
        
    }else{
        NSLog(@"The twitter service is not available");
    }
    
}

-(void) loadContentAsyncOnInternetExample{
    
    NSString * urlString = @"https://www.apple.com";
    
    NSURL *url = [NSURL URLWithString:urlString ];
    //timeout 30s
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if([data length]>0 && connectionError == nil){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HTML: %@",html);
            
        }else if([data length]==0&& connectionError == nil){
            NSLog(@"No data");
            
        }else{
            
            NSLog(@"Error");
        }
    }];
}
-(void) loadContentSyncOnInternetExample{
    
    
    NSLog(@"We are here..............");
    
    NSString *urlString = @"https://www.yahoo.com";
    
    NSURLRequest *request = [self createRequest:urlString timeOut:0];
    
    NSURLResponse *response = nil;
    
    NSError *error = nil;
    
    NSLog(@"Firing sync url connection.......");
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if([data length]>0 && error == nil){
        NSLog(@"%lu bytes of data was returned",[data length]);
        
    }else if([data length]==0&& error == nil){
        NSLog(@"No data");
        
    }else{
        
        NSLog(@"Error");
    }
    
}

-(NSMutableURLRequest *) createRequest:(NSString *)urlString timeOut:
(double) timeOut{
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString:urlString]];
    //if not need to set timeout enter timeout parameter = 0;
    if(timeOut >0) {
        [request setTimeoutInterval:timeOut];
    }
    return request;
}
-(void) getRequest{
    
    NSString *urlAsString = @"https://www.intellectsoft.net";
    
    urlAsString = [urlAsString stringByAppendingString:@"?param1=First"];
    urlAsString = [urlAsString stringByAppendingString:@"&param2=Second"];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if([data length]>0 && connectionError == nil){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
            
            NSLog(@"html = %@",html);
        }
        else if([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was downloaded");
        }else{
            NSLog(@"error");
        }
    } ];
}

-(void) postRequest{
    
    NSString *urlAsString = @"https://www.intellectsoft.net";
    
    urlAsString = [urlAsString stringByAppendingString:@"?param1=First"];
    urlAsString = [urlAsString stringByAppendingString:@"&param2=Second"];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *body = @"bodyParam1=BodyValue1&bodyParam2=BodyValue2";
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if([data length]>0 && connectionError == nil){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
            NSLog(@"html = %@",html);
        }
        else if([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was downloaded");
        }else{
            NSLog(@"error");
        }
    } ];
}

-(void) deleteRequest{
    
    NSString *urlAsString = @"https://www.intellectsoft.net";
    
    urlAsString = [urlAsString stringByAppendingString:@"?param1=First"];
    urlAsString = [urlAsString stringByAppendingString:@"&param2=Second"];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"DELETE"];
    NSString *body = @"bodyParam1=BodyValue1&bodyParam2=BodyValue2";
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if([data length]>0 && connectionError == nil){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
            NSLog(@"html = %@",html);
        }
        else if([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was downloaded");
        }else{
            NSLog(@"error");
        }
    } ];
}
-(void) putRequest{
    
    NSString *urlAsString = @"https://www.intellectsoft.net";
    
    urlAsString = [urlAsString stringByAppendingString:@"?param1=First"];
    urlAsString = [urlAsString stringByAppendingString:@"&param2=Second"];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"PUT"];
    NSString *body = @"bodyParam1=BodyValue1&bodyParam2=BodyValue2";
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if([data length]>0 && connectionError == nil){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
            NSLog(@"html = %@",html);
        }
        else if([data length] == 0 && connectionError == nil){
            NSLog(@"Nothing was downloaded");
        }else{
            NSLog(@"error");
        }
    } ];
}

-(void) serializingArrayAndDictionaryIntoJSON{
    NSDictionary *dictionary =
    @{
        @"First Name" : @"Anthony",
        @"Last Name" : @"Robbins",
        @"Age" : @51,
        @"children" : @[
            @"Anthony's Son 1",
            @"Anthony's Daughter 1",
            @"Anthony's Son 2",
            @"Anthony's Son 3",
            @"Anthony's Daughter 2",
        ],
    };
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if([jsonData length]>0 && error == nil){
        NSLog(@"Succesfully serialized the dictionary into data");
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonString);
    }
    else if([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after serialization");
    }else{
        NSLog(@"error");
    }
}

-(void) jsonToArrayAndDictionary{
    
    NSDictionary *dictionary =
    @{
        @"First Name" : @"Anthony",
        @"Last Name" : @"Robbins",
        @"Age" : @51,
        @"children" : @[
            @"Anthony's Son 1",
            @"Anthony's Daughter 1",
            @"Anthony's Son 2",
            @"Anthony's Son 3",
            @"Anthony's Daughter 2",
        ],
    };
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if([jsonData length]>0 && error == nil){
        NSLog(@"Succesfully serialized the dictionary into data");
        error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if(jsonObject !=nil && error == nil){
            NSLog(@"Successfully deserialized...");
            if([jsonObject isKindOfClass:[NSDictionary class]]){
            
                NSDictionary *deserializedDic= jsonObject;
                NSLog(@"Deserialized JSON Dictionary = %@",deserializedDic);
            }else if ([jsonObject isKindOfClass:[NSArray class]]){
                NSArray *deserializedArr = jsonObject;
                NSLog(@"Deserialized JSON Array = %@",deserializedArr);
            }
            else{}
        }else if (error != nil){
            NSLog(@"deserializing error");
        }
    }
    else if([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after serialization");
    }else{
        NSLog(@"error");
    }
}

@end
