import re, datetime
info = r"""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>BuildMachineOSBuild</key>
	<string>19B88</string>
	<key>CFBundleDevelopmentRegion</key>
	<string>English</string>
	<key>CFBundleExecutable</key>
	<string>love</string>
	<key>CFBundleIconFile</key>
	<string>iconfile</string>
	<key>CFBundleIdentifier</key>
	<string>org.love2d.MrZ.Techmino</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>Techmino</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>%s</string>
	<key>CFBundleSignature</key>
	<string>LoVe</string>
	<key>CFBundleSupportedPlatforms</key>
	<array>
		<string>MacOSX</string>
	</array>
	<key>DTCompiler</key>
	<string>com.apple.compilers.llvm.clang.1_0</string>
	<key>DTPlatformBuild</key>
	<string>11C504</string>
	<key>DTPlatformVersion</key>
	<string>GM</string>
	<key>DTSDKBuild</key>
	<string>19B90</string>
	<key>DTSDKName</key>
	<string>macosx10.15</string>
	<key>DTXcode</key>
	<string>1130</string>
	<key>DTXcodeBuild</key>
	<string>11C504</string>
	<key>LSApplicationCategoryType</key>
	<string>public.app-category.games</string>
	<key>LSMinimumSystemVersion</key>
	<string>10.7</string>
	<key>NSHighResolutionCapable</key>
	<true/>
	<key>NSHumanReadableCopyright</key>
	<string>©2020-%d 26F Studio, GNU LGPLv3.0</string>
	<key>NSPrincipalClass</key>
	<string>NSApplication</string>
	<key>NSSupportsAutomaticGraphicsSwitching</key>
	<false/>
</dict>
</plist>
"""

with open("conf.lua", "r") as file:
    data = file.read()
versionCode = re.search("build=(\\d+)", data).group(1)
# versionName = re.search('short="([^"]+)', data).group(1)
print(versionCode)
with open("Techmino.app/Contents/info.plist", "w") as file:
    file.write(info % (versionCode, datetime.datetime.today().year))
