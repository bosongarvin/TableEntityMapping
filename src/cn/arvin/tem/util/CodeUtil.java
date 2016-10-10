package cn.arvin.tem.util;

import java.util.List;

public final class CodeUtil {

	private CodeUtil() {}
	
	/**
	 * 生成ResultMap映射
	 * @author zhangbosong
	 * @date 2016年10月10日 下午5:00:40
	 */
	public static String createResultMap(List<String> columns) {
		StringBuffer mapStr = new StringBuffer("<resultMap id=\"\" type=\"\">");
		for (String c : columns) {
			mapStr.append("\n").append("	<result column=\""+ c +"\" property=\""+ c +"\"/>");
		}
		mapStr.append("\n</resultMap>");
		return mapStr.toString();
	}
}
