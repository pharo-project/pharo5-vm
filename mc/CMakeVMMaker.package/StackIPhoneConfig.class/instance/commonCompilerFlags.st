settings
commonCompilerFlags
	"Common compiler flags"
	^{
	"'-miphoneos-version-min=4.3'. "
	'-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/{1}.platform/Developer/SDKs/{1}{2}.sdk' format: { self targetDevice. self sdkVersion}.
	'-x objective-c'.
	'-std=gnu99'.
	'-falign-functions=16'.
	'-fno-gcse'.
	'-fno-cse-follow-jumps'.
	'-fvisibility=hidden'.
	'-funroll-loops'.
	'-finline-functions'.
	'-mno-thumb'.
	'-fwrapv'.
	'-DSTACKVM=1'.
	'-DCOGMTVM=0'. 
	'-DUSE_GLOBAL_STRUCT=0'. 
	'-DBASE_HEADER_SIZE=4'.
	'-DTARGET_OS_IS_IPHONE'.
	'-DHAVE_UUID_GENERATE'.
	"'-DUSE_INLINE_MEMORY_ACCESSORS'. "
	'-DHAVE_SYS_TIME_H'.
	'-DLSB_FIRST'.
	'-DHAVE_NANOSLEEP'.
	'-DISQUEAK_IMAGE=', self imageName.
	'-DISQUEAK_SOURCES=PharoV10'.
	'-DSTACKVM'}