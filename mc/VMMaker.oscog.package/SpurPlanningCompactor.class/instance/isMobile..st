private
isMobile: obj
	<inline: true>
	^(self oop: obj isGreaterThanOrEqualTo: mobileStart andLessThanOrEqualTo: lastMobileObject)
	 and: [(manager isPinned: obj) not]