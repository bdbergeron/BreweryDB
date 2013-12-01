//
//  BreweryDB.h
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

#import <Foundation/Foundation.h>

#import "BDBBeer.h"
#import "BDBBrewery.h"
#import "BDBGuild.h"


typedef NS_ENUM(NSInteger, BreweryDBSearchType)
{
    BreweryDBSearchTypeAll,
    BreweryDBSearchTypeBrewery,
    BreweryDBSearchTypeBeer,
    BreweryDBSearchTypeGuild,
    BreweryDBSearchTypeEvent
};


#pragma mark -
@interface BreweryDB : NSObject

#pragma mark Instantiation
/**
 *  Create and start the BreweryDB client.
 *
 *  @param apiKey Your application's unique API key.
 *
 *  @return BreweryDB singelton
 *
 *  @since 1.0.0
 */
+ (instancetype)brew:(NSString *)apiKey;

#pragma mark Beers
/**
 *  Fetch an array of beers pertaining to the specified parameters.
 *
 *  @param parameters Filtering paramaters.
 *  @param success    Callback function performed on successful retrieval of results.
 *  @param failure    Callback function performed when an error occurs.
 *
 *  @since 1.0.0
 */
+ (void)fetchBeersWithParameters:(NSDictionary *)parameters
                 withBreweryInfo:(BOOL)withBreweryInfo
                         success:(void (^)(NSArray *beers))success
                         failure:(void (^)(NSError *error))failure;

/**
 *  Fetch a single beer object specified by the beerId.
 *
 *  @param beerID     Unique ID describing the beer.
 *  @param parameters Filtering parameters.
 *  @param success    Callback function performed on successful retrieval of results.
 *  @param failure    Callback function performed when an error occurs.
 *
 *  @since 1.0.0
 */
+ (void)fetchBeerWithId:(NSString *)beerId
        withBreweryInfo:(BOOL)withBreweryInfo
             parameters:(NSDictionary *)parameters
                success:(void (^)(BDBBeer *beer))success
                failure:(void (^)(NSError *error))failure;

#pragma mark Breweries
/**
 *  Fetch an array of breweries pertaining to the specified parameters.
 *
 *  @param parameters Filtering parameters.
 *  @param success    Callback function performed on successful retrieval of results.
 *  @param failure    Callback function performed when an error occurs.
 *
 *  @since 1.0.0
 */
+ (void)fetchBreweriesWithParameters:(NSDictionary *)parameters
                             success:(void (^)(NSArray *breweries))success
                             failure:(void (^)(NSError *error))failure;

/**
 *  Fetch a single brewery object specified by the breweryId.
 *
 *  @param breweryId  Unique ID describing the brewery.
 *  @param parameters Filtering parameters.
 *  @param success    Callback function performed on successful retrieval of results.
 *  @param failure    Callback function performed when an error occurs.
 *
 *  @since 1.0.0
 */
+ (void)fetchBreweryWithId:(NSString *)breweryId
                parameters:(NSDictionary *)parameters
                   success:(void (^)(BDBBrewery *brewery))success
                   failure:(void (^)(NSError *error))failure;

#pragma mark Search
/**
 *  Perform a search query on the BreweryDB.
 *
 *  @param queryString   What you're searching for.
 *  @param type          The type of result you're searching for.
 *  @param withBreweries Whether or not to return brewery information with the results.
 *  @param success       Callback function performed on successful retrieval of results.
 *  @param failure       Callback function performed when an error occurs.
 *
 *  @since 1.0.0
 */
+ (void)search:(NSString *)queryString
          type:(BreweryDBSearchType)type
withBreweryInfo:(BOOL)withBreweryInfo
    parameters:(NSDictionary *)parameters
       success:(void (^)(NSArray *results))success
       failure:(void (^)(NSError *error))failure;

@end
