<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>MySQL resultMap映射生成</title>
<style type="text/css">
	* {margin:0;padding:0;}
	html,body {width:100%;font-size:16px;}
	body,a,textarea {color:#333;font-family:Consolas, "微软雅黑";}
	.main {overflow:hidden;padding:10px;}
	
	.info {
		float:left;width:408px;
	}
	.info p {
		line-height:40px;
	}
	.info p .input {
		height:30px;padding:0 3px;width:400px;outline:0;border:1px solid #ccc;background:transparent;
		border-radius:2px;box-shadow:0 0 3px #ccc;letter-spacing:0.4px;
	}
	.info p .input:focus {
		box-shadow:0 0 5px 1px #ccc;
	}
	.info p .button {
		width:100%;border:0;outline:0;height:32px;color:#fff;background:#5589AB;cursor:pointer;
		border-radius:2px;box-shadow:0 0 3px #5589AB;letter-spacing:0.5px;
	}
	.info p .button:active{
		position:relative;left:1px;top:1px;
	}
	.info .table-list {
		margin:10px 0;border:1px solid #ccc;padding:5px;border-radius:2px;
		box-shadow:0 0 3px #ccc; min-height:30px;
	}
	.info .table-list span {
		display:inline-block;border:1px solid #ddd;border-radius:2px;padding:2px 3px;cursor:pointer;
		border-radius:2px;margin:3px;
	}
	.info .table-list span.checked {
		background:orange;color:#fff;border-color:orange;
	}
	
	.result {
		float:left;width:calc(100% - 460px);margin:5px 10px;
	}
	.result textarea {
		width:100%;resize:vertical;border:1px solid #ccc;border-radius:2px;background:#fff;
		font-size:14px;padding:5px;min-height:600px;box-shadow:0 0 3px #ccc;
	}
	.result textarea:focus {
		box-shadow:0 0 5px 1px #ccc;
	}
	.loading {
		position:fixed;width:100%;height:100%;top:0;left:0;background:rgba(0,0,0,0.03);display:none;
	}
	.loading svg {
		position:absolute;left:50%;top:50%;margin-left:-32px;margin-top:-32px;
	}
	.tip {
		position:fixed;right:-210px;top:20px;width:200px;height:50px;line-height:50px;
		background:#5589AB;border-radius:2px;color:#fff;padding-left:10px;
	}
</style>
</head>

<body>
<div class="main">
	<div class="info">
		<p><input class="input" type="text" name="driver" id="driver" placeholder="driver" title="driver" value="com.mysql.jdbc.Driver"></p>
		<p><input class="input" type="text" name="url" id="url" placeholder="url" title="url" value="jdbc:mysql://localhost:3306/test?characterEncoding=utf8"></p>
		<p><input class="input" type="text" name="username" id="username" placeholder="username" title="username" value="root"></p>
		<p><input class="input" type="text" name="password" id="password" placeholder="password" title="password" value="root"></p>
		<p><input type="button" value="Get Tables" class="button" id="getTables"></p>
		<div class="table-list"></div>
		<p><input type="button" value="Create ResultMap" class="button" id="createResultMap"></p>
	</div>
	<div class="result"><textarea></textarea></div>
	<div class="loading">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" width="64" height="64" fill="#5589AB">
		  <circle cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(45 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.125s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(90 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.25s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(135 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.375s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(180 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.5s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(225 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.625s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(270 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.75s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(315 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.875s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		  <circle transform="rotate(180 16 16)" cx="16" cy="3" r="0">
		    <animate attributeName="r" values="0;3;0;0" dur="1s" repeatCount="indefinite" begin="0.5s" keySplines="0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8;0.2 0.2 0.4 0.8" calcMode="spline" />
		  </circle>
		</svg>
	</div>
	<div class="tip"></div>
</div>
<script type="text/javascript" src="static/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
function initEvent() {
	$(".table-list .table").on("click", function() {
		$(this).addClass("checked").siblings(".table").removeClass("checked");
	});
}

var tip = function(msg) {
	$(".tip").html(msg).animate({right:0},200,function() {
		var self = this;
		setTimeout(function() {
			$(self).animate({right:-210}, 200);
		}, 2000);
	});
};

var getParam = function() {
	return {
		"driver":$("#driver").val(),
		"url":$("#url").val(),
		"username":$("#username").val(),
		"password":$("#password").val(),
		"tablename":$(".table.checked").attr("data-id")
	};
};

function ajax(url, type, data, dataType, successCallback) {
	$(".loading").show();
	$.ajax({
		url:url,
		type:type,
		data:data,
		dataType:dataType,
		success: successCallback,
		error:function(err) {
			console.log(err);
			$(".loading").hide();
			tip("System Error");
		}
	});
}

$("#getTables").on("click", function() {
	ajax("gettable", "get", getParam(), "json", function(data) {
		$(".table-list").empty();
		$.each(data, function() {
			$(".table-list").append('<span class="table" data-id="'+ this +'">'+ this +'</span>');
		});
		initEvent();
		$(".loading").hide();
	});
});
$("#createResultMap").on("click", function() {
	if ($(".table.checked").length == 0) {
		return;
	}
	ajax("create", "get", getParam(), "json", function(data) {
		data.msg && tip(data.msg);
		$(".result textarea").val(data.result);
		$(".loading").hide();
	});
});
</script>
</body>
</html>
