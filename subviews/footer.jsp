<%@ page pageEncoding="UTF-8"%>
	
	<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>GoCamping露營趣</title>
    <link rel="icon" href="img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/footer/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/footer/footer.css">
	</head>

<body>

    <footer class="footer-area"	style="background-color:#FFF8D7;">
    <div class="container" style="padding-top:60px;">
        <div class="row">
            <div class="col-xl-3 col-sm-6 col-md-3 col-lg-3">
                <div class="single-footer-widget footer_1" style="padding-right:50px;">
                    <h4>About Us</h4>
                    <p>台灣露營用品的專家，在這裡你可以找到任何你想要的露營用品</p>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 col-md-2 col-lg-3">
                <div class="single-footer-widget footer_2">
                    <h4>Important Link</h4>
                    <div class="contact_info" >
                        <ul>
                            <li><a href="#"> 關於我們</a></li>
                            <li><a href="#">聯絡我們</a></li>
                            <li><a href="#">購物車</a></li>
                            <li><a href="#"> 露營趣商城</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 col-md-3 col-lg-3">
                <div class="single-footer-widget footer_2">
                    <h4>Contact us</h4>
                    <div class="contact_info" style="padding-right:50px;">
                        <p><span> Address :</span>台北市松山區復興北路99號14樓 </p>
                        <p><span> Phone :</span> 02-25149191</p>
                        <p><span> Email : </span>uuu@systex.com </p>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-sm-6 col-md-4 col-lg-3">
                <div class="single-footer-widget footer_3">
                    <h4>訂閱電子報</h4>
                    <p>不想錯過任何有關露營趣的消息</p>
                    <form action="#">
                        <div class="form-group">
                            <div class="input-group mb-3" >
                                <input type="text" class="form-control"  placeholder='Email Address'
                                    onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email Address'">
                                <div class="input-group-append">
                                    <button class="btn" type="button" ><i class="fas fa-paper-plane"></i>Go</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="copyright_part_text">
            <div class="row">
                <div class="col-lg-8">
                    <p class="footer-text m-0" ><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved <i class="ti-heart" aria-hidden="true"></i> by Go Camping   
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>
           
            </div>
        </div>
    </div>
</footer>
<!-- footer part end-->
</body>