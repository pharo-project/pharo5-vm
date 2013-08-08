debug support
reportMinimumUnusedHeadroom
	"Report the stack page size and minimum unused headroom to stdout."
	<api>
	self cCode:
			[self pri: 'stack page bytes %ld available headroom %ld minimum unused headroom %ld\n'
				n: self stackPageByteSize asLong
				t: (self stackPageByteSize - self stackLimitBytes - self stackLimitOffset) asLong
				f: self minimumUnusedHeadroom asLong]
		inSmalltalk:
			["CogVMSimulator new initStackPagesForTests reportMinimumUnusedHeadroom"
			 self print: 'stack page bytes '; printNum: self stackPageByteSize;
				print: ' available headroom '; printNum: self stackPageByteSize - self stackLimitBytes - self stackLimitOffset;
				print: ' minimum unused headroom '; printNum: self minimumUnusedHeadroom;
				cr]