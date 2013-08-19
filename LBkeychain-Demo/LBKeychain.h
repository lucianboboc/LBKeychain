//
//  LBKeychain.h
//  myCloud
//
//  Created by Lucian Boboc on 7/5/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBKeychain : NSObject

// Keychain methods to search, save and delete a value/password
+ (NSString *) searchValueForIdentifierInKeychain: (NSString *) identifier;
// if value or identifier is nil or empty string no value will be saved
+ (BOOL) saveValueInKeychain: (NSString *) value forIdentifier: (NSString *) identifier;
+ (BOOL) deleteItemFromKeychainForIdentifier:(NSString *)identifier;


// Keychain methods to search username, save and delete username and passwords
+ (NSString *) searchUsernameValueInKeychain;
// if username or password is nil or empty string no value will be saved
+ (BOOL) saveUsernameValueInKeychain:(NSString *)username andPasswordValue: (NSString *) password;
+ (BOOL) deleteUsernameAndPasswordItemsFromKeychain;

@end
