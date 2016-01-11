bootstrap image
silenceImage
	"Turn off change notifications via SystemChangeNotifier"
	(self allInstancesOf: (self findClassNamed: (self findSymbol: #SystemChangeNotifier))) do:
		[:obj | oldHeap storePointer: 1 ofObject: obj withValue: (oldHeap integerObjectOf: 1)]