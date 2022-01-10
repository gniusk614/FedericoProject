<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>페데리꼬 피자</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="/pederico/resources/myLib/Image/LOGO.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="resources/css/styles.css" rel="stylesheet" />
        <script src="resources/myLib/jquery-3.2.1.min.js"></script>
 	
    </head>	
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#!">FEDERICO PIZZA</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">피자</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" id="original">오리지널</a></li>
                                <li><a class="dropdown-item" >프리미엄</a></li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">사이드</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">세트</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">이벤트</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">매장찾기</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">고객게시판</a></li>
                        
                    </ul>
                    <div>로그인</div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <form class="d-flex">
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="bi-cart-fill me-1"></i>
                            Cart
                            <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                        </button>
                    </form>
                </div>
            </div>
        </nav>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">IMG 들어갈곳</h1>
                    <p class="lead fw-normal text-white-50 mb-0">silde 해서 옆으로 넘어가게</p>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">
        	<div id="result">
            &nbsp;&nbsp;각 메뉴 화면 ajax로 불러오기
            </div>
        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div>
            	<span style="color: white;">개인정보처리방침</span>&nbsp;&nbsp;
            	<span style="color: white;">제공서비스약관</span>&nbsp;&nbsp;
            	<span style="color: white;">이메일무단수집거부</span>&nbsp;&nbsp;
            	<span style="color: white;">고객센터</span>&nbsp;&nbsp;
            	<span style="color: white;">회사소개</span>&nbsp;&nbsp;
            	<span style="color: white;">
            		주문전화 0000-0000
            		온라인주문 문의 0000-0000
            	</span><br>
		        <span style="color: white;">가맹문의</span>&nbsp;&nbsp;
		        <span style="color: white;">가맹점 전용 페이지</span>&nbsp;&nbsp;
		        <a href="headoffice/loginf"><span style="color: white;">본사 전용 페이지</span></a>&nbsp;&nbsp;
            	    
            </div>
        <div><p class="m-0 text-center text-white">Copyright &copy; Your Website 2021</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="resources/js/scripts.js"></script>
    </body>
</html>

