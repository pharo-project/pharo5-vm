plugin extra rules
configureLocalePlugin: maker
	maker addFrameworks: #('CoreFoundation').
	maker addPlatformSources: #( 'sqIOSLocale.c' )	.
