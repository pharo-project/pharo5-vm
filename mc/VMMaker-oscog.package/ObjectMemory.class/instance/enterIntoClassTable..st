forward compatibility
enterIntoClassTable: aBehavior
	"The old ObjectMemory should never be called upon to enter anything into the class table.
	 Alas 0 is a valid identityhash in the Squeak V3 objrep so primitiveBehaviorHash may
	 ask to enter into the table a class with a 0 id hash.  SImply ignore the request."
	^0