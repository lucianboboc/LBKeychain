//
//  LBKeychain.m
//  myCloud
//
//  Created by Lucian Boboc on 7/5/13.
//  Copyright (c) 2013 Lucian Boboc. All rights reserved.
//


#import "LBKeychain.h"
#import <Security/Security.h>

#define kLBKeychainUsername @"kLBKeychainUsername"

@implementation LBKeychain

#pragma mark - querry dictionary method

+ (NSMutableDictionary *) querryDictionaryWithIdentifier: (NSString *) identifier
{
    NSMutableDictionary *querry = [@{} mutableCopy];
    
    // This keychain item is an a generic password.
    [querry setObject: (__bridge id)kSecClassGenericPassword forKey: (__bridge id)kSecClass];
    
    // Set the Service to the App Bundle Identifier
    [querry setObject: [[NSBundle mainBundle] bundleIdentifier] forKey: (__bridge id)kSecAttrService];
    
    // The kSecAttrGeneric attribute is used to store a unique string that is used to easily identify and find this keychain item.
    NSData *identifierData = [identifier dataUsingEncoding: NSUTF8StringEncoding];
    [querry setObject: identifierData forKey: (__bridge id)kSecAttrGeneric];

    // The kSecAttrAccount value contains the account name
    [querry setObject: identifier forKey: (__bridge id)kSecAttrAccount];                                    
        
    return querry;
}




#pragma mark - search keychain method

+ (NSString *) searchValueForIdentifierInKeychain: (NSString *) identifier
{
    if(!identifier || [identifier isEqualToString: @""])
        return nil;
    
    NSMutableDictionary *querry = [self querryDictionaryWithIdentifier: identifier];
        
    // Return the attributes of the first match only.
    [querry setObject: (__bridge id)kSecMatchLimitOne forKey: (__bridge id)kSecMatchLimit];
    
    // The result returned by the SecItemCopyMatching or SecItemAdd functions should be a CFDataRef value.
    [querry setObject: (__bridge id)kCFBooleanTrue forKey: (__bridge id)kSecReturnData];    
    
    
    // resultData CFTypeRef will hold the resulting CFDataRef from keychain
    CFTypeRef resultData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)querry, &resultData);
    if(status == errSecSuccess)
    {
        NSData *valueData = (__bridge NSData *)resultData;
        return [[NSString alloc] initWithData: valueData encoding: NSUTF8StringEncoding];
    }
    else
        return nil;
}




#pragma mark - save value method

+ (BOOL) saveValueInKeychain: (NSString *) value forIdentifier: (NSString *) identifier
{
    if(!value || !identifier || [value isEqualToString: @""] || [identifier isEqualToString: @""])
        return NO;
    
    NSMutableDictionary *querry = [self querryDictionaryWithIdentifier: identifier];

    
    // The value will be accesible only when device is unlocked.
    [querry setObject: (__bridge id)kSecAttrAccessibleWhenUnlocked forKey: (__bridge id)kSecAttrAccessible];
    
    // Add the valueData value in the querry dictionary
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [querry setObject: valueData forKey: (__bridge id)kSecValueData];
    
    // Call the SecItemAdd function
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)querry, NULL);
    if(status == errSecSuccess)
    {
        return YES;
    }
    else if(status == errSecDuplicateItem)
    {
        BOOL result = [self updateValueInKeychain: value forIdentifier: identifier];
        return result;
    }
    else
        return NO;
}

#pragma mark - update value method


+ (BOOL) updateValueInKeychain: (NSString *) value forIdentifier: (NSString *) identifier
{
    NSMutableDictionary *querry = [self querryDictionaryWithIdentifier: identifier];
    
    
    NSData *valueData = [value dataUsingEncoding: NSUTF8StringEncoding];
    
    // Create an updateDictionary and add the valueData to it
    NSMutableDictionary *updateDictionary = [@{} mutableCopy];
    [updateDictionary setObject: valueData forKey: (__bridge id)kSecValueData];
    
    // Call the SecItemUpdate and pass the query and updateDictionary to update the value in keychain
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef) querry, (__bridge CFDictionaryRef)updateDictionary);
    if(status == errSecSuccess)
    {
        return YES;
    }
    else
        return NO;
}




#pragma mark - delete value method

+ (BOOL) deleteItemFromKeychainForIdentifier:(NSString *)identifier
{
    if(!identifier  || [identifier isEqualToString: @""])
        return NO;
    
    NSMutableDictionary *querry = [self querryDictionaryWithIdentifier: identifier];
    
    if(querry)
    {
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)querry);
        if(status == errSecSuccess)
            return YES;
        else
            return NO;
    }
    else
        return NO;
}















#pragma mark - search username

+ (NSString *) searchUsernameValueInKeychain
{
    return [self searchValueForIdentifierInKeychain: kLBKeychainUsername];
}



#pragma mark - save username and password


+ (BOOL) saveUsernameValueInKeychain:(NSString *)username andPasswordValue: (NSString *) password
{
    if(!username || !password || [username isEqualToString: @""] || [password isEqualToString: @""])
        return NO;
    
    BOOL usernameSaved = [self saveValueInKeychain: username forIdentifier: kLBKeychainUsername];
    if(!usernameSaved)
        return NO;  // username was not saved, return NO
    else
    {
        BOOL passwordSaved = [self saveValueInKeychain: password forIdentifier: username];
        if(!passwordSaved)
            return NO;  // password was not saved, return NO
    }
    return YES;    
}



#pragma mark - delete username and password

+ (BOOL) deleteUsernameAndPasswordItemsFromKeychain
{
    NSString *usernameValue = [self searchValueForIdentifierInKeychain: kLBKeychainUsername];
    if(usernameValue)
    {
        BOOL usernameDeleted = [self deleteItemFromKeychainForIdentifier: kLBKeychainUsername];
        if(!usernameDeleted)
            return NO;  // username was not deleted, return NO
        else
        {
            BOOL passwordDeleted = [self deleteItemFromKeychainForIdentifier: usernameValue];
            if(!passwordDeleted)
                return NO;  // password was not deleted, return NO
        }
        return YES;
    }
    else
        return YES;  // no user found in keychain, return YES
}





@end
