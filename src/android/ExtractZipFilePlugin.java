/*
    Author: Vishal Rajpal
    Filename: ExtractZipFilePlugin.java
    Created Date: 21-02-2012
    Modified Date: 21-02-2013
    Modified to comply with Cordova by: Ran Friedlender
*/

package co.geomati.extractzipfile;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;

import org.json.JSONArray;
import org.json.JSONException;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;

public class ExtractZipFilePlugin extends CordovaPlugin
{
    private static final String IMG = "img";
	private static final String SO = "so";
	private static final String AUTOR = "autor";

	@Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException
    {
        if (action.equals("unzip"))
        {
            String filename = args.getString(0); 
            unzip(filename, callbackContext);
            return true;
        }

        return false;
    }

    private void unzip(String filename, CallbackContext callbackContext)
    {
        File file = new File(filename);
        String[] dirToSplit = filename.split(File.separator);
        String dirToInsert = "";
        String foldername = dirToSplit[dirToSplit.length - 1].substring(0, dirToSplit[dirToSplit.length - 1].lastIndexOf('.'));

        for (int i = 0; i < dirToSplit.length - 1; i++)
        {
            dirToInsert += dirToSplit[i] + File.separator;
        }
        
        File folder =  new File(dirToInsert + File.separator + foldername);
        File img = new File(folder + File.separator + IMG);
        File so = new File(folder + File.separator + SO);
        File autor = new File(folder + File.separator + AUTOR);

        BufferedOutputStream dest = null;
        BufferedInputStream is = null;
        ZipEntry entry;
        ZipFile zipfile;
        
        if (!folder.exists()) {
        	folder.mkdir();
        	so.mkdir();
        	img.mkdir();
        	autor.mkdir();
        }

        try
        {
            zipfile = new ZipFile(file);
            Enumeration<? extends ZipEntry> e = zipfile.entries();

            while (e.hasMoreElements()) 
            {
                entry = (ZipEntry)e.nextElement();
                is = new BufferedInputStream(zipfile.getInputStream(entry), 8192);
                int count;
                byte data[] = new byte[102222];
                String fileName = folder + File.separator + entry.getName();
                File outFile = new File(fileName);

                if (entry.isDirectory()) 
                {
                    outFile.mkdirs();
                } 
                else 
                {
                    FileOutputStream fos = new FileOutputStream(outFile);
                    dest = new BufferedOutputStream(fos, 102222);

                    while ((count = is.read(data, 0, 102222)) != -1)
                    {
                        dest.write(data, 0, count);
                    }

                    dest.flush();
                    dest.close();
                    is.close();
                  }
            }
        }
        catch (ZipException e1)
        {
            callbackContext.error(PluginResult.Status.MALFORMED_URL_EXCEPTION.toString());
            return;
        }
        catch (IOException e1)
        {
            callbackContext.error(PluginResult.Status.IO_EXCEPTION.toString());
            return;
        }

        callbackContext.success(folder.getAbsolutePath());
    }
}
