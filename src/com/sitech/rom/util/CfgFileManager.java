package com.sitech.rom.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.apache.derby.tools.sysinfo;

public class CfgFileManager {

	public static String readValue(String filePath, String key) {
		SafeProperties props = new SafeProperties();
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					new FileInputStream(filePath), "GBK"));
			//props.load(reader);
			reader.close();
			String value = props.getProperty(key);
			return value;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static Boolean writeProperties(String filePath, String parameterName,
			String parameterValue) {
		Boolean isWrite = true;
		SafeProperties props = new SafeProperties();
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					new FileInputStream(filePath), "GBK"));
			//props.load(reader);
			reader.close();
			OutputStream out = new FileOutputStream(filePath);
			props.setProperty(parameterName, parameterValue);

			// 将此 Properties 表中的属性列表（键和元素对）写入输出流
			props.store(out, null);
		} catch (IOException e) {
			isWrite = false;
			e.printStackTrace();
		}
		return isWrite;
	}

	public static Boolean writeProperties(String filePath, Map<String, String> map) {
		Boolean isWrite = true;
		SafeProperties props = new SafeProperties();
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					new FileInputStream(filePath), "GBK"));
			//props.load(reader);
			reader.close();
			OutputStream out = new FileOutputStream(filePath);

			// for循环map
			for (Map.Entry<String, String> entry : map.entrySet()) {
				props.setProperty(entry.getKey(), entry.getValue());
			}
			// 将此 Properties 表中的属性列表（键和元素对）写入输出流
			props.store(out, null);
		} catch (IOException e) {
			isWrite = false;
			e.printStackTrace();
		}
		return isWrite;
	}

	public static Map<String, String> readProperties(String filePath) {
		SafeProperties props = new SafeProperties();
		Map map = new HashedMap();

		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					new FileInputStream(filePath), "GBK"));
			//props.load(reader);
			reader.close();
			Enumeration en = props.propertyNames();
			while (en.hasMoreElements()) {
				String key = (String) en.nextElement();
//				System.out.println(key);
				String property = props.getProperty(key);
//				System.out.println(property);
				map.put(key, property);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}
}
