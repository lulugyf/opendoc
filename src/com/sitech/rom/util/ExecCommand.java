package com.sitech.rom.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;

import org.springframework.stereotype.Service;

public class ExecCommand {

	
	
	public static String postData(String data, URL endpoint) throws Exception {
		return ExecCommand.postData(data, endpoint, "");
	}
	
	public static String postData(String data, URL endpoint, String authorizationStr) throws Exception {
		
		HttpURLConnection urlc = null;
		StringBuffer result = new StringBuffer();
		
		try {
			urlc = (HttpURLConnection) endpoint.openConnection();
			try {
				urlc.setRequestMethod("POST");
			} catch (ProtocolException e) {
				throw new Exception("Shouldn't happen: HttpURLConnection doesn't support POST??", e);
			}
			urlc.setDoOutput(true);
			urlc.setDoInput(true);
			urlc.setUseCaches(false);
			urlc.setAllowUserInteraction(false);
			urlc.setRequestProperty("Content-type", "text/plain; charset=UTF-8");
 
			urlc.setRequestProperty("Authorization", authorizationStr);//安全验证
			
			OutputStream out = urlc.getOutputStream();
			try {
				Writer writer = new OutputStreamWriter(out, "UTF-8");
				writer.write(data);
				writer.close();
			} catch (IOException e) {
				throw new Exception("IOException while posting data", e);
			} finally {
				if (out != null)
					out.close();
			}
			InputStream in = urlc.getInputStream();
			try {
				//Reader reader = new InputStreamReader(in, "UTF-8");				
				BufferedReader reader = new BufferedReader(
				        new InputStreamReader(in, "UTF-8"));
				//一个一个字符读性能不好。 update by yl.
				/**
				int c = 0;
				while((c = reader.read())!= -1){
					result.append((char)c);
				}
				**/
				
				String line = null;
				while ((line = reader.readLine()) != null) {
		    	  if(line != null ){
		    		  result.append(line);			    		  
		    	  }			          
		        }				

				reader.close();
			} catch (IOException e) {
				throw new Exception("IOException while reading response", e);
			} finally {
				if (in != null)
					in.close();
			}
		} catch (IOException e) {
			throw new Exception("Connection error (is server running at "
					+ endpoint + " ?): " + e);
		} finally {
			if (urlc != null)
				urlc.disconnect();
		}
 
		return result.toString();
	}
 
}
