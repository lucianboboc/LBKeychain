# LBKeychain

[![Version](https://img.shields.io/cocoapods/v/LBKeychain.svg?style=flat)](http://cocoapods.org/pods/LBKeychain)
[![License](https://img.shields.io/cocoapods/l/LBKeychain.svg?style=flat)](http://cocoapods.org/pods/LBKeychain)
[![Platform](https://img.shields.io/cocoapods/p/LBKeychain.svg?style=flat)](http://cocoapods.org/pods/LBKeychain)

A keychain wrapper to help you save username and password very easy.

### How to use

```objective-c

// to save a username and password:
[LBKeychain saveUsernameValueInKeychain: self.emailTextField.text andPasswordValue: self.passwordTextField.text];

// to autocomplete a username and password:
[LBKeychain autocompleteValuesForUsernameField: self.emailTextField andPasswordField: self.passwordTextField];

```

- to save a value in keychain use <code>saveValueInKeychain:forIdentifier:</code> method.
 - to delete a value in kechain use <code>deleteItemFromKeychainForIdentifier:</code> method.
 - to search a value in keychain use <code>searchValueForIdentifierInKeychain:</code> method.
 

### If you want to save only a username and a password

- to save a username and password use <code>saveUsernameValueInKeychain:andPasswordValue:</code> method. This method uses the <code>kLBKeychainUsername</code> value for the user, but that can be changed in LBkeychain.m
- to delete an already saved username and password use <code>deleteUsernameAndPasswordItemsFromKeychain</code> method.
- to search for an already saved username using the <code>saveUsernameValueInKeychain:andPasswordValue:</code> method you should use <code>searchUsernameValueInKeychain</code> method.
- to autocomplete a username and password text fields use <code>autocompleteValuesForUsernameField:andPasswordField:</code> method.

LICENSE
=======

This content is released under the MIT License https://github.com/lucianboboc/LBKeychain/blob/master/LICENSE.md


Enjoy!