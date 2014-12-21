package com.sitech.rom.util;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@SuppressWarnings("unchecked")
public class JavaMapChange {
	/**
	 * 
	 * @Title:
	 * @Description:
	 * @param obj
	 *            转换对象
	 * @param pre
	 *            生成map的key前缀
	 * @param las
	 *            生成map的key后缀
	 * @return
	 * @return Map<String,String> create by Administrator on 2011-5-9
	 */
	public static Map<String, Object> dtoToMap(Object obj, String pre,
			String las) {
		Map result = new HashMap();
		Class clazz = obj.getClass();
		Field[] fs = clazz.getDeclaredFields();
		for (int i = 0; i < fs.length; i += 1) {
			if (Modifier.isStatic(fs[i].getModifiers())) {
				continue;
			}
			fs[i].setAccessible(true);
			try {
				Object value = fs[i].get(obj);
				
				if (value != null) {
					result.put(pre + fs[i].getName() + las, value);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public static Object mapToDto(Map<String, String> map, Class clazz) {
		Object result = null;
		Set<String> keySet = map.keySet();
		try {
			result = clazz.newInstance();
			for (String attr : keySet) {
				Field field=null;
				try{
					 field = clazz.getDeclaredField(attr);
				}catch(NoSuchFieldException e){continue;}

				field.setAccessible(true);
				Class typeClazz = field.getType();
				Object o=map.get(attr);
				if(o==null) continue;
				if (typeClazz.equals(String.class)) {
					String s=o.toString();
					field.set(result, s);
				} else if (typeClazz.equals(Integer.class)) {
					field.set(result, Integer.parseInt(o.toString()));
				} else if (typeClazz.equals(Long.class)) {
					field.set(result, Long.parseLong(o.toString()));
				} else if (typeClazz.equals(Date.class)) {
					String dateType=Constants.getType(o.toString());
					if(dateType!=null){
						SimpleDateFormat sdf = new SimpleDateFormat(dateType);
						Date date = sdf.parse(o.toString());
						field.set(result, date);
					}
				}else if(typeClazz.equals(Float.class)){
					field.set(result, Float.parseFloat(o.toString()));
				}else if(typeClazz.equals(Double.class)){
					field.set(result, Double.parseDouble(o.toString()));
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	

	public static void main(String[] args) {
	}
}
