private
isMobile: obj
	<inline: true>
	^(self oop: obj isGreaterThanOrEqualTo: firstMobileObject andLessThanOrEqualTo:  lastMobileObject)
	 and: [(manager isPinned: obj) not]