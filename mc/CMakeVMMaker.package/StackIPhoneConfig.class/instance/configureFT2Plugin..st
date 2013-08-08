plugin extra rules
configureFT2Plugin: maker
	"extra rules for Freetype plugin.
	a custom rule to build freetype library"
	| lib devRoot sdkRoot |

	devRoot := '/Applications/Xcode.app/Contents/Developer/Platforms/{1}.platform/Developer'
		format: { self targetDevice}.
	sdkRoot := '{1}/SDKs/{2}{3}.sdk' 
		format: { devRoot. self targetDevice. self sdkVersion}.

	"add freetype library into loop"
	lib := self addThirdpartyLibrary: 'freetype2'.
	lib configurationFlags: ({
		'--without-zlib'.
		'--without-bzip2'.
 		'--host=arm-apple-darwin'.
		'--enable-static=yes'. 
		'--enable-shared=no'.
		'CC={3}/usr/bin/gcc'.
		'CXX={3}/usr/bin/g++'.
		'CFLAGS=\\"-arch {1} -std=c99 -Wno-trigraphs -O2 -fwrapv -Wreturn-type -Wunused-variable -fmessage-length=0 -miphoneos-version-min=4.0 -I{2}/usr/include/libxml2 -isysroot {2}\\"'.
		'LDFLAGS=\\"-arch {1} -isysroot {2}\\"'}
		collect: [ :each | each format: { self architecture. sdkRoot. devRoot} ]).

	"link plugin with freetype lib"
	maker addExternalLibrary: '${thirdpartyDir}/out/lib/', lib libraryFileName.
	maker includeDirectories: lib includeDir. 