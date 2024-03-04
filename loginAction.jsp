<%@ page language='java' contentType='text/html' pageEncoding='utf-8' %> 
<%-- // java자체는 명령어가 많지 않고 import해서 명령어를 받아옴 --%>

<%-- connector파일 찾는 라이브러리 --%>
<%@ page import='java.sql.DriverManager' %>
 <%--데이터베이스에 연결하는 라이브러리  --%>
<%@ page import='java.sql.Connection' %>
 <%--sql를 전송하는 라이브러리  --%>
<%@ page import='java.sql.PreparedStatement' %>
<%-- 테이블데이터 저장하는 라이브러리, read시에 사용! --%>
<%@ page import='java.sql.ResultSet' %> 
<%-- java에서는 list가 없어서 import함 --%>
<%@ page import='java.util.ArrayList' %> 

<% 
  // jsp 작성할 수 있는 영역 
  request.setCharacterEncoding("utf-8"); 
  String idValue = request.getParameter("id_value"); //html에서 가져옴 
  String pwValue = request.getParameter("pw_value"); 

  // db통신
  Class.forName("com.mysql.jdbc.Driver"); //connector파일 찾아오는 것
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/web","stageus","1234"); //db연결
  
  // sql 작성
  String sql = "SELECT * FROM account WHERE id=? AND pw=?";
  PreparedStatement query = connect.prepareStatement(sql); // sql문을 가지고 전송할 준비하겠다 의미
  query.setString(1, idValue); // 이 값을 sql문에 집어넣겠다 의미
  query.setString(2, pwValue);


  //sql 전송
  ResultSet result = query.executeQuery(); // 3차원 느낌, 커서가 생성되고 db앞에 위치하는 개념

  result.next(); //row 한줄 읽음, row 이동할 때 반복해야함
  result.getString(1); //1번 로우 id 값 읽음
  result.getString(2); //1번 로우 pw 값 읽음
  result.getString(3); //1번 로우 name 값 읽음
  
  // 결과정제 (프론트에서 사용하기 쉽게 2차원 리스트로 편집)
// ArrayList<String> list = new ArrayList<String>();  jsp에서의 list
ArrayList<ArrayList<String>> list = new ArrayList<ArrayList<String>>(); // 2차원 리스트

while(result.next()){
ArrayList<String> data = new ArrayList<String>();
String id = result.getString(1);
String pw = result.getString(2);
String name = result.getString(3);
data.add("\"" + id + "\""); // 여기에서 string처리 하지 않으면 날데이터로 바뀌어서 날아감, 읽을 수 없어짐 , 강제적으로 큰따옴표 붙여줌
data.add("\"" + pw + "\""); // 여기 잘 기억하기!
data.add("\"" + name + "\"");
list.add(data);
}
%>

<script>
var list = <%=list%> //이건 익숙한 js list이다
console.log(list) // list변수로 따로 지정해서 console.log 사용해줌
</script>

<%-- html없이 jsp로 통신만 하는 걸 action파일이라함, 아닌 건 page파일, 그러므로 page, action폴더 구분해서 하기 --%>
