<%@ page language='java' contentType='text/html' pageEncoding='utf-8' %> 
<%-- // java자체는 명령어가 많지 않고 import해서 명령어를 받아옴 --%>

<%-- connector파일 찾는 라이브러리 --%>
<%@ page import='java.sql.DriverManager' %>
 <%--데이터베이스에 연결하는 라이브러리  --%>
<%@ page import='java.sql.Connection' %>
 <%--sql를 전송하는 라이브러리  --%>
<%@ page import='java.sql.PreparedStatement' %> 

<% 
  // jsp 작성할 수 있는 영역 
  request.setCharacterEncoding("utf-8"); 
  String idValue = request.getParameter("id_value"); //html에서 가져옴 
  String pwValue = request.getParameter("pw_value"); 
  String nameValue = request.getParameter("name_value"); 

  // db통신
  Class.forName("com.mysql.jdbc.Driver"); //connector파일 찾아오는 것
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db연결
  
  // sql 작성
  String sql = "INSERT INTO account (id, pw, name) VALUES (?, ?, ?)";
  PreparedStatement query = connect.prepareStatement(sql); // sql문을 가지고 전송할 준비하겠다 의미
  query.setString(1, idValue); // 이 값을 sql문에 집어넣겠다 의미
  query.setString(2, pwValue);
  query.setString(3, nameValue);

  //sql 전송
  query.executeUpdate();
  
  // 결과정제 
%>

<script>
  alert('회원가입 성공!')
  location.href = 'index.html'
</script>