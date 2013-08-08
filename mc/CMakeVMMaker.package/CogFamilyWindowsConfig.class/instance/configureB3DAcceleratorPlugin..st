plugin extra rules
configureB3DAcceleratorPlugin:  maker 
	"extra rules for B3DAcceleratorPlugin "

	super configureB3DAcceleratorPlugin:  maker.
	
	maker addPlatformSources: #( 'sqWin32DualB3DX.c' 'sqWin32D3D.c' 'sqWin32OpenGL.c')


