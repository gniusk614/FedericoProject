<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
<script src="/federico/resources/ckeditor/ckeditor.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
<style>
.checked {
	border-bottom: 2px solid black;
	color: black;
}

.checked .a {
	font-size: large;
	color: gray;
}

.my.pagination > .active > a, 
.my.pagination > .active > span, 
.my.pagination > .active > a:hover, 
.my.pagination > .active > span:hover, 
.my.pagination > .active > a:focus, 
.my.pagination > .active > span:focus {
  background: crimson;
  border-color: crimson;
}
tbody tr {
    cursor: pointer;
}


</style>
<script>
	//Search 이벤트 -> makequery 메서드 사용하기위해 jsp파일에 배치
	$(
			function() {
				// SearchType 이 '---' 면 keyword 클리어
				$('#searchType').change(function() {
					$('#keyword').val('');
				}); //change
				// 검색후 요청
				$('#searchBtn').on( "click", function() {
							self.location = "cscenterf"
									+ "${pageMaker.makeQuery(1)}"
									+ "&searchType=" + $('#searchType').val()
									+ '&keyword=' + $('#keyword').val()
						}); //on_click 

			}) //ready
</script>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	<!-- 본문 시작 -->
	<section class="container py-5"
		style="height: auto; min-height: 100%; padding-bottom: 168px;">
		<fmt:parseNumber value="${now.time/(1000*60*60*24)}" integerOnly="true" var="now"></fmt:parseNumber>
		
		<div class="container-fluid">
			<div class="row mb-5">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">고객센터</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row justify-content-md-center" style="height: 50px;">
				<div id="csNotice" class="col-sm-4 checked" align="center"
					style="font-size: large; color: black; border-bottom: 2px solid black; cursor: pointer;"
					onclick="clickEffect('csNotice'); showCsDiv('csNotice');">
					공지사항</div>
				<div id="csComp" class="col-sm-4 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('csComp'); showCsDiv('csComp');">
					고객의소리</div>
			</div>
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 공지사항 -->
				<div id="csNoticeBoard" class="container" style="display: block;">
					<div class="row justify-content-md-center mt-1 py-5">
					
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="container-fluid px-0">
									<div class="row">
										<div class="col-sm-2">
											<select name="searchType" id="searchType" class="form-select">
												<option value="none"
													<c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>>- -</option>
												<option value="title"
													<c:out value="${pageMaker.cri.searchType=='title' ? 'selected':''}"/>>제목</option>
												<option value="content"
													<c:out value="${pageMaker.cri.searchType=='content' ? 'selected':''}"/>>내용</option>
												<option value="titleContent"
													<c:out value="${pageMaker.cri.searchType=='titleContent' ? 'selected':''}"/>>제목+내용</option>
											</select>
										</div>
										<div class="col-sm-3">
												<input class="form-control mr-1" type="search" id="keyword" placeholder="Search" value="${pageMaker.cri.keyword}">
										</div>
										<div class="col-sm-6">
											<button id="searchBtn" class="btn btn-outline-danger">검색</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row mb-3">
							<div class="col lead px-3" style="font-size: medium;">
							검색결과 <b style="color: crimson;">${pageMaker.totalRowCount}</b>개
							</div>
							</div>
							<div class="dataTable-container" style="font-size:medium; border-top: 1px solid black;">
								<table id="table_id" class="table table-striped table-hover">
									<thead>
										<tr align="center" style="height: 50px; vertical-align:middle;">
											<th scope="col" style="width: 100px;">번호</th>
											<th scope="col" style="width: 500px;">제목</th>
											<th scope="col" style="width: 200px;">날짜</th>
											<th scope="col" style="width: 100px;">조회수</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${! empty message }">
											<tr>
												<td colspan="6" class="fw-bold fs-5">${message}</td>
											</tr>
										</c:if>
										
										<c:forEach var="noticeList" items="${noticeList}">
											<tr onclick="javascript:location.href='csNoticeDetail?seq=${noticeList.seq}'" style="vertical-align:middle; height: 50px; background-color:Gainsboro;" align="left">
												<td align="center"><b style="color: crimson;">공지</b></td>
												
												<fmt:parseDate var="regdate" value="${noticeList.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
												<fmt:formatDate value="${regdate}" var="regdateFormat" pattern="yyyy-MM-dd"/>
												<fmt:parseNumber value="${regdate.time/(1000*60*60*24)}" integerOnly="true" var="regdateTime"></fmt:parseNumber>
												
												<td>${noticeList.title}
												<c:if test="${now-regdateTime<7}">
												<b style="font-size:small; color:crimson;">NEW </b></c:if>
												</td>
												<td align="center">${regdateFormat} </td>
												<td align="center">${noticeList.cnt}</td>
											</tr>
										</c:forEach>
										<c:forEach var="list" items="${boardList}">
											<tr onclick="javascript:location.href='csNoticeDetail?seq=${list.seq}'" style="vertical-align:middle; height: 50px;">
												<td align="center">${list.seq}</td>
												
												<fmt:parseDate var="regdate" value="${list.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
												<fmt:formatDate value="${regdate}" var="regdateFormat" pattern="yyyy-MM-dd"/>
												<fmt:parseNumber value="${regdate.time/(1000*60*60*24)}" integerOnly="true" var="regdateTime"></fmt:parseNumber>
												
												<td>${list.title}
												<c:if test="${now-regdateTime<7}">
												<b style="font-size:small; color: crimson;">NEW</b></c:if>
												</td> 

												<td align="center">${regdateFormat}</td>
												<td align="center">${list.cnt}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="dataTable-bottom">
								<nav class="dataTable-pagination">
									<ul class="pagination my">
										<c:if test="${pageMaker.prev}">
											<li class="page-item"><a class="page-link"
												href="cscenterf${pageMaker.searchQuery(pageMaker.spageNo-1)}"
												aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										<c:if test="${! pageMaker.prev}">
											<li class="page-item disabled"><a class="page-link"
												aria-label="Previous"> <span aria-hidden=true>&laquo;</span>
											</a></li>
										</c:if>
										<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
											<c:if test="${i==pageMaker.cri.currPage}">
												<li class="page-item active" aria-current="page"><a
													class="page-link">${i}</a></li>
											</c:if>
											<c:if test="${i!=pageMaker.cri.currPage}">
												<li class="page-item"><a href="cscenterf${pageMaker.searchQuery(i)}">${i}</a></li>
											</c:if>
										</c:forEach>
										<c:if test="${pageMaker.next}">
											<li class="page-item"><a class="page-link"
												href="cscenterf${pageMaker.searchQuery(pageMaker.epageNo+1)}"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
										<c:if test="${! pageMaker.next}">
											<li class="page-item disabled"><a class="page-link"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
					</div>
				</div>

		<!-- 고객의 소리 -->
		<div id="csCompForm" class="container" style="display: none;">
			<div class="row mt-5 mb-2">
				<p style="color: gray;">페데리코피자는 정당한 소비자피해에 대해 공정거래위원회에서 고시한
					소비자분쟁해결 기준에 의거하여 처리합니다.
				<p>
				<hr>
			</div>
			<div class="row">
				<div class="row justify-content-md-center mt-5 mb-5">
					<div class="col-7" align="center">
						<form action="complainInsert" method="post">
							<div class="row justify-content-md-center mt-2"
								style="height: 1000px;">
								<div class="col">
									<div class="row mb-3" style="font-size: large;" align="left"><b>고객정보</b></div>
									<input class="form-control mb-3" type="text" id="clientName"
										name="clientName" placeholder="고객명을 입력하세요." /> <input
										class="form-control mb-3" id="clientPhone"
										oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
										name="clientPhone" type="text" placeholder="핸드폰번호" />
									<div class="input-group mb-1">
										<input type="text" class="form-control " id="inputEmail"
											placeholder="이메일"> <span class="input-group-text ">@</span>
										<input id="emailServer" type="text" class="form-control "
											value="naver.com" readonly="readonly"> <select
											class="form-select " id="selectServer">
											<option selected value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="gmail.com">gmail.com</option>
											<option value="nate.com">nate.com</option>
											<option value="etc">직접입력</option>
										</select>
									</div>
									<div style="font-size: small;" align="left">입력하신 이메일 주소로
										답변이 발송됩니다.</div>

									<div class="row">
										<div class="row mt-4 mb-3" style="font-size: large;" align="left"><b>이용매장</b></div>
										<div class="input-group mb-1">
											<select id="head" name="head" class="form-select"
												style="width: 200px; display: inline;">
												<option value="칭찬">칭찬합니다.</option>
												<option value="불만">불만이에요.</option>
											</select> <select id="selectarea" class="form-select"
												style="width: 200px; display: inline;"
												onchange="selectArea()">
												<option value="default" selected>지역</option>
												<option value="서울">서울</option>
												<option value="경기">경기</option>
												<option value="인천">인천</option>
												<option value="대전">대전</option>
												<option value="부산">부산</option>
												<option value="대구">대구</option>
												<option value="울산">울산</option>
												<option value="세종">세종</option>
												<option value="광주">광주</option>
												<option value="강원">강원</option>
												<option value="충북">충북</option>
												<option value="충남">충남</option>
												<option value="경북">경북</option>
												<option value="경남">경남</option>
												<option value="전북">전북</option>
												<option value="전남">전남</option>
												<option value="제주">제주</option>
											</select> <select id="selectFranchise" class="form-select" name="fcId"
												style="width: 200px; display: inline;" onchange="selectFc()">
												<option></option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="row mt-4 mb-3" style="font-size: large;"
											align="left"><b>고객의 소리</b></div>
										<div class="col mb-3">
											<input class="form-control mb-3" type="text"
												id="title" name="title" placeholder="제목" />
											<textarea class="form-control mb-3" style="resize: none; height:300px; " id="textcontent"
												 name="content" placeholder="내용 2000자 이내">
											</textarea>
											
											<textarea class="form-control mb-3" style="resize: none; height:300px; " id="content"
												 name="content" hidden="hidden">
											</textarea>
											
										</div>
									</div>
									<div class="row">
										<div class="col-8 align-self-center" align="left"
											onclick="checkboxCheck()" style="cursor: pointer;">
											<i class="bi bi-check-circle danger checkbox_no"
												style="color: crimson;"></i> <i
												class="bi bi-check-circle-fill danger checkbox_yes"
												style="color: crimson; display: none;"></i> <span
												class="align-middle" style="font-size: medium;">개인정보
												수집/이용동의(필수)</span>
										</div>
										<div class="col-4" align="right">
											<a class="small" href="javascript:;" onclick="showAgreeModal()"
												style="color: Crimson; font-size: medium;">내용보기 ></a>
										</div>
									</div>
									<div class="row">
									<div class="col mt-3" align="left">
									<p style="font-size: small; color: gray;">
‧ 본사 유선 접수 02-0000-0000 (내선번호 : 고객 관련 문의 2번 / 마케팅 문의 3번 / 전산 시스템 문의 8번 )<br>
‧ 상담가능시간 09:00 ~ 17:00 (주말/공휴일 휴무)<br>
‧ 이메일 문의 gniusk614@nate.com<br>
‧ 온라인 주문 취소 및 문의 : 070-0000-0000 (운영 시간 – 매일 11:00~23:00)</p></div>
									</div>
								</div>
							</div>
							<div class="row" style="height: 100px;">
								<input type="text" id="clientEmail" name="clientEmail" hidden="hidden">
								<div
									class="d-flex align-items-center justify-content-between mb-0">
									<button class="btn btn-secondary" type="reset"
										style="width: 50%; height: 60px; font-size: large;">취소</button>&nbsp;&nbsp;&nbsp;&nbsp;
									<button class="btn btn-danger" type="submit"
										onclick="return complainInsert()"
										style="width: 50%; height: 60px; font-size: large;">등록</button>
										
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- footer include -->
	<%-- <%@ include file="footer.jsp"%> --%>

	<!-- 개인정보처리방침 모달  -->
	<div class="modal fade" id="agreeModal" role="dialog">
		<div class="modal-dialog"
			style="max-width: 50%; width: auto; ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
					<i class="bi bi-person-check"></i>
					개인정보 처리방침</h5>
					<button type="button" class="btn-close infoClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-body" style="overflow: auto; height: 500px;">
							<pre>
'(주)페데리코에프앤씨'는 (이하 '회사'는) 
고객님의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호"에 관한 법률을 준수하고 있습니다. 
						
회사는 개인정보처리방침을 통하여 고객님께서 제공하시는 개인정보가 어떠한 용도와 방식으로
이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다. 
						
회사는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다. 
						
■ 수집하는 개인정보 항목 
						
① 회사는 회원가입, 상담, 서비스 제공 등을 위해 아래와 같은 개인정보를 수집하고 있습니다. 
가. 성명 , 로그인ID , 비밀번호 , 생년월일 , 성별 , 자택 주소 , 휴대전화번호 , 이메일, 접속 로그 , 접속 IP 정보 
나. 서비스 이용 과정에서 아래와 같은 정보들이 자동 수집될 수 있습니다. 
-접속 IP 정보, 쿠키, 방문 일시, OS종류, 브라우저 종류, 위치정보, 카드번호 
② 개인정보 수집방법 가. 온라인 주문, 전화, 채용, 가맹문의, 이벤트 및 프로모션 응모 

■ 개인정보의 수집 및 이용목적 

① 회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다. 
가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 및 콘텐츠 제공 
나. 회원 관리 가) 회원제 서비스 이용에 따른 본인확인 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입의사 확인 , 불만처리 등 민원처리 , 고지사항 전달 
다. 채용
가) 상시 및 비상시 채용 
라. 가맹문의 
가) 가맹문의에 따른 개설 상담 
마. 통계 및 마케팅 광고에 활용 
가) 접속빈도 파악 등에 관한 통계 
나) 이벤트 등 광고성 정보 제공 

■ 개인정보의 보유 및 이용기간 

원칙적으로 회사는 개인정보의 수집 및 이용목적이 달성된 후 지체 없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우
회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. 

1. 관련법령에 의한 정보보유 사유 
① 계약 또는 청약철회 등에 관한 기록 
- 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률 
- 보존 기간 : 5년
② 대금결제 및 재화 등의 공급에 관한 기록 
- 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률 
- 보존 기간 : 5년 ③ 소비자의 불만 또는 분쟁처리에 관한 기록 
- 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률 
- 보존 기간 : 3년 ④ 본인 확인에 관한 기록 
- 보존 근거 : 정보통신망 이용촉진 및 정보보호 등에 관한 법률 
- 보존 기간 : 3개월 ⑤ 웹사이트 방문기록 
- 보존 근거 : 통신비밀보호법 
- 보존 기간 : 3개월 ⑥ 개인위치정보에 관한 기록 
- 보존 근거 : 위치정보의 보호 및 이용 등에 관한 법률 
- 보존 기간 : 1년 
						
■ 개인정보 제3자 제공
회사는 이용자의 개인정보를 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정에 해당하는 경우에만
개인정보를 제3자에게 제공합니다.
						
■ 수집한 개인정보의 위탁 
① 회사는 서비스 향상을 위해서 아래와 같이 개인정보를
위탁하고 있으며, 관계 법령에 따라 위탁업무 수행 목적 외 개인정보 처리 금지, 기술적 ∙ 관리적 보호조치, 재 위탁
제한, 수탁자에 대한 관리 ∙ 감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를
안전하게 처리하는지를 감독하고 있습니다. 회사의 개인정보 위탁처리 기관 및 위탁업무 내용은 아래와 같습니다.</pre>
							<table>
								<colgroup>
									<col style="width: 25%;">
									<col style="width: 25%;">
									<col style="width: 25%;">
									<col style="width: 25%;">
								</colgroup>
								<thead style="border-bottom : 3px solid black;">
									<tr>
										<th style="text-align: center;">수탁 업체명</th>
										<th style="text-align: center;">위탁 업무
											내용</th>
										<th style="text-align: center;">개인정보의
											보유 및 이용기간</th>
										<th style="text-align: center;">취급
											개인정보</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>㈜씨엔티테크</td>
										<td>홈페이지 및 모바일 채널 운영 지원 주문 중개 및 서버 인프라
											운영, 콜센터 주문 서비스 제공, 고객 상담 지원 및 매장 주문처리</td>
										<td>회원 탈퇴 혹은 위탁 계약 종료 시 까지</td>
										<td>성명, 로그인ID, 비밀번호, 생년월일, 성별, 주소,
											휴대전화번호, 이메일</td>
									</tr>
									<tr>
										<td>㈜KG 이니시스</td>
										<td>결제처리(신용카드)</td>
										<td>회원 탈퇴 혹은 위탁 계약 종료 시 까지</td>
										<td>신용카드정보</td>
									</tr>
									<tr>
										<td>㈜모빌리언스</td>
										<td>휴대전화 본인인증</td>
										<td>수집목적을 달성시 까지</td>
										<td>성명, 생년월일, 성별, 휴대전화번호</td>
									</tr>
									<tr>
										<td>버킷스튜디오</td>
										<td>비회원 인증, 문자 발송</td>
										<td>수집목적을 달성시 까지</td>
										<td>휴대전화번호</td>
									</tr>
									<tr>
										<td>처음소프트</td>
										<td>이메일 발송</td>
										<td>수집목적을 달성시 까지</td>
										<td>성명, 이메일</td>
									</tr>
									<tr>
										<td>㈜푸드테크</td>
										<td>POS 시스템 운영</td>
										<td>수집목적을 달성시 까지</td>
										<td>주소, 전화번호</td>
									</tr>
									<tr>
										<td>가맹점사업자</td>
										<td>가맹점사업자의 영업지역에 속한 주소지 회원에 대한 배달서비스
											제공</td>
										<td>수집목적을 달성시 까지</td>
										<td>주소, 전화번호</td>
									</tr>
								</tbody>
							</table>
							<pre>
② 위탁 업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다. 

■ 개인정보의 파기절차 및 방법 

회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다. 

① 파기절차 
회원님이 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에
따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어집니다. 
별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다. 

② 파기방법 
- 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다. 
개인정보의 분리보관 회원가입 시 고객이 선택한 개인정보 이용기간동안 회사 홈페이지 미접속 시 근거법령에 의거 다른 이용자의 개인정보와 분리보관 됩니다. 

■ 이용자의 권리와 그 행사방법 
이용자는 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 가입해지를 요청할 수도 있습니다. 
이용자의 개인정보 조회 및 수정을 위해서는 ‘개인정보변경’(또는 ‘회원정보수정’ 등)을 클릭하여 본인 확인
절차를 거치신 후 직접 열람, 정정이 가능합니다. 
또한 가입해지(동의철회)를 위해서는 본 페이지 하단의 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다. 
귀하가 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를
제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다. 
‘회사’는 이용자 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보는 “‘회사’ 가 수집하는 개인정보의 보유 및
이용기간”에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다. 

■ 개인정보의 안전성 확보조치 
회사는 개인정보의 안전성 확보를 위해 개인정보보호법 시행령 제30조 제1항에 따른 조치 및 다음과 같은 조치를 취하고 있습니다. 

1. 기술적 대책 
① 회사는 이용자의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안정성 확보를 위하여 다음과 같은 기술적 대책을 강구하고 있습니다. 
② 이용자의 개인정보는 비밀번호에 의해 보호되며, 파일 및 전송 데이터를 암호화 하고 있습니다. 
③ 회사는 암호알고리즘을 이용하여 네트워크 상의 개인정보를 안전하게 전송할 수 있는 보안장치(SSL, VPN)를 채택하고 있습니다.
④ 해킹 등 외부 침입에 대비하여 각 서버마다 방화벽 등을 이용하여 보안에 만전을 기하고 있습니다. 

2. 관리적 대책 
① 회사는 이용자의 개인정보에 대한 접근권한을 최소한의 인원으로 제한하고 있습니다. 그 최소한의 인원에 해당하는 자는 다음과 같습니다. 
- 이용자를 직접 상대로 하여 마케팅 업무를 수행하는 자 
- 개인정보보호책임자 및 담당자 등 개인정보관리업무를 수행하는 자
- 기타 업무상 개인정보의 취급이 불가피한 자 
② 회사는 개인정보의 안전성 확보를 위해 내부관리계획을 수립하여 시행하며, 임직원 등에 대한 정기적인 교육을 시행하고 있습니다. 

3. 물리적 대책 
① 회사는 개인정보를 보관할 수 있는 별도의 보관장소 를 두고 있는 경우, 그 출입을 통제하고 있습니다. 
② 회사는 개인정보가 포함된 서류, 보조저장매체 등이 있는 경우 잠금 장치를 하여 보관하고 있습니다. 

■ 아동의 개인정보보호 회사는 만14세 미만 아동의 개인정보를
보호하기 위하여 회원가입은 만14세 이상만 가능하도록 하여 아동의 개인정보를 수집하지 않습니다. 

■ 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항 회사는 이용자 개개인에게 개인화되고 맞춤화된 서비스를 제공하기 위해
이용자의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)'를 사용합니다. 

① 쿠키의 사용 목적 
회원과 비회원의 접속 빈도나 방문 시간 등의 분석, 이용자의 취향과 관심분야의 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문
회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서 비스 제공 
② 쿠키 설정 거부 방법 
이용자는 쿠키 설치에 대해 거부할 수 있습니다. 단, 쿠키 설치를 거부하였을 경우 로그인이 필요한 일부 서비스의 이용이 어려울 수 있습니다.
(설정방법, IE 기준)웹 브라우저 상단의 도구 &gt; 인터넷 옵션 &gt; 개인정보 &gt; 사이트 차단 

■ 고지의 의무 현 개인정보처리방침 내용 추가, 삭제 및 수정이 있을 시에는 개정 최소 7일전부터 홈페이지 또는 이메일을 통해
고지할 것입니다. 

- 공고일자 : 2021년 12월 27일 
- 시행일자 : 2022년 01월 01일 

■ 개인정보에 관한 민원서비스 
회사는 고객의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보관리책임자를 지정하고 있습니다. 

개인정보보호책임자 성명 : 강광훈 차장 
전화번호 : 000-0000-0000
이메일 : kkh@federico.co.kr 

귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련
민원을 개인정보 관리책임자 혹은 담당부서로 신고하실 수 있습니다. 회사는 이용자들의 신고사항에 대해 신속 하게 충분한
답변을 드릴 것입니다. 기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.

1.개인분쟁조정위원회 (www.1336.or.kr/1336) 
2.정보보호마크인증위원회 (www.eprivacy.or.kr/02-580-0533~4) 
3.대검찰청 인터넷범죄수사센터 (http://icic.sppo.go.kr/02-3480-3600) 
4.경찰청 사이버테러대응센터 (www.ctrc.go.kr/02-392-0330) 
ο 본 방침은 : 2022 년 1월 1일 부터 시행됩니다.
						</pre>
						</div>

					</div>
					<div class="modal-footer">
						<div class="container-fluid">
							<div class="row">
								<button type="button" class="btn btn-secondary infoClose"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
 var ckeditor_config = {
   removePlugins : 'resize',
   resize_enabled : false,
   height: 300,
   enterMode : CKEDITOR.ENTER_BR,
   shiftEnterMode : CKEDITOR.ENTER_P,
   filebrowserUploadUrl : "/federico/headoffice/boardImageUpload",
   extraPlugins: 'wordcount'
 };
 
 CKEDITOR.replace("textcontent", ckeditor_config);
 var value = "";
 CKEDITOR.instances['textcontent'].on('key', function () {
	value =CKEDITOR.instances['textcontent'].getData();
	
	console.log(value)
	 if(CKEDITOR.instances['textcontent'].document.getBody().getText().length>400){
		 alert('400자 이상 작성할 수 없습니다.')
	 }
	});
		
	</script>
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>