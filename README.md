# SoEntitled
Oh wow, so entitlements

# Purpose

This app intended to serve the use case of regression- and stress-testing tools like `isign` and the
services that surround them in the context of iOS Auto Provisioning. 

Accordingly, this app utilizes entitlements and includes a Today Extension as well as Watch Extension. 

# Building

```shell
./scripts/build-ipa <codesign-id>
```

Note that if you have the Karl Krukow (YTTN6Y2QS9) Cert installed locally, 
you can use the `"Karl Krukow (YTTN6Y2QS9)"` as the `codesign-id`.

Note also that this will just build the ipa for the main application, not the watch app. 

# Notes

### Running

**Testing App Gropus**

To test that the app groups entitlement is working, you'll need to cross-validate between two 
different processes that they can share a container. There are three places to check: the main app,
the Today Extensions, and/or the Watch App. 

When any of the above components launches, it writes a message to the shared app container and 
attempts to read anything that has been written by the other components as well as display 
those results on the screen. Therefore, to verify that the Today Extension is sharing the 
same container as the main App, you'd need to launch both and then check each.

In case you don't know where Today Extensions are, go to your home screen and keep
swiping left until you get to that column with 'news' and similar widgets. 

**Testing Health Kit**

On panel two of the app, you will be prompted for location tracking and, if the HealthKit 
entitlment is enabled, HealthKit info. 

If you accept or deny the HealthKit information request, you'll see a message such as
"access denied/granted". However, if the entitlement isn't working, you'd see a different
message such as "entitlement disabled".

### Misc

There is an included SoEntitled.mobileprovision which should match the original 
entitlements/team_id etc. for the app. 

Note that it is normal to see an error message such as

```
SoEntitled[8276:2594816] [User Defaults] Failed to read values in CFPrefsPlistSource<0x17010b520> (Domain: group.YOUR_GROUPNAME, User: kCFPreferencesAnyUser, ByHost: Yes, Container: (null)): Using kCFPreferencesAnyUser with a container is only allowed for System Containers, detaching from cfprefsd
```

Safe to ignore.
