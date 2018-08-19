package com.sojson.common;

import java.io.Serializable;


/**<p>Title(文件名): ResultMessage.java </p>
 * <p>Description(描述): 响应用户结果的提示信息类 </p>
*/
public class ResultMessage implements Serializable {
    private static final long serialVersionUID = 1L;
    
    /**消息等级,主要用于确定页面提示框类型*/
    protected byte level;
    /** 消息值 比如:xxx成功,xxx失败 
     * 主要用于页面提示框中显示的信息
     */
    protected String messageText;
    
    /**
     * 返回页面的对象信息
     */
    protected Object data;
    /**
     * <p> Title(文件名): ResultMessage.java </p>
     * <p> Description(描述): Message Level的枚举定义 </p>
     */
    public enum MSG_LEVEL {
    	/** 信息级别-成功信息 */
    	SUCC((byte)1),
    	/** 信息级别-提示信息/警告 */
    	HINT((byte)2),
    	/** 信息级别-错误信息 */
    	FAIL((byte)3);
    	
    	public byte v;
    	private MSG_LEVEL(byte v) {
    		this.v = v;
    	}
    }
    
    public ResultMessage() {
    }

    public ResultMessage(byte level) {
    	this.level = level;
    }
    
    public ResultMessage(byte level, String messageText) {
    	this.level = level;
        this.messageText = messageText;
    }
    
    

    /**
     * 消息信息
     */
    public String getMessageText() {
        return messageText;
    }
    /**
     * 消息信息
     */
    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    /**
     * 消息等级
     */
	public byte getLevel() {
		return level;
	}
	/**
	 * 设置消息等级
	 */
	public void setLevel(byte level) {
		this.level = level;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
	