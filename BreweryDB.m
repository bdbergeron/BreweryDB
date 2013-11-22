//
//  BreweryDB.m
//
//  Copyright (c) 2013 Bradley David Bergeron
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <AFNetworking/AFNetworking.h>

#import "BreweryDB.h"
#import "BDBErrors.h"


NSString * const BreweryDBErrorDomain = @"com.brewerydb.api.error";
NSString * const BreweryDBAPIURL      = @"http://api.brewerydb.com/v2";

NSString * const BreweryDBResponseStatusKey = @"status";
NSString * const BreweryDBResponseErrorKey  = @"errorMessage";
NSString * const BreweryDBResponseDataKey   = @"data";



#pragma mark -
@interface BreweryDB ()

@property (nonatomic) AFHTTPSessionManager *networkManager;

@property (nonatomic, copy) NSString *apiKey;

+ (instancetype)sharedInstance;
- (BOOL)readyToBrew;

- (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description;

@end


#pragma mark -
@implementation BreweryDB

#pragma mark Private Instantiation
+ (instancetype)sharedInstance
{
    static BreweryDB *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _networkManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BreweryDBAPIURL]];

        _apiKey = nil;
    }
    return self;
}

#pragma mark Public Instantiation
+ (instancetype)brew:(NSString *)apiKey
{
    [[[self class] sharedInstance] setApiKey:apiKey];
    return [[self class] sharedInstance];
}

- (BOOL)readyToBrew
{
    return (self.apiKey != nil);
}

#pragma mark Errors
- (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description
{
    return [NSError errorWithDomain:BreweryDBErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:description}];
}

#pragma mark Beers
+ (void)fetchBeersWithParameters:(NSDictionary *)parameters
                 withBreweryInfo:(BOOL)withBreweryInfo
                         success:(void (^)(NSArray *))success
                         failure:(void (^)(NSError *))failure
{
    NSParameterAssert(success);
    NSParameterAssert(failure);

    if (![[[self class] sharedInstance] readyToBrew])
        return failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_MISSING_API_KEY description:BDB_ERROR_MISSING_API_KEY]);

    NSMutableDictionary *mutableParameters = parameters.mutableCopy;
    if (!mutableParameters)
        mutableParameters = [NSMutableDictionary dictionary];
    mutableParameters[@"key"] = [[[self class] sharedInstance] apiKey];

    if (withBreweryInfo)
        mutableParameters[@"withBreweries"] = @"Y";
    
    [[[[self class] sharedInstance] networkManager] GET:@"beers"
                                             parameters:mutableParameters
                                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                                    if ([responseObject isKindOfClass:[NSDictionary class]])
                                                    {
                                                        NSDictionary *response = responseObject;
                                                        if ([response[BreweryDBResponseStatusKey] isEqualToString:@"success"])
                                                        {
                                                            NSMutableArray *beers = [NSMutableArray array];
                                                            for (NSDictionary *dictionary in response[BreweryDBResponseDataKey])
                                                            {
                                                                BDBBeer *beer = [[BDBBeer alloc] initWithDictionary:dictionary];
                                                                if (beer)
                                                                    [beers addObject:beer];
                                                                else
                                                                {
                                                                    failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_BEER_OBJECT_CREATION_FAILED
                                                                                                             description:BDB_ERROR_BEER_OBJECT_CREATION_FAILED]);
                                                                    break;
                                                                }
                                                            }
                                                            success(beers);
                                                        }
                                                        else
                                                            failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_API_ERROR
                                                                                                     description:response[BreweryDBResponseErrorKey]]);
                                                    }
                                                    else
                                                        failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_BAD_API_RESPONSE
                                                                                                 description:BDB_ERROR_BAD_API_RESPONSE]);
                                                }
                                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                    failure(error);
                                                }];
}

+ (void)fetchBeerWithId:(NSString *)beerId
        withBreweryInfo:(BOOL)withBreweryInfo
             parameters:(NSDictionary *)parameters
                success:(void (^)(BDBBeer *))success
                failure:(void (^)(NSError *))failure
{
    NSParameterAssert(success);
    NSParameterAssert(failure);

    if (![[[self class] sharedInstance] readyToBrew])
        return failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_MISSING_API_KEY description:BDB_ERROR_MISSING_API_KEY]);

    NSMutableDictionary *mutableParameters = parameters.mutableCopy;
    if (!mutableParameters)
        mutableParameters = [NSMutableDictionary dictionary];
    mutableParameters[@"key"] = [[[self class] sharedInstance] apiKey];

    if (withBreweryInfo)
        mutableParameters[@"withBreweries"] = @"Y";

    [[[[self class] sharedInstance] networkManager] GET:[@"beer" stringByAppendingFormat:@"/%@", beerId]
                                             parameters:mutableParameters
                                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                                    if ([responseObject isKindOfClass:[NSDictionary class]])
                                                    {
                                                        NSDictionary *response = responseObject;
                                                        if ([response[BreweryDBResponseStatusKey] isEqualToString:@"success"])
                                                        {
                                                            BDBBeer *beer = [[BDBBeer alloc] initWithDictionary:response[BreweryDBResponseDataKey]];
                                                            if (beer)
                                                                success(beer);
                                                            else
                                                                failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_BEER_OBJECT_CREATION_FAILED
                                                                                                         description:BDB_ERROR_BEER_OBJECT_CREATION_FAILED]);
                                                        }
                                                        else
                                                            failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_API_ERROR
                                                                                                     description:response[BreweryDBResponseErrorKey]]);
                                                    }
                                                    else
                                                        failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_BAD_API_RESPONSE
                                                                                                 description:BDB_ERROR_BAD_API_RESPONSE]);
                                                }
                                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                    failure(error);
                                                }];
}

#pragma mark Search
+ (void)search:(NSString *)queryString
          type:(BreweryDBSearchType)type
withBreweryInfo:(BOOL)withBreweryInfo
    parameters:(NSDictionary *)parameters
       success:(void (^)(NSArray *))success
       failure:(void (^)(NSError *))failure
{
    NSParameterAssert(queryString);
    NSParameterAssert(success);
    NSParameterAssert(failure);

    if (![[[self class] sharedInstance] readyToBrew])
        return failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_MISSING_API_KEY description:BDB_ERROR_MISSING_API_KEY]);

    NSMutableDictionary *mutableParameters = parameters.mutableCopy;
    if (!mutableParameters)
        mutableParameters = [NSMutableDictionary dictionary];
    mutableParameters[@"key"] = [[[self class] sharedInstance] apiKey];
    mutableParameters[@"q"] = queryString;

    if (withBreweryInfo)
        mutableParameters[@"withBreweries"] = @"Y";

    switch (type)
    {
        case BreweryDBSearchTypeBrewery:
        {
            mutableParameters[@"type"] = @"brewery";
            break;
        }
        case BreweryDBSearchTypeBeer:
        {
            mutableParameters[@"type"] = @"beer";
            break;
        }
        case BreweryDBSearchTypeGuild:
        {
            mutableParameters[@"type"] = @"guild";
            break;
        }
        case BreweryDBSearchTypeEvent:
        {
            mutableParameters[@"type"] = @"event";
            break;
        }
        case BreweryDBSearchTypeAll:
        default:
            break;
    }

    [[[[self class] sharedInstance] networkManager] GET:@"search"
                                             parameters:mutableParameters
                                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                                    if ([responseObject isKindOfClass:[NSDictionary class]])
                                                    {
                                                        NSDictionary *response = responseObject;
                                                        if ([response[BreweryDBResponseStatusKey] isEqualToString:@"success"])
                                                        {
                                                            NSMutableArray *searchResults = [NSMutableArray array];
                                                            for (NSDictionary *resultDictionary in response[BreweryDBResponseDataKey])
                                                            {
                                                                if ([resultDictionary[@"type"] isEqualToString:@"beer"])
                                                                {
                                                                    BDBBeer *beer = [[BDBBeer alloc] initWithDictionary:resultDictionary];
                                                                    if (beer)
                                                                        [searchResults addObject:beer];
                                                                    else
                                                                    {
                                                                        failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_BEER_OBJECT_CREATION_FAILED
                                                                                                                 description:BDB_ERROR_BEER_OBJECT_CREATION_FAILED]);
                                                                        break;
                                                                    }
                                                                }
                                                                else if ([resultDictionary[@"type"] isEqualToString:@"brewery"])
                                                                {
                                                                    BDBBrewery *brewery = [[BDBBrewery alloc] initWithDictionary:resultDictionary];
                                                                    if (brewery)
                                                                        [searchResults addObject:brewery];
                                                                    else
                                                                    {
                                                                        failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_GUILD_OBJECT_CREATION_FAILED
                                                                                                                 description:BDB_ERROR_GUILD_OBJECT_CREATION_FAILED]);
                                                                        break;
                                                                    }
                                                                }
                                                                else if ([resultDictionary[@"type"] isEqualToString:@"guild"])
                                                                {
                                                                    BDBGuild *guild = [[BDBGuild alloc] initWithDictionary:resultDictionary];
                                                                    if (guild)
                                                                        [searchResults addObject:guild];
                                                                    else
                                                                    {
                                                                        failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_GUILD_OBJECT_CREATION_FAILED
                                                                                                                 description:BDB_ERROR_GUILD_OBJECT_CREATION_FAILED]);
                                                                        break;
                                                                    }
                                                                }
                                                                else
                                                                    [searchResults addObject:resultDictionary];
                                                            }
                                                            success(searchResults);
                                                        }
                                                        else
                                                            failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_API_ERROR
                                                                                                     description:response[BreweryDBResponseErrorKey]]);
                                                    }
                                                    else
                                                        failure([[[self class] sharedInstance] errorWithCode:BDB_ERRNO_BAD_API_RESPONSE
                                                                                                 description:BDB_ERROR_BAD_API_RESPONSE]);
                                                }
                                                failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                    failure(error);
                                                }];
}

@end
