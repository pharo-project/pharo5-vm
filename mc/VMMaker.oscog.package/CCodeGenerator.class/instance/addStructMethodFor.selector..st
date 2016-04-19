utilities
addStructMethodFor: aClass selector: selector 
	"Add the given struct method to the code base and answer its translation
	 or nil if it shouldn't be translated."
	(self methodNamed: selector) ifNotNil:
		[:tmethod|
		 "If we're repeating an attempt to add the same thing, or
		  if the existing method overrides this one,don't complain."
		 (tmethod definingClass includesBehavior: aClass) ifTrue:
			[^self].
		 "If the methods are both simple accessors, don't complain."
		 ((tmethod definingClass isAccessor: selector)
		 and: [aClass isAccessor: selector]) ifTrue:
			[^self].
		 "If the method is overriding a method in a superclass, don't complain"
		 (aClass inheritsFrom: tmethod definingClass)
			ifTrue: [methods removeKey: selector]
			ifFalse: [self error: 'conflicting implementations for ', selector storeString]].
	^(self addMethodFor: aClass selector: selector) ifNotNil:
		[:tmethod|
		tmethod transformToStructClassMethodFor: self.
		tmethod]