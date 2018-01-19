<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
  <t:datagrid name="templateGoodsWordsList" checkbox="true" fitColumns="true" title="商品话术" actionUrl="templateWordsController.do?datagridGoodsWords&fin_Act_Id=${finActId }" 
  idField="id" fit="true" queryMode="group" sortName="updateDate" sortOrder="desc">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
<%--    <t:dgCol title="创建日期"  field="createDate" hidden="true"  formatter="yyyy-MM-dd"  queryMode="single"  width="120"></t:dgCol> --%>
   <t:dgCol title="排序"  field="sortNum"    queryMode="single"  width="40"></t:dgCol>
   <t:dgCol title="话术"  field="words"    queryMode="single"  width="220"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="60"></t:dgCol>
   <t:dgDelOpt title="删除" url="templateWordsController.do?doDel&id={id}" />
   <c:if test="${userType != '01' }">
   <t:dgToolBar title="录入" icon="icon-add" url="templateWordsController.do?goAdd&finActId=${finActId }&wordsType=2" funname="add" height="200"></t:dgToolBar>
   <t:dgToolBar title="选择" icon="icon-add" url="tGoodsWordsController.do?retailerVisibleList&finActId=${finActId }" funname="chooseWords" ></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="templateWordsController.do?goUpdate" funname="update" height="200"></t:dgToolBar>
   </c:if>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="templateWordsController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="templateWordsController.do?goUpdate" funname="detail" height="200"></t:dgToolBar>
  </t:datagrid>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 });
 
//选择商品话术
 function chooseWords(title,url) {
	 gridname = "templateGoodsWordsList";
 		 $.dialog.setting.zIndex = 100;
 		 if(typeof(windowapi) == 'undefined'){
 			 $.dialog({
 					content: "url:"+url,
 					lock : true,
 					title:"选择商品话术",
 					width:700,
 					height: 500,
 					cache:false,
 				    ok: function(){
 				    	iframe = this.iframe.contentWindow;
 				    	var selected = iframe.getSelectRows();
 				    	if (selected == '' || selected == null ){
 				    		alertTip('请选择商品话术');
 				    		return false;
 					    }else {
 					    	var wordsIds = "";
// 							  selected是要遍历的集合
// 							  index就是索引值
// 							  domEle 表示获取遍历每一个dom对
 					    	$.each(selected,function (index,domEle){
 					    		wordsIds += domEle.id + ",";
 							});
 							var url = "templateWordsController.do?doBatchAddGoodsWords";
							$.ajax({
								url : url,
								type : 'post',
								data : {
									finActId : '${finActId }',
									wordsType : '${wordsType}',//商品话术
									wordsIds : wordsIds
								},
								cache : false,
								success : function(data) {
									var d = $.parseJSON(data);
									if (d.success) {
										var msg = d.msg;
										tip(msg);
										reloadTable();
										$("#"+gridname).datagrid('unselectAll');
									}
								}
							});
 					    }
 				    },
 				    cancelVal: '关闭',
 				    cancel: true /*为true等价于function(){}*/
 				}).zindex();
 			} else{
 				$.dialog({
 					content: "url:"+url,
 					lock : true,
 					title:"选择商品话术",
 					width:700,
 					height: 500,
 					parent:windowapi,
 					cache:false,
 				     ok: function(){
 				    	 iframe = this.iframe.contentWindow;
 					    	var selected = iframe.getSelectRows();
 					    	if (selected == '' || selected == null ){
 					    		alertTip('请选择商品话术');
 					    		return false;
 						    }else {
								  var wordsIds = "";
// 	 							  selected是要遍历的集合
// 	 							  index就是索引值
// 	 							  domEle 表示获取遍历每一个dom对
 	 					    	$.each(selected,function (index,domEle){
 	 					    		wordsIds += domEle.id + ",";
 	 							});
 	 					    	var url = "templateWordsController.do?doBatchAddGoodsWords";
 								$.ajax({
 									url : url,
 									type : 'post',
 									data : {
 										finActId : '${finActId }',
 										wordsType : '${wordsType}',//活动话术
 										wordsIds : wordsIds
 									},
 									cache : false,
 									success : function(data) {
 										var d = $.parseJSON(data);
 										if (d.success) {
 											var msg = d.msg;
 											tip(msg);
 											reloadTable();
 											$("#"+gridname).datagrid('unselectAll');
 										}
 									}
 								});
 						    }
 				    },
 				    cancelVal: '关闭',
 				    cancel: true /*为true等价于function(){}*/
 				}).zindex();
 			}
 	}
 
 </script>