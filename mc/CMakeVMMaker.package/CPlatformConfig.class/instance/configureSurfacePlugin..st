plugin extra rules
configureSurfacePlugin: maker 
	"extra rules for SurfacePlugin"

	maker set: #sources toString: ''. "remove default source file"
	maker addCrossSources: #('SurfacePlugin.c')


