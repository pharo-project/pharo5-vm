private
isMobile: obj
	<inline: #always>
	^(self oop: obj isGreaterThanOrEqualTo: firstMobileObject andLessThanOrEqualTo:  lastMobileObject)
	 and: [(manager isPinned: obj) not]