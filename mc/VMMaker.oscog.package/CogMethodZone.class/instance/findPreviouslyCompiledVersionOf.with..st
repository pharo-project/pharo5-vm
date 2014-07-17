accessing
findPreviouslyCompiledVersionOf: aMethodObj with: aSelectorOop
	"Newspeak uses a set of methods to implement accessors, a setter and a getter for
	 each inst var offset (e.g. 0 to 255).  These accessors are installed under the relevant
	 selectors in different method dictionaries as required.  These methods effectively
	 have multiple selectors.  The current inline cache design stores the selector of a
	 linked send in the header of the target method.  So this requires a one-to-many
	 mapping of bytecoded method to cog method, with the bytecoded method referring
	 directly to only one cog method, which will have a specific selector, not necessarily
	 the right one.  It is therefore worth-while searching for a cog method on this bytecoded
	 method that has the right selector.  To speed up the search we maintain all such unpaired
	 methods on the unpairedMethodList, which is linked through nextMethodOrIRCs."
	<returnTypeC: #'CogMethod *'>
	<option: #NewspeakVM>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	((coInterpreter methodHasCogMethod: aMethodObj)
	 and: [(coInterpreter methodClassAssociationOf: aMethodObj) = objectMemory nilObject]) ifTrue:
		[cogMethod := self cCoerceSimple: unpairedMethodList to: #'CogMethod *'.
		[cogMethod notNil] whileTrue:
			[self assert: cogMethod cmType = CMMethod.
			 (cogMethod selector = aSelectorOop
			  and: [cogMethod methodObject = aMethodObj]) ifTrue:
				[^cogMethod].
			 cogMethod := self cCoerceSimple: cogMethod nextMethodOrIRCs to: #'CogMethod *']].
	^nil