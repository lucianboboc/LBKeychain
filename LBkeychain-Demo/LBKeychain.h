//
//  LBKeychain.h
//  myCloud
//
//  Created by Lucian Boboc on 7/5/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//



#if ! __has_feature(objc_arc)
#error LBKeychain is ARC only.
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
#error LBCache library needs iOS 7.0 or later.
#endif

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
// pass the username and password filed to autocomplete.
+ (BOOL) autocompleteValuesForUsernameField: (UITextField *) usernameField andPasswordField: (UITextField *) passwordField;

@end
