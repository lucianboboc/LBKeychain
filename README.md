LBKeychain
==========

A keychain wrapper to help you save username and password very easy.

How to use this class
==========

 - to search a value in keychain use searchValueForIdentifierInKeychain: method.
 - to save a value in keychain use saveValueInKeychain:forIdentifier: method.
 - to delete a value in kechain use deleteItemFromKeychainForIdentifier: method.
 
If you want to save only a username and a password
==========

- to save a username and password use saveUsernameValueInKeychain:andPasswordValue: method. This method uses the kLBKeychainUsername value for the user, but that can be changed in LBkeychain.m
- to delete an already saved username and password use deleteUsernameAndPasswordItemsFromKeychain method.
- to search for an already saved username using the :andPasswordValue: method you should use searchUsernameValueInKeychain method.
- to autocomplete a username and password text fields use autocompleteValuesForUsernameField:andPasswordField:

EXAMPLE
==========
// to save a username and password:
[LBKeychain saveUsernameValueInKeychain: self.emailTextField.text andPasswordValue: self.passwordTextField.text];

// to autocomplete a username and password:
 [LBKeychain autocompleteValuesForUsernameField: self.emailTextField andPasswordField: self.passwordTextField];
