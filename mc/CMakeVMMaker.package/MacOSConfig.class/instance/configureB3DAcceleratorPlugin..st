plugin extra rules
configureB3DAcceleratorPlugin: maker
	"extra rules for B3DAcceleratorPlugin"
	
	super configureB3DAcceleratorPlugin: maker.  
	
	maker 
		includeDirectories: '/usr/X11/include';  "for GL.h"
		addPlatformSources: #( 'sqMacOpenGL.c' 'sqMacOpenGLInfo.c')
