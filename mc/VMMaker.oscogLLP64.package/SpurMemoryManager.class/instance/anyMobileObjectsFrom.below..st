compaction
anyMobileObjectsFrom: initialOop below: limit 
	self allOldSpaceEntitiesFrom: initialOop
		do: [:objOop| | isMobile | "this variable is to avoid limitations in Slang's inliner"
			 isMobile := self isMobileObject: objOop.
			 isMobile ifTrue:
				[^true]].
	^false