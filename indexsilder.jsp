<%@page import="java.util.List"%>
<%@page import="gocamping.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel='stylesheet' type='text/css' href='<%= request.getContextPath() %>/fancybox3/jquery.fancybox.css'>
		<title>露營趣Gocamping</title>
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous">
		</script>
		<script>
			//此處為輪播圖的function---start
			var index=1;
			$(document).ready(init);
			function init(){
 				$("#right").click(nextHandler);
				$("#left").click(prevHandler); 
 				$("#button2right").click(nextHandler2);
				$("#button2left").click(prevHandler2);				
			}
			function nextHandler(event){
				console.log('1');
 				index<5?index++:index=1;
				$("#bannerImg").attr("src","images/Banner/banner-"+index+".jpg") 
				changeGif();
			}
			function prevHandler(event){
				console.log('2');
 				index>1?index--:index=5;
				$("#bannerImg").attr("src","images/Banner/banner-"+index+".jpg");
				changeGif();
			}
			function changeGif(){
				$(".poster img:eq("+(index-1)+")").fadeIn(300);
				$(".poster img:gt("+(index-1)+")").fadeOut(300);
			}
 			setInterval(run, 4000)
			function run(){
 				nextHandler();
			}
 			//此處為輪播圖的function---end
 			</script> 
 
		<style>
		.outer{
			height: 45vh;
			width: 100%;
			/*max-width: 80vw;*/
			/*margin: auto;*/
			/*display: inline-block;*/
			/*position: absolute;*/
			
		}
		.button,.poster{
			height: 100%;
			width: 15%;
			display: inline-flex;
			flex-direction:row;
			justify-content: center;
			overflow:hidden;

			
		}
		.button{
			display: flex;
			align-items: center;
			font-size: 50px;
			cursor:pointer; /*滑鼠滑到該div上會變手型*/
			font-family: arial,"Microsoft JhengHei","微軟正黑體",sans-serif;
			color:#FFED97;
		}
		.button:hover{/*滑鼠滑到處發*/
			 background-color: white;/*觸發改變背景顏色*/
			
		}		
		.poster {
			height: 400px;
			width: 1000px;
			/*height:100%;*/
			position: relative;
			left:50px;
			right:50px;
			
		}
		.poster img {
			width:100%;
			height:100%;
			border-radius:20px;
		}
		

		</style>
	</head>
	
	<body>

		
		<article>
		
			<div class='outer'>
				<div class='button' id='left' style='float:left'>
					<span><</span>					
				</div>
				<div class='poster'>
					<img id='bannerImg' src='images/Banner/banner-1.jpg'>
				</div>
				<div class='button' id='right' style='float:right'>
					<span>></span>						
				</div>
			</div>
			
		</article>
		
	
	</body>
</html>