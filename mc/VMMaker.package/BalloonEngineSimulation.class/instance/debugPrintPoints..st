debug support
debugPrintPoints: n
	Transcript cr.
	n > 0 ifTrue:[
		Transcript print: (self point1Get at: 0) @ (self point1Get at: 1); space.
	].
	n > 1 ifTrue:[
		Transcript print: (self point2Get at: 0) @ (self point2Get at: 1); space.
	].
	n > 2 ifTrue:[
		Transcript print: (self point3Get at: 0) @ (self point3Get at: 1); space.
	].
	n > 3 ifTrue:[
		Transcript print: (self point4Get at: 0) @ (self point4Get at: 1); space.
	].
	Transcript endEntry.