package com.lf.admin.util;

import org.springframework.context.support.MessageSourceAccessor;

public class Message {

	/**
	 * MessageSourceAccessor
	 */
	private static MessageSourceAccessor msAcc = null;

	public void setMessageSourceAccessor(MessageSourceAccessor msAcc) {
		Message.msAcc = msAcc;
	}

	/**
	 * KEY에 해당하는 메세지 반환
	 * 
	 * @param key
	 * @return
	 */
	public static String getMessage(String key) {
		return msAcc.getMessage(key);
	}

	/**
	 * KEY에 해당하는 메세지 반환
	 * 
	 * @param key
	 * @param objs
	 * @return
	 */
	public static String getMessage(String key, Object[] objs) {
		return msAcc.getMessage(key, objs);
	}

}
