source files
platformSources
	"files added from platform/unix/vm dir "
	^super platformSources 
		copyWith: 'sqAndroidNativeHook.c'.
	 