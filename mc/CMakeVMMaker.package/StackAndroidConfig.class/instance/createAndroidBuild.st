android config file
createAndroidBuild
	self write: '<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
      package="org.smalltalk.stack"
      android:versionCode="1"
      android:versionName="1.0">
	<supports-screens android:smallScreens="true"
	                        android:normalScreens="true"
	                        android:largeScreens="true"
	                        android:xlargeScreens="true"
		                    android:anyDensity="true"
	                        android:requiresSmallestWidthDp="600" /> 
    <application android:icon="@drawable/icon"
		 android:label="@string/app_name">
        <activity android:name="StackActivity"
		  android:screenOrientation="landscape"
		  android:layout_width="match_parent"
		  android:layout_height="match_parent"
          android:launchMode="singleInstance"
		  android:label="@string/app_name"
		  android:theme="@android:style/Theme.NoTitleBar"
		  
		  
                  android:icon="@drawable/icon">
             <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_FRAME_BUFFER" />
    <uses-permission android:name="com.android.launcher.permission.INSTALL_SHORTCUT" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
</manifest> 
' toFile: 'build.xml'