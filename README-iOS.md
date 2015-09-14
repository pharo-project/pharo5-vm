#iOS build setup:

The process for compiling the VM for iOS is almost the same, but there are some extra steps you need to do:

1. You need to produce a valid Pharo image (which is a plain Pharo image with some packages). The easiest way to do it is going to `iosbuild/resources`, then execute:
	```
	./generate.sh
	```

2. The lines you need to evaluate in `generator.image` for producing iOS sources are:
	```
	PharoIPhoneBuilder buildIPhone.
	PharoIPhoneBuilder buildIPhoneSimulator.
	```
	(the differences between them are self explanatory)

3. You can then execute `sh build.sh` in build subdirectory, and you will have a Pharo.app waiting for you in `results` :) 
	
That will not solve certain common problems you will find when working for iOS, thought. I will try to cover some of them now.

####Problem 1: Debugging/deploying through Xcode 
You will need to produce a valid xcodeproj file. Is very easy, just follow next steps. 

1. Go to `build` directory
2. execute: `../scripts/extract-commit-info.sh`
3. remove CMakeCache.txt (if it exists)
4. execute: `cmake -G Xcode .`

Done! you will have an xcode project and you can proceed from there as any other regular iOS app.

####Problem 2: Signing for publishing
The problem of publishing apps is very complicated and in my opinion, moronic... but well, that's the game and we have to play with those rules (I will not explain them, in part because I do not understand it completely, you can go to [Apple developers site](http://developer.apple.com) and try to dig it there).  
There is one tool that you can use to automate the signing process, assuming you have all the required previous steps:  
```
xcrun -sdk iphoneos PackageApplication \
    /path/to/your/results/Pharo.app \
    -o "/path/to/your/results/iPharo.ipa" \
    --sign "iPhone Distribution: YOUR DISTRUBUTION NAME" \
    --embed "/pat/to/your/app.mobileprovision"
```
