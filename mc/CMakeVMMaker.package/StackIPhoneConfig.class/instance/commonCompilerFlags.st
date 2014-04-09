settings
commonCompilerFlags
	"Common compiler flags"
	^{
	'-arch {1}' format: { self architecture }.
	"CLANG >>"
	'-fwrapv'. "Non optimization of stackoverflow (to allow number conversions)"
	'-Wno-return-type'. "to avoid clang to complain about plugins that do not return properly."	
	'-Qunused-arguments'.
	"CLANG <<"	
	'-isysroot {1}' format: { self sysroot }.
	'-x objective-c'.
	'-std=gnu99'.
	'-falign-functions=16'.
	'-fno-gcse'.
	'-fvisibility=hidden'.
	'-funroll-loops'.
	'-finline-functions'.
	'-mno-thumb'.
	'-DSTACKVM=1'.
	'-DCOGMTVM=0'. 
	'-DUSE_GLOBAL_STRUCT=0'. 
	'-DBASE_HEADER_SIZE=4'.
	'-DTARGET_OS_IS_IPHONE'.
	'-DHAVE_UUID_GENERATE'.
	'-DHAVE_SYS_TIME_H'.
	'-DLSB_FIRST'.
	'-DHAVE_NANOSLEEP'.
	'-DISQUEAK_IMAGE={1}' format: { self imageName }.
	'-DISQUEAK_SOURCES=PharoV10'.
	'-DSTACKVM'}