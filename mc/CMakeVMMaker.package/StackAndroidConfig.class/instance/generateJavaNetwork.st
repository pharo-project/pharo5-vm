java sources
generateJavaNetwork
		self write: 'package org.smalltalk.stack;

import java.io.File;
import java.io.FileFilter;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.lang.Exception;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.nio.channels.ReadableByteChannel;
import java.nio.channels.Channels;

import org.smalltalk.stack.StackVM;
import org.smalltalk.stack.StackView;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.net.Uri;
import java.net.URL;
import android.os.Bundle;
import android.os.Environment;
import android.speech.tts.TextToSpeech;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View.OnKeyListener;
import android.view.View;
import android.widget.Toast;
import java.lang.Runnable;


public class StackNetwork implements Runnable {
	private static final String TAG = "JAVA Smalltalk Act";
	public StackNetwork(){}
	public void run(){
		this.loadFile();
	}
	
	
    private void loadFile() {
	try{
		URL website = new URL("http://files.Smalltalk.org/image/40/Smalltalk-Image-4.0-latest.zip");
		ReadableByteChannel rbc = Channels.newChannel(website.openStream());
		String extdir = Environment.getExternalStorageDirectory().getAbsolutePath();
		FileOutputStream fos = new FileOutputStream(extdir + "/Smalltalk-Image-4.0-latest.zip");
		fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
		fos.close();
		Log.v(TAG, extdir);
} 
	catch (Exception e) {Log.v(TAG, e.getMessage());}
	
	}

}

' 
toFile: 'src/org/smalltalk/stack/StackNetwork.java'