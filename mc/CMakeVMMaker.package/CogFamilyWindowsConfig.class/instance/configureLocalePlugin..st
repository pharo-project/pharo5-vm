plugin extra rules
configureLocalePlugin:   maker 
	"extra rules for LocalePlugin "

	super configureLocalePlugin:  maker.
	
	maker addPlatformSources: #( 'sqWin32Locale.c')


