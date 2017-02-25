gc -- mark and sweep
markAndTrace: oop
	"Mark all objects reachable from the given one.
	Trace from the given object even if it is old.
	Do not trace if it is already marked.
	Mark it only if it is a young object."
	"Tracer state variables:
		child		object being examined
		field		next field of child to examine
		parentField	field where child was stored in its referencing object"
	<api>
	| header lastFieldOffset action |
	self assert: (self addressCouldBeObjWhileForwarding: oop).
	header := self longAt: oop.
	(header bitAnd: MarkBit) = 0 ifFalse:
		[^ 0  "already marked"].

	"record tracing status in object's header"
	header := (header bitAnd: AllButTypeMask) bitOr: HeaderTypeGC.
	(self oop: oop isGreaterThanOrEqualTo: youngStart) ifTrue:
		[ header := header bitOr: MarkBit ].  "mark only if young"
	self longAt: oop put: header.

	"initialize the tracer state machine"
	parentField := GCTopMarker.
	child := oop.
	lastFieldOffset := self lastPointerOf: oop recordWeakRoot: true.
	field := oop + lastFieldOffset.
	action := StartField.
	youngStartLocal := youngStart.
	statMarkCountLocal := statMarkCount.
	"run the tracer state machine until all objects reachable from oop are marked"
	[action = StartField ifTrue: [ action := self startField ].
	 action = StartObj ifTrue: [ action := self startObj ].
	 action = Upward ifTrue: [ action := self upward ].
	 action = Done] whileFalse.
	statMarkCount := statMarkCountLocal.