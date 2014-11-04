java sources
generateJavaActivity
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
import java.lang.Thread;
import android.view.Display;

import org.smalltalk.stack.StackVM;
import org.smalltalk.stack.StackView;
import android.os.Environment;
import android.os.Environment;

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
import java.lang.Thread;

public class StackActivity extends Activity {
	StackVM vm;
	Thread vmthread;
	StackView view;
	String libraryPath = "";
	String filesPath = "";
	String applicationPath = "";
	
	int globalModeForFile = MODE_PRIVATE;
	File imagePath = null;
	File vmFile = null;
	
	private static final String TAG = "JAVA Smalltalk Act";
	
    public void onInit(int status) {}





	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
		
    super.onCreate(savedInstanceState);	
	//init Path
	applicationPath = this.getApplicationContext().getApplicationInfo().dataDir + "/";
	libraryPath = applicationPath + "lib/";	
	filesPath = applicationPath + "files/";	
	vmFile = new File(libraryPath + "/libSmalltalkVM.so");
	getSmalltalkLog();
	
	
	
	if(destroySmalltalkLog()) Log.v(TAG,"SmalltalkDebug.log destroyed");
		else Log.v(TAG,"SmalltalkDebug.log not destroyed");
	if(this.loadFromAssets("SmalltalkRessources")) startVM("");
    }

	public void printFolderContent(String pathToPrint){
		File folder = new File(pathToPrint);
		File[] listOfFiles = folder.listFiles();
	  	Log.v(TAG,"The Folder " + pathToPrint + " containt: ");
		for (File file : listOfFiles) {
		    if (file.isFile()) {
			  	Log.v(TAG,"		" + file.getName());
		    }
		}
		
		
	}



	boolean copyFileFromAssetTo(String sourceFile, AssetManager assetManager, String pathDestination){
		int buflen = 65536;
	    byte[] buf = new byte[buflen];
	    int ofs, len;
	try {	
		InputStream is = assetManager.open(sourceFile , AssetManager.ACCESS_STREAMING);
		FileOutputStream fos = openFileOutput(pathDestination, globalModeForFile);

        while((len = is.read(buf, 0, buflen)) > 0) {
            fos.write(buf, 0, len);}	
		is.close();fos.close();
	} catch (Exception e) {
	    Log.v(TAG, e.toString());
	    return false;
	}
    return true;
    }
	
	boolean destroySmalltalkLog(){
		File fileD = getFilesDir();
		File file = new File("SmalltalkDebug.log");
		return file.delete();
	}
	
	
	boolean getSmalltalkLog(){
		int buflen = 65536;
	    byte[] buf = new byte[buflen];
	    int ofs, len;
	try {	
		InputStream fis = openFileInput("SmalltalkDebug.log");	
		File path = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
		File file = new File(path, "SmalltalkDebug.log");	
		FileOutputStream fos = new FileOutputStream(file);
		
        while((len = fis.read(buf, 0, buflen)) > 0) {
            fos.write(buf, 0, len);}	
		fis.close();fos.close();
	} catch (Exception e) {
		Log.v(TAG,"unsucefully copied SmalltalkDebug.log");
	    return false;
	}
	Log.v(TAG,"succefully copied SmalltalkDebug.log");
    return true;
    }
	


    boolean loadFromAssets(String subfolders) {
	try {
		AssetManager assetManager = getAssets();
		String as[] = assetManager.list(subfolders);
		//Copy all file from assets Sources should be at the same place that the vm
		for(int i = 0; i < as.length; i++) {
			this.copyFileFromAssetTo(subfolders + "/" +  as[i], assetManager, as[i] );
			if(as[i].contains(".image")) {
				imagePath = getFileStreamPath(as[i]);
				Log.v(TAG, imagePath.getAbsolutePath());}
		}
	} catch (Exception e) {
	    Log.v(TAG, e.toString());
	    return false;
	}
        return true;
    }

        /** If image is not loaded from assets, set title to its path */

    void setWindowTitle(String t) {
	super.setTitle(t);
    }


	/** Unzip pre-packed files along with the image.
	 *  The assets facility is not very convenient when it comes to packong multiple
	 *  files in a tree hierarchy. This method obtains the list of zipped files
	 *  stored under the "zipped" directory of assets and unzips them along with the
	 *  earlier unpacked image. Such unzipping occurs each time VM is started.
	 */

    public void startVM(String cmd) {

    	/* stupid setup dance but I''m not sure who is going to need what here */

		vm = new StackVM(this);
    	view = new StackView(this,vm);
		
        DisplayMetrics metrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metrics); 
		setContentView(view);
		
		
		vm.setScreenSize(metrics.widthPixels, metrics.heightPixels);
		
		
    	vm.loadImage(vmFile.getAbsolutePath(), imagePath.getAbsolutePath(), cmd);
	/* Unicode characters may be passed as extra characters array with action code
	 * ACTION_MULTIPLE. Examine this, an if not the case, return false to pass the
	 * event along, otherwise call the view''s onKeyDown directly and consume the event.
	  Variable or expression expected ->* Use the first character of the array.
	 */
	view.setOnKeyListener(new OnKeyListener() {
		public boolean onKey(View v, int keyCode, KeyEvent event) {
			int action = event.getAction();
			if (action != KeyEvent.ACTION_MULTIPLE) return false;
			
			return false;
		}
	});
        view.setFocusable(true);
	view.setFocusableInTouchMode(true);
        view.requestFocus();
	Intent checkIntent = new Intent();
	checkIntent.setAction(TextToSpeech.Engine.ACTION_CHECK_TTS_DATA);
	startActivityForResult(checkIntent, 0);
	String ns = Context.NOTIFICATION_SERVICE;
	try {
	    NotificationManager notmgr = (NotificationManager) getSystemService(ns);
	    Notification ntf = new Notification(R.drawable.ntficon, "", System.currentTimeMillis());
            Context context = getApplicationContext();
            CharSequence contentTitle = "StackVM";
            CharSequence contentText = imagePath.getAbsolutePath();
            Intent notificationIntent = new Intent(this, StackActivity.class);
            PendingIntent contentIntent = PendingIntent.getActivity(this, 0, notificationIntent, 0);

            ntf.setLatestEventInfo(context, contentTitle, contentText, contentIntent);
	    ntf.flags |= Notification.FLAG_NO_CLEAR;
	    notmgr.notify(1, ntf);
	} catch (Exception e) {
	   Log.v(TAG, e.toString());
	}

    }

    @Override
    public void onDestroy() {
        // Don''t forget to shutdown!
        super.onDestroy();
		getSmalltalkLog();
    }


    public void showBusyMsg() {}

    public void hideBusyMsg() {}

}

' 
toFile: 'src/org/smalltalk/stack/StackActivity.java'