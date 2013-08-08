plugin extra rules
configureLocalePlugin: maker
	"extra rules for LocalePlugin"

	super configureLocalePlugin: maker.  
	
	maker addPlatformSources: #( 'sqAndroidLocale.c')