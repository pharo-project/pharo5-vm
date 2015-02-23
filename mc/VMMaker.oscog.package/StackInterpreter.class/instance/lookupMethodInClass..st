message sending
lookupMethodInClass: class
	| currentClass dictionary found |
	<inline: false>
	self assert: (self addressCouldBeClassObj: class).
	currentClass := class.
	[currentClass ~= objectMemory nilObject] whileTrue:
		[dictionary := objectMemory followObjField: MethodDictionaryIndex ofObject: currentClass.
		dictionary = objectMemory nilObject ifTrue:
			["MethodDict pointer is nil (hopefully due a swapped out stub)
				-- raise exception #cannotInterpret:."
			self createActualMessageTo: class.
			messageSelector := objectMemory splObj: SelectorCannotInterpret.
			self sendBreakpoint: messageSelector receiver: nil.
			^self lookupMethodInClass: (self superclassOf: currentClass)].
		found := self lookupMethodInDictionary: dictionary.
		(NewspeakVM
		 and: [CheckPrivacyViolations
		 and: [isPrivateSend not
		 and: [messageSelector ~= (objectMemory splObj: SelectorDoesNotUnderstand)
		 and: [(self accessModifierOfMethod: newMethod) ~= 0]]]]) ifTrue:
			[self print: (self nameOfClass: currentClass); space.
			 self printStringOf: (messageSelector); print: ' from '.
			 self printStringOf: (self maybeSelectorOfMethod: method); cr].
		found ifTrue: [^currentClass].
		currentClass := self superclassOf: currentClass].

	"Could not find #doesNotUnderstand: -- unrecoverable error."
	messageSelector = (objectMemory splObj: SelectorDoesNotUnderstand) ifTrue:
		[self error: 'Recursive not understood error encountered'].

	"Cound not find a normal message -- raise exception #doesNotUnderstand:"
	self createActualMessageTo: class.
	messageSelector := objectMemory splObj: SelectorDoesNotUnderstand.
	self sendBreak: messageSelector + objectMemory baseHeaderSize
		point: (objectMemory lengthOf: messageSelector)
		receiver: nil.
	^self lookupMethodInClass: class