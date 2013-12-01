//
//  BDBBeer.m
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

#import "BDBBeer.h"
#import "BDBBrewery.h"


#pragma mark -
@implementation BDBBeer

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (!self)
        return nil;

    if (!dictionary)
        return self;

    @try
    {
        _beerId = dictionary[NSStringFromSelector(@selector(beerId))];
        _name = dictionary[NSStringFromSelector(@selector(name))];
        _descriptionString = [dictionary[@"description"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        NSMutableArray *mutableBreweries = [NSMutableArray array];
        for (NSDictionary *breweryDictionary in dictionary[NSStringFromSelector(@selector(breweries))])
        {
            BDBBrewery *brewery = [[BDBBrewery alloc] initWithDictionary:breweryDictionary];
            if (brewery)
                [mutableBreweries addObject:brewery];
            else
                NSLog(@"Could not parse brewery: %@", brewery);
        }
        _breweries = mutableBreweries;

        _foodPairings = dictionary[NSStringFromSelector(@selector(foodPairings))];
        _originalGravity = dictionary[NSStringFromSelector(@selector(originalGravity))];
        _abv = dictionary[NSStringFromSelector(@selector(abv))];
        _ibu = dictionary[NSStringFromSelector(@selector(ibu))];
        _glasswareId = dictionary[NSStringFromSelector(@selector(glasswareId))];
        _glass = dictionary[NSStringFromSelector(@selector(glass))];
        _styleId = dictionary[NSStringFromSelector(@selector(styleId))];
        _style = dictionary[NSStringFromSelector(@selector(style))];
        _organic = [dictionary[NSStringFromSelector(@selector(isOrganic))] boolValue];
        _labels = dictionary[NSStringFromSelector(@selector(labels))];
        _servingTemperature = dictionary[NSStringFromSelector(@selector(servingTemperature))];
        _servingTemperatureDisplay = dictionary[NSStringFromSelector(@selector(servingTemperatureDisplay))];
        _availableId = dictionary[NSStringFromSelector(@selector(availableId))];
        _available = dictionary[NSStringFromSelector(@selector(available))];
        _beerVariationId = dictionary[NSStringFromSelector(@selector(beerVariationId))];
        _year = dictionary[NSStringFromSelector(@selector(year))];

        _status = dictionary[NSStringFromSelector(@selector(status))];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Could not parse beer: %@", exception);
        return nil;
    }

    return self;
}

@end
