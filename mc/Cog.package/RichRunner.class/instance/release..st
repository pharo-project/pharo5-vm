private
release: identity 
    | t |
    t := self findTask: identity.
    t ifNil: [ ^ nil ].
    t taskHolding: false.
    ^ t priority > currentTask priority
	ifTrue: [ t ]
	ifFalse: [ currentTask ]