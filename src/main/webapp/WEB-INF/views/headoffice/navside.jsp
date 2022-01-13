<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>

	<!-- 사이드네비바 -->

	<div id="layoutSidenav_nav">

		<nav class="sb-sidenav accordion sb-sidenav-dark"
			id="sidenavAccordion">
			<div class="sb-sidenav-menu">
				<div class="nav">

					<!-- 메인 대쉬보드 -->
					<a class="nav-link" href="headofficeMain"> <!-- 새로고침 아니고 메인페이지로 이동(광훈 / 1.11)  -->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
  								<path fill-rule="evenodd"
								d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z" />
 							 <path fill-rule="evenodd"
								d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z" />
							</svg> &nbsp; 메인 대쉬보드
					</a>
					<!-- 메인 대쉬보드 -->


					<hr class="dropdown-divider" />
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts1" aria-expanded="false"
						aria-controls="collapseLayouts1">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 직원계정관리
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts1"
						aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="staffList">직원계정 조회</a>
						</nav>
					</div>
					<!-- 직원계정조회 -->

					<!-- 가맹점관리 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts2" aria-expanded="false"
						aria-controls="collapseLayouts2">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 가맹점관리
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>

					<div class="collapse" id="collapseLayouts2"
						aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="layout-static.html">가맹점 정보</a> <a
								class="nav-link" href="layout-sidenav-light.html">미처리 발주내역</a> <a
								class="nav-link" href="layout-sidenav-light.html">처리완료 발주내역</a>
						</nav>
					</div>
					<!-- 가맹점관리 -->

					<!-- 자재,발주관리 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts3" aria-expanded="false"
						aria-controls="collapseLayouts3">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 자재 • 발주관리
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts3"
						aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="layout-static.html">미처리 발주내역</a> <a
								class="nav-link" href="layout-sidenav-light.html">처리완료 발주내역</a>
							<a class="nav-link" href="itemselect">자재조회 및 등록</a>
						</nav>
					</div>
					<!-- 자재,발주관리 -->

					<!-- 소비자 페이지관리 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts4" aria-expanded="false"
						aria-controls="collapseLayouts4">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 소비자 페이지관리
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts4"
						aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="layout-static.html">메뉴조회</a> <a
								class="nav-link" href="layout-sidenav-light.html">메뉴등록</a> <a
								class="nav-link" href="layout-sidenav-light.html">이벤트게시판</a> <a
								class="nav-link" href="layout-sidenav-light.html">고객의 소리</a>
						</nav>
					</div>
					<!-- 소비자 페이지관리 -->

					<!-- 각종 통계 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts5" aria-expanded="false"
						aria-controls="collapseLayouts5">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 통계
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts5"
						aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="layout-static.html">각종 통계</a>
						</nav>
					</div>
					<!-- 각종 통계 -->
				</div>
			</div>

			<!-- 사이드네비 하단 -->
			<div class="sb-sidenav-footer">
				<div class="small">Logged in as:</div>
				Start Bootstrap
			</div>
			<!-- 사이드네비 하단 -->
		</nav>

	</div>

</body>
</html>