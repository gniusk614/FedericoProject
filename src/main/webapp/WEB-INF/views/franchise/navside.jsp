<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>

	<!-- 사이드네비바 -->

	<div id="layoutSidenav_nav">

		<nav class="sb-sidenav accordion sb-sidenav-dark bg-success"
			id="sidenavAccordion">
			<div class="sb-sidenav-menu">
				<div class="nav">

					<!-- 메인 대쉬보드 -->
					<a class="nav-link" href="login?home=home"> 
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
  								<path fill-rule="evenodd"
								d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z" />
 							 <path fill-rule="evenodd"
								d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z" />
							</svg> &nbsp; 메인 대쉬보드
					</a>
					<!-- 메인 대쉬보드 -->

					<!-- 주문관리 -->
					<hr class="dropdown-divider" />
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts1" aria-expanded="false"
						aria-controls="collapseLayouts1">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 주문관리
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts1"
						aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="completeorder">완료주문조회</a>
						</nav>
					</div>
					

					<!-- 자재,발주관리 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts2" aria-expanded="false"
						aria-controls="collapseLayouts2">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 자재 • 발주관리
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>

					<div class="collapse" id="collapseLayouts2"
						aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="selectfcorder">발주내역조회</a> 
							<a class="nav-link" href="itemorderf">발주신청</a> 
						</nav>
					</div>
					

					<!-- 정산하기 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts3" aria-expanded="false"
						aria-controls="collapseLayouts3">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 정산하기
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts3"
						aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="fcorder?flag=N">매출내역조회</a>
						</nav>
					</div>

					<!-- 고객관리 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts4" aria-expanded="false"
						aria-controls="collapseLayouts4">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 고객관리
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts4"
						aria-labelledby="headingFour" data-bs-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="fcclientregf">고객리스트</a>
						</nav>
					</div>
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