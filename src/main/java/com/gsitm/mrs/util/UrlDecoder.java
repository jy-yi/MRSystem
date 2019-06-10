package com.gsitm.mrs.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * JSTL URLDecoder 클래스
 * 
 * @Package : com.gsitm.mrs.util
 * @date : 2019. 6. 9.
 * @author : 이종윤
 */
public class UrlDecoder {

	public static String urlDecode(String input) throws UnsupportedEncodingException {
		return URLDecoder.decode(input, "UTF-8");
	}

}
