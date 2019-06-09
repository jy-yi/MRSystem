package com.gsitm.mrs.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * JSTL URLDecoder 클래스
 * 
 * @author jongy
 *
 */
public class UrlDecoder {
	
	public static String urlDecode(String input) throws UnsupportedEncodingException {
		return URLDecoder.decode(input, "UTF-8");
	}
	
}
