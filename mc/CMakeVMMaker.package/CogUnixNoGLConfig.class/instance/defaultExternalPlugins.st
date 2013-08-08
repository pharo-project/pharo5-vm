as yet unclassified
defaultExternalPlugins
	"Removed the B3DAcceleratorPlugin since we don't have OpenGL bindings here"
	^ (super defaultExternalPlugins copyWithout: #B3DAcceleratorPlugin)
