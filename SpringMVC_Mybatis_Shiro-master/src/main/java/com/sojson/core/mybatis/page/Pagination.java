package com.sojson.core.mybatis.page;

import java.util.List;

/**
 * 分页的对象，以及分页页码输出
 * 
 */
@SuppressWarnings("serial")
public class Pagination<T> extends SimplePage implements java.io.Serializable,
		Paginable {

	public Pagination() {
	}

	public Pagination(int pageNo, int pageSize, int totalCount) {
		super(pageNo, pageSize, totalCount);
	}

	@SuppressWarnings("unchecked")
	public Pagination(int pageNo, int pageSize, int totalCount, List list) {
		super(pageNo, pageSize, totalCount);
		this.list = list;
	}

	public int getFirstResult() {
		return (pageNo - 1) * pageSize;
	}

	/**
	 * 当前页的数据
	 */
	private List<T> list;

	private String totalAmount;

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	
	/** 翻页版本*/
	public String getWebPage(String page){
		StringBuffer pageHtml = new StringBuffer("<ul class='pagination'>");
		if(this.getPageNo()>1){
			if(this.getPageNo()>5){
				pageHtml.append("<li><a href='javascript:;' onclick='"+ page +"'>首页</a></li>");
			}
			pageHtml.append("<li><a href='"+ page +""+(this.getPageNo() -1) +"'>上一页</a></li>");
		}
		for (int i = (this.getPageNo()-2<=0?1:this.getPageNo()-2),no = 1; i <= this.getTotalPage()&& no <6 ; i++,no++) {
			if (this.getPageNo() == i) {
				pageHtml.append("<li class='active'><a href='javascript:void(0);' >"+i+"</a></li>");
			}else{
				pageHtml.append("<li><a href='"+ page +""+ i +"'>"+i+"</a></li>");
			}
		}
		if(this.getPageNo() < this.getTotalPage()){
			pageHtml.append("<li><a href='"+ page +""+(this.getPageNo()+1) +"'>下一页</a></li>");
		}
		pageHtml.append("</ul>");
		return pageHtml.toString();
	}
	
	
	
	/**Ajxa翻页*/
	public String getSiAjaxPageHtml(){
		StringBuffer pageHtml = new StringBuffer("<ul class='pagination'>");
		if(this.getPageNo()>1){
			if(this.getPageNo()>5){
				pageHtml.append("<li><a href='javascript:;' onclick='goPageByAjax(1)'>首页</a></li>");
			}
			pageHtml.append("<li><a href='javascript:;'  onclick='goPageByAjax("+(this.getPageNo() - 1)+")'>上一页</a></li>");
		}
		for (int i = (this.getPageNo()-2<=0?1:this.getPageNo()-2),no = 1; i <= this.getTotalPage()&& no <6 ; i++,no++) {
			if (this.getPageNo() == i) {
				pageHtml.append("<li class='active'><a href='javascript:void(0);' >"+i+"</a></li>");
			}else{
				pageHtml.append("<li><a href='javascript:;' onclick='goPageByAjax("+i+")'>"+i+"</a></li>");
			}
		}
		if(this.getPageNo() < this.getTotalPage()){
			pageHtml.append("<li><a href='javascript:;'  onclick='goPageByAjax("+(this.getPageNo() + 1)+")'>下一页</a></li>");
		}
		pageHtml.append("</ul>");
		return pageHtml.toString();
	}
	
	/**普通翻页*/
	public String getPageHtml(){
		StringBuffer pageHtml = new StringBuffer("<ul class='pagination'>");
		if(this.getPageNo()>1){
			if(this.getPageNo()>5){
				pageHtml.append("<li><a href='javascript:;' onclick='_submitform(1)'>首页</a></li>");
			}
			pageHtml.append("<li><a href='javascript:;'  onclick='_submitform("+(this.getPageNo() - 1)+")'>上一页</a></li>");
		}
		for (int i = (this.getPageNo()-2<=0?1:this.getPageNo()-2),no = 1; i <= this.getTotalPage()&& no <6 ; i++,no++) {
			if (this.getPageNo() == i) {
				pageHtml.append("<li class='active'><a href='javascript:void(0);' >"+i+"</a></li>");
			}else{
				pageHtml.append("<li><a href='javascript:;' onclick='_submitform("+i+")'>"+i+"</a></li>");
			}
		}
		if(this.getPageNo() < this.getTotalPage()){
			pageHtml.append("<li><a href='javascript:;'  onclick='_submitform("+(this.getPageNo() + 1)+")'>下一页</a></li>");
		}
		pageHtml.append("</ul>");
		pageHtml.append("<script>");
		pageHtml.append("	function _submitform(pageNo){");
		pageHtml.append("		$(\"#formId\").append($(\"<input type='hidden' value='\" + pageNo +\"' name='pageNo'>\")).submit();");
		pageHtml.append("	}");
		pageHtml.append("</script>");
		
		return pageHtml.toString();
	}

	/**
	 * 门户网站的ajax分页
	 * @return
	 */
	public String getPortalPageHtml(){
		int totalPage = (int)Math.ceil((double)totalCount/pageSize);
		StringBuffer pageHtml = new StringBuffer("<div class='pager' id='pager'><ul class='floatR'>");
		pageHtml.append("<li><a  class='text' href='javascript:;' onclick='goPageByAjax(1)'>首页</a></li>");
		if (this.getPageNo() > 1) {
			pageHtml.append("<li><a  class='icon' href='javascript:;'  onclick='goPageByAjax(" + (this.getPageNo() - 1) + ")'>&lt;</a></li>");
		}
		for (int i = (this.getPageNo()-2<=0?1:this.getPageNo()-2),no = 1; i <= this.getTotalPage()&& no <6 ; i++,no++) {
			if (this.getPageNo() == i) {
				pageHtml.append("<li><span class='numb on'>"+i+"</span></li>");
			}else{
				pageHtml.append("<li><a class='numb' href='javascript:;' onclick='goPageByAjax("+i+")'>"+i+"</a></li>");
			}
		}
		if (this.getPageNo() < totalPage) {
			pageHtml.append("<li><a class='icon' href='javascript:;'  onclick='goPageByAjax(" + (this.getPageNo() + 1) + ")'>&gt;</a></li>");
		}
		pageHtml.append("<li><a class='icon' href='javascript:;'  onclick='goPageByAjax("+(totalPage)+")'>尾页</a></li>");
		pageHtml.append("</ul><span class='page-numb'>第"+this.getPageNo()+"页 / 共"+totalPage+"页</span></div>");
		return pageHtml.toString();
	}

	/**
	 * 门户网站的ajax分页2(页面有2个分页的时候的处理)
	 * @return
	 */
	public String getPortalPageHtml2(){
		int totalPage = (int)Math.ceil((double)totalCount/pageSize);
		StringBuffer pageHtml = new StringBuffer("<div class='pager' id='pager2'><ul class='floatR'>");
		pageHtml.append("<li><a  class='text' href='javascript:;' onclick='goPageByAjax2(1)'>首页</a></li>");
		if (this.getPageNo() > 1) {
			pageHtml.append("<li><a  class='icon' href='javascript:;'  onclick='goPageByAjax2(" + (this.getPageNo() - 1) + ")'>&lt;</a></li>");
		}
		for (int i = (this.getPageNo()-2<=0?1:this.getPageNo()-2),no = 1; i <= this.getTotalPage()&& no <6 ; i++,no++) {
			if (this.getPageNo() == i) {
				pageHtml.append("<li><span class='numb on'>"+i+"</span></li>");
			}else{
				pageHtml.append("<li><a class='numb' href='javascript:;' onclick='goPageByAjax2("+i+")'>"+i+"</a></li>");
			}
		}
		if (this.getPageNo() < totalPage) {
			pageHtml.append("<li><a class='icon' href='javascript:;'  onclick='goPageByAjax2(" + (this.getPageNo() + 1) + ")'>&gt;</a></li>");
		}
		pageHtml.append("<li><a class='icon' href='javascript:;'  onclick='goPageByAjax2("+(totalPage)+")'>尾页</a></li>");
		pageHtml.append("</ul><span class='page-numb'>第"+this.getPageNo()+"页 / 共"+totalPage+"页</span></div>");
		return pageHtml.toString();
	}
}
