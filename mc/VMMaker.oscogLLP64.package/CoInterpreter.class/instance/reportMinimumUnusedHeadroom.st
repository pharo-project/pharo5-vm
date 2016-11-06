debug support
reportMinimumUnusedHeadroom
	"Report the stack page size and minimum unused headroom to stdout."
	<api>
	self cCode:
			[self pri: 'stack page bytes %lld available headroom %lld minimum unused headroom %lld\n'
				n: self stackPageByteSize asUnsignedLongLong
				t: (self stackPageByteSize - self stackLimitBytes - self stackLimitOffset) asUnsignedLongLong
				f: self minimumUnusedHeadroom asUnsignedLongLong]
		inSmalltalk:
			["CogVMSimulator new initStackPagesForTests reportMinimumUnusedHeadroom"
			 self print: 'stack page bytes '; printNum: self stackPageByteSize;
				print: ' available headroom '; printNum: self stackPageByteSize - self stackLimitBytes - self stackLimitOffset;
				print: ' minimum unused headroom '; printNum: self minimumUnusedHeadroom;
				cr]