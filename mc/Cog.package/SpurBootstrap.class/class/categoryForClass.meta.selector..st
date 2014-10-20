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
			[#(Character setValue:)]						-> [#accessing].
			[#(Class immediateSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category:)]
															-> [#'subclass creation'].
			[#(ClassBuilder superclass:immediateSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category:)]
															-> [#public].
			[#(CompiledMethod bytecodeSetName)]		-> [#accessing].
			[#(CompiledMethod class handleFailingFailingNewMethod:header:)]
															-> [#private].
			[#(CompiledMethod class handleFailingNewMethod:header:)]
															-> [#private].
			[#(CompiledMethod class headerFlagForEncoder:)]
															-> [#'method encoding'].
			[#(CompiledMethod class installPrimaryBytecodeSet:)]
															-> [#'class initialization'].
			[#(CompiledMethod class installSecondaryBytecodeSet:)]
															-> [#'class initialization'].
			[#(Context class allInstances)]					-> [#enumerating].
			[#(Context class allInstancesDo:)]				-> [#enumerating].
			[#(Context failPrimitiveWith:)]					-> [#'system simulation'].
			[#(Context isPrimFailToken:)]					-> [#private].
			[#(Context send:to:with:lookupIn:)]				-> [#controlling].
			[#(ContextPart isPrimFailToken:)]				-> [#private].
			[#(ContextPart send:to:with:lookupIn:)]			-> [#controlling].
			[#(EncoderForV3 computeMethodHeaderForNumArgs:numTemps:numLits:primitive:)]
															-> [#'method encoding'].
			[#(EncoderForV3PlusClosures genCallPrimitive:)]
															-> [#'bytecode generation'].
			[#(EncoderForV3PlusClosures class callPrimitiveCode)]
															-> [#'bytecode decoding'].
			[#(MethodContext failPrimitiveWith:)]			-> [#'system simulation'].
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