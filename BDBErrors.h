//
//  BDBErrors.h
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

#ifndef __BDBERRORS__
#define __BDBERRORS__


// Error Codes
#define BDB_ERRNO_MISSING_API_KEY                           1000
#define BDB_ERRNO_API_ERROR                                 1001
#define BDB_ERRNO_BAD_API_RESPONSE                          1002
#define BDB_ERRNO_BEER_OBJECT_CREATION_FAILED               1100
#define BDB_ERRNO_BREWERY_OBJECT_CREATION_FAILED            1101
#define BDB_ERRNO_GUILD_OBJECT_CREATION_FAILED              1102


// Error Messages
#define BDB_ERROR_MISSING_API_KEY                           NSLocalizedString(@"API key has not been set.", @"Missing API key")
#define BDB_ERROR_BAD_API_RESPONSE                          NSLocalizedString(@"Cannot parse API response.", @"Bad API response")
#define BDB_ERROR_BEER_OBJECT_CREATION_FAILED               NSLocalizedString(@"Could not create BDBBeer object.", @"BDBBeer creation failed")
#define BDB_ERROR_BREWERY_OBJECT_CREATION_FAILED            NSLocalizedString(@"Could not create BDBBrewery object.", @"BDBBrewery creation failed")
#define BDB_ERROR_GUILD_OBJECT_CREATION_FAILED              NSLocalizedString(@"Could not create BDBGuild object.", @"BDBGuild creation failed")


#endif
