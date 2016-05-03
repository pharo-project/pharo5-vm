plugin extra rules
configureB3DAcceleratorPlugin: maker
	"extra rules for B3DAcceleratorPlugin"
	
	super configureB3DAcceleratorPlugin: maker. 
	maker addFrameworks: self frameworks.
	maker addPlatformSources: #( 'sqMacOpenGL.c' 'sqMacOpenGLInfo.c')