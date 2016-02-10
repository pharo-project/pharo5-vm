gmake commands
includePlugin: aString
	^ self include: ('$(TOP_PATH)/build/', aString, '/Android.mk').	
