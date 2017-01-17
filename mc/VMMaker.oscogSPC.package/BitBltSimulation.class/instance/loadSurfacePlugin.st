surface support
loadSurfacePlugin
	"Load the surface support plugin"
	querySurfaceFn := interpreterProxy ioLoadFunction:'ioGetSurfaceFormat' From:'SurfacePlugin'.
	lockSurfaceFn := interpreterProxy ioLoadFunction:'ioLockSurface' From:'SurfacePlugin'.
	unlockSurfaceFn := interpreterProxy ioLoadFunction:'ioUnlockSurface' From:'SurfacePlugin'.
	^querySurfaceFn ~= 0 and:[lockSurfaceFn ~= 0 and:[unlockSurfaceFn ~= 0]]