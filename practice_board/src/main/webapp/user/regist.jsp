<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html;charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입폼</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">
	// 주소 검색
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var addr = '';
	            var extraAddr = '';

	            if (data.userSelectedType === 'R') {
	                addr = data.roadAddress;
	            } else {
	                addr = data.jibunAddress;
	            }

	            if (data.userSelectedType === 'R') {
	                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	                    extraAddr += data.bname;
	                }
	                if (data.buildingName !== '' && data.apartment === 'Y') {
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                if (extraAddr !== '') {
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                document.getElementById("extraAddress").value = extraAddr;
	            } else {
	                document.getElementById("extraAddress").value = '';
	            }

	            document.getElementById('postcode').value = data.zonecode;
	            document.getElementById("address").value = addr;
	            document.getElementById("detailAddress").focus();
	        }
	    }).open();
	}

	// 아이디 중복체크
	function idChk() {
		const id = document.querySelector("input[name=tid]").value;
		if (id == "") {
			alert("아이디를 입력하세요");
		} else {
			window.open("logincontroller.jsp?command=idchk&tid=" + id,
					    "아이디 확인", "width=300px,height=300px");
		}
	}

	// 비밀번호 확인
	function isPW(formEle) {
		if (formEle.tpassword.value != formEle.password2.value) {
			alert("비밀번호를 확인하세요");
			formEle.tpassword.value = "";
			formEle.password2.value = "";
			formEle.tpassword.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<div id="registForm" style="width:600px; margin: 100px auto;" class="form-control ml-5">
	<h1>회원가입</h1>
	<form action="logincontroller.jsp" method="post" onsubmit="return isPW(this)">
		<input type="hidden" name="command" value="insertuser" />

		<div class="row mb-3">
			<div class="col-8">
				<input class="form-control" type="text" name="tid"
					required="required" placeholder="ID" />
			</div>
			<div class="col-4">
				<button class="form-control" type="button" onclick="idChk()">중복체크</button>
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-12">
				<input class="form-control" type="text" name="tname"
					required="required" placeholder="이름" />
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-12">
				<input class="form-control" type="password" name="tpassword" required="required"
					placeholder="비밀번호" />
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-12">
				<input class="form-control" type="password" name="password2" required="required"
					placeholder="비밀번호 확인" />
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-12">
				<input name="taddress" type="text" id="postcode" placeholder="우편번호">
				<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>	
				<input name="taddress" type="text" id="address" placeholder="주소"><br>
				<input name="taddress" type="text" id="detailAddress" placeholder="상세주소">
				<input name="taddress" type="text" id="extraAddress" placeholder="참고항목">
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-12">
				<input class="form-control" type="text" name="tphone" required="required"
					placeholder="전화번호" />
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-12">
				<input class="form-control" type="email" name="temail" required="required"
					placeholder="이메일" />
			</div>
		</div>

		<div class="row mb-3">
			<div class="col-6">
				<button class="form-control btn btn-primary" type="submit">가입완료</button>
			</div>
			<div class="col-6">
				<button class="form-control btn btn-secondary" type="button" onclick="location.href='index.jsp'">메인</button>
			</div>
		</div>
	</form>
</div>
</body>
</html>
