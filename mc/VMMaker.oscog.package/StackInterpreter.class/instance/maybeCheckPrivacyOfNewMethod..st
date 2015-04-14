message sending
maybeCheckPrivacyOfNewMethod: currentClass
	<inline: true>
	(NewspeakVM
	  and: [CheckPrivacyViolations
	  and: [isPrivateSend not
	  and: [messageSelector ~= (objectMemory splObj: SelectorDoesNotUnderstand)
	  and: [(self accessModifierOfMethod: newMethod) ~= AccessModifierPublic]]]]) ifTrue:
		[self print: (self nameOfClass: currentClass); space.
		 self printStringOf: (messageSelector); print: ' from '.
		 self printStringOf: (self maybeSelectorOfMethod: method); cr]