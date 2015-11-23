//
//  BDBStyle.m
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

#import "BDBStyle.h"


#pragma mark -
@implementation BDBStyle

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (!self)
        return nil;

    if (!dictionary)
        return self;

    @try
    {
        _styleId            = dictionary[NSStringFromSelector(@selector(styleId))];
        _category           = dictionary[NSStringFromSelector(@selector(category))];

        _srmMax             = dictionary[NSStringFromSelector(@selector(srmMax))];
        _ibuMax             = dictionary[NSStringFromSelector(@selector(ibuMax))];
        _srmMin             = dictionary[NSStringFromSelector(@selector(srmMin))];
        _descriptionString  = [dictionary[@"description"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _fgMin              = dictionary[NSStringFromSelector(@selector(fgMin))];
        _ibuMin             = dictionary[NSStringFromSelector(@selector(ibuMin))];
        _createDate         = dictionary[NSStringFromSelector(@selector(createDate))];
        _fgMax              = dictionary[NSStringFromSelector(@selector(fgMax))];
        _abvMax             = dictionary[NSStringFromSelector(@selector(abvMax))];
        _ogMin              = dictionary[NSStringFromSelector(@selector(ogMin))];
        _abvMin             = dictionary[NSStringFromSelector(@selector(abvMin))];
        _name               = dictionary[NSStringFromSelector(@selector(name))];
        _categoryId         = dictionary[NSStringFromSelector(@selector(categoryId))];

        _status             = dictionary[NSStringFromSelector(@selector(status))];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Could not parse beer: %@", exception);
        return nil;
    }

    return self;
}

@end
