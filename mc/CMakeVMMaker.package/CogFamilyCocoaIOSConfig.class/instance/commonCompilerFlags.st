settings
commonCompilerFlags
	^super commonCompilerFlags,  #(
	"CLANG >>"
	'-fwrapv' "Non optimization of stackoverflow (to allow number conversions)"
	'-Wno-return-type' "to avoid clang to complain about plugins that do not return properly."	
	'-Qunused-arguments'
	"CLANG <<"
	"Remove some undesired warnings >>"
	'-Wno-unused-variable'
	'-Wno-unused-parameter'
	'-Wno-unused-value'
	'-Wno-unused-function'
	"Remove some undesired warnings <<"	
	'-funroll-loops' 
	'-fasm-blocks' 
	'-fno-inline-functions' 
	'-mfpmath=sse' 
	'-march=pentium-m' 
	'-mtune=prescott' 
	"CLANG does not recognise this two"
	"'-falign-functions=16' 
	'-fno-gcse' "
	'-std=gnu99'
	'-fmessage-length=0' 
	'-fpascal-strings' 
	'-DBUILD_FOR_OSX' 
	"'-DUSE_INLINE_MEMORY_ACCESSORS=1' "
	'-DLSB_FIRST' 
	'-DHAVE_SYS_TIME_H' 
	'-DHAVE_NANOSLEEP' 
	'-DCOGMTVM=0' 
	'-DUSE_GLOBAL_STRUCT=0' 
	'-DBASE_HEADER_SIZE=4'
	'-DENABLE_FAST_BLT'
	'-D_GNU_SOURCE'
	'-D_FILE_OFFSET_BITS=64')