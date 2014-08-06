method prototype categorization
categoryForClass: className meta: isMeta selector: selector 
	^(isMeta
			ifTrue: [{ className. #class. selector }]
			ifFalse: [{ className. selector }])
		caseOf: {
			[#(Behavior allInstancesOrNil)]					-> [#enumerating].
			[#(Behavior byteSizeOfInstance)]				-> [#'accessing instances and variables'].
			[#(Behavior byteSizeOfInstanceOfSize:)]		-> [#'accessing instances and variables'].
			[#(Behavior elementSize)]						-> [#'accessing instances and variables'].
			[#(Behavior handleFailingBasicNew)]			-> [#private].
			[#(Behavior handleFailingBasicNew:)]			-> [#private].
			[#(Behavior handleFailingFailingBasicNew)]		-> [#private].
			[#(Behavior handleFailingFailingBasicNew:)]		-> [#private].
			[#(Behavior identityHash)]						-> [#comparing].
			[#(Behavior isEphemeronClass)]				-> [#testing].
			[#(Behavior isImmediateClass)]					-> [#testing].
			[#(Character identityHash)]						-> [#comparing].
			[#(Class immediateSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category:)]
															-> [#'subclass creation'].
			[#(ClassBuilder superclass:immediateSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category:)]
															-> [#public].
			[#(Context class allInstances)]					-> [#enumerating].
			[#(Context class allInstancesDo:)]				-> [#enumerating].
			[#(MethodContext class allInstances)]			-> [#enumerating].
			[#(MethodContext class allInstancesDo:)]		-> [#enumerating].
			[#(SmallInteger asCharacter)]					-> [#converting].
			[#(SmalltalkImage growMemoryByAtLeast:)]	-> [#'memory space'].
			[#(SmalltalkImage maxIdentityHash)]			-> [#'system attributes'].
			[#(SystemDictionary growMemoryByAtLeast:)]	-> [#'memory space'].
			[#(SystemDictionary maxIdentityHash)]			-> [#'system attributes'].
			[#(SystemDictionary setGCParameters)]		-> [#'snapshot and quit'].
			[#(SystemNavigation allObjects)]				-> [#query].
			[#(SystemNavigation allObjectsOrNil)]			-> [#query].
			 }
		otherwise:
			[Transcript nextPutAll: className.
			 isMeta ifTrue: [Transcript nextPutAll: ' class'].
			 Transcript nextPutAll: '>>'; store: selector; nextPutAll: ' is unclassified'; cr; flush.
			 ^Categorizer default]