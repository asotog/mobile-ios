/*
 * Copyright (C) 2007-2013 Crafter Software Corporation.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#import "CrafterTypes.h"
#import "DDXMLElement+CrafterAdditions.h"
#import "NSString+CrafterAdditions.h"

@interface CrafterTypes ()

+ (CrafterTypes *)sharedInstance;

@property (readonly, nonatomic) NSString *boolType;
@property (readonly, nonatomic) NSString *charType;
@property (readonly, nonatomic) NSString *intType;
@property (readonly, nonatomic) NSString *shortType;
@property (readonly, nonatomic) NSString *longType;
@property (readonly, nonatomic) NSString *longLongType;
@property (readonly, nonatomic) NSString *unsignedCharType;
@property (readonly, nonatomic) NSString *unsignedIntType;
@property (readonly, nonatomic) NSString *unsignedShortType;
@property (readonly, nonatomic) NSString *unsignedLongType;
@property (readonly, nonatomic) NSString *unsignedLongLongType;
@property (readonly, nonatomic) NSString *floatType;
@property (readonly, nonatomic) NSString *doubleType;

@end

@implementation CrafterTypes

@synthesize boolType;
@synthesize charType;
@synthesize intType;
@synthesize shortType;
@synthesize longType;
@synthesize longLongType;
@synthesize unsignedCharType;
@synthesize unsignedIntType;
@synthesize unsignedShortType;
@synthesize unsignedLongType;
@synthesize unsignedLongLongType;
@synthesize floatType;
@synthesize doubleType;

+ (CrafterTypes *)sharedInstance
{
    static CrafterTypes *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterTypes new];
    };
    
    return sharedInstance;
}

+ (NSString *)boolType
{
    return [self sharedInstance].boolType;
}

+ (NSString *)charType
{
    return [self sharedInstance].charType;
}

+ (NSString *)intType
{
    return [self sharedInstance].intType;
}

+ (NSString *)shortType
{
    return [self sharedInstance].shortType;
}

+ (NSString *)longType
{
    return [self sharedInstance].longType;
}

+ (NSString *)longLongType
{
    return [self sharedInstance].longLongType;
}

+ (NSString *)unsignedCharType
{
    return [self sharedInstance].unsignedCharType;
}

+ (NSString *)unsignedIntType
{
    return [self sharedInstance].unsignedIntType;
}

+ (NSString *)unsignedShortType
{
    return [self sharedInstance].unsignedShortType;
}

+ (NSString *)unsignedLongType
{
    return [self sharedInstance].unsignedLongType;
}

+ (NSString *)unsignedLongLongType
{
    return [self sharedInstance].unsignedLongLongType;
}

+ (NSString *)floatType
{
    return [self sharedInstance].floatType;
}

+ (NSString *)doubleType
{
    return [self sharedInstance].doubleType;
}

+ (BOOL)isTypeAClass:(NSString *)type
{
    return [type hasPrefix:@"@"] && [type length] > 1;
}

+ (Class)classFromType:(NSString *)type
{
    if ([self isTypeAClass:type]) {
        return NSClassFromString([type substringWithRange:NSMakeRange(2, type.length - 3)]);
    }
    
    return Nil;
}

+ (NSString *)typeFromClass:(Class)clazz
{
    return [NSString stringWithFormat:@"@\"%@\"", NSStringFromClass(clazz)];
}

+ (NSString *)typeFromCanonicalName:(NSString *)name
{
    if ([name isEqualToStringIgnoringCase:@"bool"]) {
        return [self boolType];
    } else if ([name isEqualToStringIgnoringCase:@"char"]) {
        return [self charType];
    } else if ([name isEqualToStringIgnoringCase:@"int"]) {
        return [self charType];
    } else if ([name isEqualToStringIgnoringCase:@"short"]) {
        return [self shortType];
    } else if ([name isEqualToStringIgnoringCase:@"long"]) {
        return [self longType];
    } else if ([name isEqualToStringIgnoringCase:@"long long"]) {
        return [self longLongType];
    } else if ([name isEqualToStringIgnoringCase:@"unsigned char"]) {
        return [self unsignedCharType];
    } else if ([name isEqualToStringIgnoringCase:@"unsigned int"]) {
        return [self unsignedIntType];
    } else if ([name isEqualToStringIgnoringCase:@"unsigned short"]) {
        return [self unsignedShortType];
    } else if ([name isEqualToStringIgnoringCase:@"unsigned long"]) {
        return [self unsignedLongLongType];
    } else if ([name isEqualToStringIgnoringCase:@"unsigned long long"]) {
        return [self unsignedLongLongType];
    } else if ([name isEqualToStringIgnoringCase:@"float"]) {
        return [self floatType];
    } else if ([name isEqualToStringIgnoringCase:@"double"]) {
        return [self doubleType];
    } else {
        return [NSString stringWithFormat:@"@\"%@\"", name];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        boolType = [NSString stringWithUTF8String:@encode(BOOL)];
        charType = [NSString stringWithUTF8String:@encode(char)];
        intType = [NSString stringWithUTF8String:@encode(int)];
        shortType = [NSString stringWithUTF8String:@encode(short)];
        longType = [NSString stringWithUTF8String:@encode(long)];
        longLongType = [NSString stringWithUTF8String:@encode(long long)];
        unsignedCharType = [NSString stringWithUTF8String:@encode(unsigned char)];
        unsignedIntType = [NSString stringWithUTF8String:@encode(unsigned int)];
        unsignedShortType = [NSString stringWithUTF8String:@encode(unsigned short)];
        unsignedLongType = [NSString stringWithUTF8String:@encode(unsigned long)];
        unsignedLongLongType = [NSString stringWithUTF8String:@encode(unsigned long long)];
        floatType = [NSString stringWithUTF8String:@encode(float)];
        doubleType = [NSString stringWithUTF8String:@encode(double)];
    }
    
    return self;
}

@end
