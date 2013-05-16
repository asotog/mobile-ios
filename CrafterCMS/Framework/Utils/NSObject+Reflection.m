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
#import "NSObject+Reflection.h"

@implementation NSObject (Reflection)

+ (BOOL)hasPropertyNamed:(NSString *)name
{
	return class_getProperty(self, [name UTF8String]) != NULL;
}

+ (NSString *)typeOfPropertyNamed:(NSString *)name
{
	objc_property_t property = class_getProperty(self, [name UTF8String]);
    if (!property) {
        return NULL;
    }
    
    const char *propertyAttrs = property_getAttributes(property);
	if (!propertyAttrs) {
        return NULL;
    }
    
	const char *typeSeparator = strchr(propertyAttrs, ',');
	if (!typeSeparator) {
        return NULL;
    }
    
	int len = (int)(typeSeparator - propertyAttrs);
    char buffer[len + 1];
    
	memcpy(buffer, propertyAttrs, len);
	buffer[len] = '\0';
    
	return [[NSString stringWithUTF8String:buffer] substringFromIndex:1];
}

- (BOOL)hasPropertyNamed:(NSString *)name
{
	return [[self class] hasPropertyNamed:name];
}

- (NSString *)typeOfPropertyNamed:(NSString *)name
{
	return [[self class] typeOfPropertyNamed:name];    
}

@end
