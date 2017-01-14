stack depth
doJump: delta
	delta < 0
		ifTrue:
			[(joins at: pc + delta) ~= stackp ifTrue: [(Notification new tag: #'bad join'; signal)]]
		ifFalse:
			[joins at: pc + delta put: stackp]