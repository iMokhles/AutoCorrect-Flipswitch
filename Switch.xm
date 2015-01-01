#import <flipswitch/Flipswitch.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <notify.h>

@interface AutoCorrectSwitch : NSObject <FSSwitchDataSource>
@end

/********** Thanks to rpetrich and A3Tweaks **************/
// https://github.com/a3tweaks/Flipswitch/tree/c6e2b9c135503cb4b8234f1274a924357baeedd2/Switches/AutoBrightness

#ifndef GSEVENT_H
extern void GSSendAppPreferencesChanged(CFStringRef bundleID, CFStringRef key);
#endif

#define kACPreferences CFSTR("com.apple.Preferences")
#define kAutoCorrectKey CFSTR("KeyboardAutocorrection")

@implementation AutoCorrectSwitch

- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
	return @"AutoCorrect";
}

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
	CFPreferencesAppSynchronize(kACPreferences);
    Boolean acKeyBool = CFPreferencesGetAppBooleanValue(kAutoCorrectKey, kACPreferences, NULL);
    return acKeyBool ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
	if (newState == FSSwitchStateIndeterminate) {
		return;
	}
    CFPreferencesSetAppValue(kAutoCorrectKey, newState ? kCFBooleanTrue : kCFBooleanFalse, kACPreferences);
    CFPreferencesAppSynchronize(kACPreferences);
	GSSendAppPreferencesChanged(kACPreferences, kAutoCorrectKey);
    notify_post("AppleKeyboardsSettingsChangedNotification");
	/*************** My Research result ****************/

    /************* Keyboad Notifications ***************/

    // AppleKeyboardsSettingsChangedNotification

    /************* Default **************/

    // com.apple.Preferences

    /************* Key *************/

    // KeyboardAutocorrection

}

@end
