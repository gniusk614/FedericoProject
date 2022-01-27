<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Federico Company</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
<style>
a:visited {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: black;
}

a {
	color: black;
	text-decoration: none;
}
</style>

</head>
<body>
	<%@ include file="navtop.jsp"%>
	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>

		<div id="layoutSidenav_content">
			<div class="container-fluid px-4" style="margin-top: 20px;">
				<div class="col-10">
					<div class="card">
						<div class="card-header">
							<button class="btn btn-primary" onclick="showChart('month')">
								월별 총 매출</button>
							<button class="btn btn-primary" onclick="showChart('day')">
								요일별 총 매출</button>
							<button class="btn btn-primary" onclick="">
								메뉴별 총 매출</button>
							<button class="btn btn-primary" onclick="">
								연령별 선호메뉴</button>
							<button class="btn btn-primary" onclick="">
								지역별 선호메뉴</button>
						</div>
						<div class="card-body">
							<div class="container-fluid px-4">
								<div class="row">
									<canvas id="monthChart" class="chartCanvas" width="500" height="400"></canvas>
									<canvas id="dayChart" class="chartCanvas" width="500" height="400"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer inlcud -->
	<div><%@ include file="footer.jsp"%></div>
	<!-- 본문 끝 -->
	<!-- layoutSidenav 끝 -->







	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>

	<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>