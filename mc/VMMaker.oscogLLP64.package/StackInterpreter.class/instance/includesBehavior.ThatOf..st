plugin primitive support
includesBehavior: aClass ThatOf: aSuperclass
	"Return the equivalent of 
		aClass includesBehavior: aSuperclass.
	Note: written for efficiency and better inlining (only 1 temp)"
	| theClass |
	<inline: true>
	aSuperclass = objectMemory nilObject ifTrue:
		[^false].
	theClass := aClass.
	[theClass = aSuperclass ifTrue:
		[^true].
	 theClass ~= objectMemory nilObject] whileTrue:
		[theClass := self superclassOf: theClass].
	^false