plugin primitive support
includesBehavior: aClass ThatOf: aSuperclass
	"Return the equivalent of 
		aClass includesBehavior: aSuperclass.
	Note: written for efficiency and better inlining (only 1 temp)"
	| theClass |
	<inline: true>
	aSuperclass = nilObj ifTrue:
		[^false].
	theClass := aClass.
	[theClass = aSuperclass ifTrue:
		[^true].
	 theClass ~= nilObj] whileTrue:
		[theClass := self superclassOf: theClass].
	^false