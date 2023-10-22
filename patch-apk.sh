#!/bin/bash
# Sets the window's title
printf "\033]2;NetherSX2 Builder\007"
# alias to display text in light red
display_light_red() {
	printf "\e[1;31m%s\e[0m" "$1"
}
# alias to display [Done] in green
display_done() {
	printf "\e[1;32m[Done]\e[0m\n"
}
#alias to display text in blue
display_blue() {
	printf "\e[1;34m%s\e[0m" "$1"
}
# alias to display text in cyan
display_cyan() {
	printf "\e[1;36m%s\e[0m" "$1"
}
# AetherSX2 4248 apk's md5 hash
md5hash="c98b0e4152d3b02fbfb9f62581abada5"
# Setting Base Variables
p2f="$(dirname "$(readlink -f "$0")")"
# start of script
clear
printf "\e[1;91m========================\n"
printf " NetherSX2 Patcher v1.7\n"
printf "========================\e[0m\n"

# Makes sure Java is installed and in the PATH
if ! command -v java >/dev/null 2>&1; then
	printf "\e[0;31mError: The OpenJDK is not installed!\n"
	printf "Please download and install the OpenJDK from your distro's repo.\e[0m\n"
	read -p "Press Enter to exit..."
	exit 1
fi

if [ -f "15210-v1.5-4248-noads[patched].apk" ]; then
	mv "15210-v1.5-4248-noads[patched].apk" 15210-v1.5-4248-noads.apk
fi

update() {
	# Let's leave a backup copy of the NetherSX2 APK
	cp 15210-v1.5-4248-noads.apk 15210-v1.5-4248-noads[patched].apk
	if command -v aapt >/dev/null 2>&1; then
		# Ad Services Cleanup
		display_cyan "Removing the "
		display_light_red "Ad Services leftovers...         "
		aapt r 15210-v1.5-4248-noads[patched].apk user-messaging-platform.properties						> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-tasks.properties							> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-measurement-sdk-api.properties				> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-measurement-base.properties					> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-basement.properties							> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-base.properties								> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-appset.properties							> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads.properties								> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads-lite.properties							> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads-identifier.properties					> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads-base.properties							> /dev/null 2>&1
		display_done

		# Adds Additional Options to App Settings
		display_cyan "Adding more options to "
		display_light_red "App Settings...        "
		aapt r 15210-v1.5-4248-noads[patched].apk res/xml/advanced_preferences.xml
		aapt a 15210-v1.5-4248-noads[patched].apk res/xml/advanced_preferences.xml							> /dev/null 2>&1
		aapt r 15210-v1.5-4248-noads[patched].apk res/xml/graphics_preferences.xml
		aapt a 15210-v1.5-4248-noads[patched].apk res/xml/graphics_preferences.xml							> /dev/null 2>&1
		display_done

		# Updates the FAQ to show that we're using the latest version of NetherSX2
		display_cyan "Updating the "
		display_light_red "FAQ...                           "
		aapt r 15210-v1.5-4248-noads[patched].apk assets/faq.html
		aapt a 15210-v1.5-4248-noads[patched].apk assets/faq.html											> /dev/null 2>&1
		display_done

		# Updates to Latest GameDB with features removed that are not supported by the libemucore.so from March 13th
		display_cyan "Updating the "
		display_light_red "GameDB...                        "
		aapt r 15210-v1.5-4248-noads[patched].apk assets/GameIndex.yaml
		aapt a 15210-v1.5-4248-noads[patched].apk assets/GameIndex.yaml										> /dev/null 2>&1
		display_done

		# Updates the Game Controller Database
		display_cyan "Updating the "
		display_light_red "Controller Database...           "
		aapt r 15210-v1.5-4248-noads[patched].apk assets/game_controller_db.txt
		aapt a 15210-v1.5-4248-noads[patched].apk assets/game_controller_db.txt								> /dev/null 2>&1
		display_done

		# Updates the Widescreen Patches
		display_cyan "Updating the "
		display_light_red "Widescreen Patches...            "
		aapt r 15210-v1.5-4248-noads[patched].apk assets/cheats_ws.zip
		aapt a 15210-v1.5-4248-noads[patched].apk assets/cheats_ws.zip										> /dev/null 2>&1
		display_done

		# Updates the No-Interlacing Patches
		display_cyan "Updating the "
		display_light_red "No-Interlacing Patches...        "
		aapt r 15210-v1.5-4248-noads[patched].apk assets/cheats_ni.zip
		aapt a 15210-v1.5-4248-noads[patched].apk assets/cheats_ni.zip										> /dev/null 2>&1
		display_done

		# Fixes License Compliancy Issue
		display_cyan "Fixing the "
		display_light_red "License Compliancy Issue...        "
		aapt r 15210-v1.5-4248-noads[patched].apk assets/3rdparty.html
		aapt a 15210-v1.5-4248-noads[patched].apk assets/3rdparty.html										> /dev/null 2>&1
		display_done

		# Adds the placeholder file that makes RetroAchievements Notifications work
		display_cyan "Fixing the "
		display_light_red "RetroAchievements Notifications... "
		aapt r 15210-v1.5-4248-noads[patched].apk assets/placeholder.png									> /dev/null 2>&1
		aapt a 15210-v1.5-4248-noads[patched].apk assets/placeholder.png									> /dev/null 2>&1
		display_done
	else
		chmod +x "$p2f"/lib/aapt
		display_cyan "Removing the "
		display_light_red "Ad Services leftovers...         "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk user-messaging-platform.properties				> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-tasks.properties					> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-measurement-sdk-api.properties	> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-measurement-base.properties		> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-basement.properties				> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-base.properties					> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-appset.properties				> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads.properties					> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads-lite.properties				> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads-identifier.properties		> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk play-services-ads-base.properties				> /dev/null 2>&1
		display_done

		display_cyan "Adding more options to "
		display_light_red "App Settings...        "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk res/xml/advanced_preferences.xml
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk res/xml/advanced_preferences.xml				> /dev/null 2>&1
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk res/xml/graphics_preferences.xml
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk res/xml/graphics_preferences.xml				> /dev/null 2>&1
 		display_done

		display_cyan "Updating the "
		display_light_red "FAQ...                           "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk assets/faq.html
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk assets/faq.html								> /dev/null 2>&1
		display_done

		display_cyan "Updating the "
		display_light_red "GameDB...                        "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk assets/GameIndex.yaml
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk assets/GameIndex.yaml							> /dev/null 2>&1
		display_done

		display_cyan "Updating the "
		display_light_red "Controller Database...           "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk assets/game_controller_db.txt
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk assets/game_controller_db.txt					> /dev/null 2>&1
		display_done

		display_cyan "Updating the "
		display_light_red "Widescreen Patches...            "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk assets/cheats_ws.zip
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk assets/cheats_ws.zip							> /dev/null 2>&1
		display_done

		display_cyan "Updating the "
		display_light_red "No-Interlacing Patches...        "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk assets/cheats_ni.zip
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk assets/cheats_ni.zip							> /dev/null 2>&1
		display_done

		display_cyan "Fixing the "
		display_light_red "License Compliancy Issue...        "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk assets/3rdparty.html
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk assets/3rdparty.html							> /dev/null 2>&1
		display_done

		display_cyan "Fixing the "
		display_light_red "RetroAchievements Notifications... "
		"$p2f"/lib/aapt r 15210-v1.5-4248-noads[patched].apk assets/placeholder.png							> /dev/null 2>&1
		"$p2f"/lib/aapt a 15210-v1.5-4248-noads[patched].apk assets/placeholder.png							> /dev/null 2>&1
		display_done
	fi
}

patch() {
	# Check if the AetherSX2 APK is the right version
	if [ "$(md5sum "15210-v1.5-4248.apk" | awk '{print $1}')" = "$md5hash" ]; then
		# Patching the AetherSX2 into a copy of NetherSX2
		display_cyan "Patching to "
		display_light_red "NetherSX2...                      "
		xdelta3 -d -f -s 15210-v1.5-4248.apk "$p2f"/lib/patch.xdelta 15210-v1.5-4248-noads.apk
		display_done
		update
	else
		printf "\e[0;31mError: Wrong APK provided!\n"
		printf "Please provide a copy of AtherSX2 4248 or NetherSX2!\e[0m\n"
		read -p "Press Enter to exit..."
		exit 1
	fi
}

if [ ! -f "15210-v1.5-4248-noads.apk" ]; then
	display_cyan "Downloading "
	display_blue "AetherSX2...                      "
	curl -LOs "https://www.aethersx2.com/archive/android/alpha/15210-v1.5-4248.apk"
	display_done
	patch
else
	update
fi

# Resigns the APK before exiting
if command -v "apksigner" >/dev/null 2>&1; then
	display_cyan "Resigning the "
	display_light_red "NetherSX2 APK...                "
	apksigner sign --ks "$p2f"/lib/android.jks --ks-pass pass:android 15210-v1.5-4248-noads[patched].apk
	display_done
else
	display_cyan "Resigning the "
	display_light_red "NetherSX2 APK...                "
	java -jar "$p2f"/lib/apksigner.jar sign --ks "$p2f"/lib/android.jks --ks-pass pass:android 15210-v1.5-4248-noads[patched].apk
	display_done
fi
# Alternate Key:
# if command -v "apksigner" >/dev/null 2>&1; then
# 	display_cyan "Resigning the "
# 	display_light_red "NetherSX2 APK...                "
# 	apksigner sign --ks "$p2f"/lib/public.jks --ks-pass pass:public 15210-v1.5-4248-noads[patched].apk
# 	display_done
# else
# 	display_cyan "Resigning the "
# 	display_light_red "NetherSX2 APK...                "
# 	java -jar "$p2f"/lib/apksigner.jar sign --ks "$p2f"/lib/public.jks --ks-pass pass:public 15210-v1.5-4248-noads[patched].apk
# 	display_done
# fi
rm 15210-v1.5-4248-noads[patched].apk.idsig
