plugin extra rules
configureSocketPlugin: maker
	super configureSocketPlugin: maker.
	maker includeDirectories: '${SDKROOT}/usr/include'.  "for tcp.h"