<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<!-- ��Ʈ��Ʈ�� css ���� -->
<link href="../css/bootstrap.css?ver=1" rel="stylesheet">
<link href="../css/bootstrap-grid.css?ver=1" rel="stylesheet">
<!-- ������ -->
<script src='https://kit.fontawesome.com/a076d05399.js'></script>

<style type="text/css">
body {
	width: 1600px;
	margin: 0 auto;
}
</style>

</head>
<body>

	<div class="m-5">
			<h2 align="left">�Խñ� �ۼ�</h2>
			<form action="writePro.jsp" method="post" class="m-3">

				<table class="table table-bordered mt-4">
					<tr>
						<th width="25%" class="table-dark text-center align-middle">�ۼ���</th>
						<td width="25%">
							<input type="text" name="name" class="form-control" value="aaa" readonly>
						</td>
						<th width="25%" class="table-dark text-center align-middle">��й�ȣ</th>
						<td width="25%"><input type="password" name="passwd" class="form-control"></td>
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">����</th>
						<td colspan="3"><input type="text" name="subject" class="form-control"></td>
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">����</th>
						<td colspan="3"><textarea name="content" class="form-control" rows="13" cols="10"></textarea></td>
					</tr>
				</table>
				
				<!-- �ϴܹ�ư(�۸��, �ۼ��Ϸ�, �ۼ����) -->
				<div class="d-flex mt-4 mb-5">
					<div class="mr-auto">
						<input type="button" value="�۸��" class="btn btn-dark" onclick="location.href='notice.jsp?#wrap'">
					</div>
					
					<div class="d-flex justify-content-end">
						<input type="submit" value="�ۼ��Ϸ�" class="btn btn-dark">
						<input type="reset" value="�ۼ����" class="btn btn-dark ml-2" onclick="history.back()">
					</div>
				</div>
			</form>
		</div>

	<div class="table container">
		<div class="row">
			<div class="col-sm-3 border text-center align-middle">�ۼ���</div>
			<div class="col-sm-3 border"><input type="text" name="name" class="form-control" value="aaa" readonly></div>
			<div class="col-sm-3 border text-center align-middle">��й�ȣ</div>
			<div class="col-3 border"><input type="password" name="passwd" class="form-control"></div>
		</div>
		<div class="row">
			<div class="col-sm-3 border text-center align-middle">����</div>
			<div class="col-sm-9 border"><input type="text" name="subject" class="form-control"></div>
		</div>
		<div class="row">
			<div class="col-sm-3 border text-center align-middle">����</div>
			<div class="col-sm-9 border"><textarea name="content" class="form-control" rows="13" cols="10"></textarea></div>
		</div>
	</div>
<br><br>
</body>
</html>







