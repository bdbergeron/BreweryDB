//
//  BDBBeer.h
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


#pragma mark -
@interface BDBBeer : NSObject

@property (nonatomic, copy, readonly) NSString *beerId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descriptionString;
@property (nonatomic) NSArray *breweries;
@property (nonatomic, copy) NSString *foodPairings;
@property (nonatomic, copy) NSString *originalGravity;
@property (nonatomic) NSNumber *abv;
@property (nonatomic) NSNumber *ibu;
@property (nonatomic) NSNumber *glasswareId;
@property (nonatomic) NSDictionary *glass;
@property (nonatomic) NSNumber *styleId;
@property (nonatomic) NSDictionary *style;
@property (nonatomic, assign, getter = isOrganic) BOOL organic;
@property (nonatomic) NSDictionary *labels;
@property (nonatomic) NSNumber *servingTemperature;
@property (nonatomic, copy) NSString *servingTemperatureDisplay;
@property (nonatomic) NSNumber *availableId;
@property (nonatomic) NSDictionary *available;
@property (nonatomic) NSString *beerVariationId;
@property (nonatomic) NSNumber *year;

@property (nonatomic, copy, readonly) NSString *status;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
