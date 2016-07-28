<HTML>
<HEAD><TITLE>ACS Cloud Demo</TITLE></HEAD>

<BODY>

<%@ page import="java.sql.*,javax.naming.*,javax.sql.*" %>
<FONT SIZE="5" COLOR="navy">
<table>
<tr><td><CENTER><b>JODizzyworld Singapore Center</b></CENTER></td></tr>
</table>


<FORM NAME="testCP" ACTION="testdatasource.jsp" METHOD="POST">
<TABLE WIDTH="50%" ALIGN="left" BGCOLOR="red">
	<TR><TD ALIGN="right" WIDTH="50%">Data Source Name</TD>
		<TD WIDTH="50%"><INPUT TYPE="text" NAME="txtDataSource" VALUE="dizzyworldDS"></TD>
	</TR>
	<TR><TD ALIGN="right">Table Name</TD>
		<TD><INPUT TYPE="text" NAME="txtTableName" VALUE="EMPLOYEE"></TD>
	</TR>
	<TR><TD ALIGN="right">Username</TD>
		<TD><INPUT TYPE="text" NAME="txtUsername" VALUE="system"></TD>
	</TR>
	<TR><TD ALIGN="right">Password</TD>
		<TD><INPUT TYPE="text" NAME="txtPassword" VALUE="weblogic"></TD>
	</TR>
	<TR><TD ALIGN="center" COLSPAN="2">
			<INPUT TYPE="submit" NAME="btnSubmit" VALUE="Query Data">
		</TD>
	</TR>
	
</TABLE>
</FORM>


<%
	String datasource = request.getParameter("txtDataSource");
	String table = request.getParameter("txtTableName");
	String username = request.getParameter("txtUsername");
	String password = request.getParameter("txtPassword");

	if ((datasource != null) && (!datasource.equals(""))) {
		if ((table != null) && (!table.equals(""))) {
			try {

				InitialContext ic = new InitialContext();
				DataSource ds = (DataSource) ic.lookup(datasource);
				System.out.println("Looking up the " + datasource + " data source.");
				Connection connection = ds.getConnection(username, password);
				System.out.println("Getting the connection from the database.");

				Statement statement = connection.createStatement();
				String sql = "SELECT * FROM " + table + " where COUNTRY_ID='SG'";

				ResultSet rs = statement.executeQuery(sql);
				System.out.println("Querying the database.");
				ResultSetMetaData meta = rs.getMetaData();
				int numColumns = meta.getColumnCount();
%>
				
				<BR>
				<BR>
				<BR>
				<BR>
				<BR>
				<BR>
				<p>
				<TABLE WIDTH="1000" BGCOLOR="white" ALIGN="left">
				
<%
				out.print("<TR>");
				
				for (int j=1; j<=numColumns; j++) {
					out.print("<TH>" + meta.getColumnName(j) + "</TH>");
				}
				out.print("</TR>");
				while (rs.next()) {
					out.print("<TR>");
					for (int i=1; i<=numColumns; i++) {
						out.print("<TD>" + rs.getString(i) + "</TD>");
					}
					out.print("</TR>");
				}
%>
				</TABLE>
				</p>
<%
				if (statement != null)
					statement.close();
				if (connection != null)
					connection.close();

			} catch (SQLException sqle) {
%>

				</FONT><FONT SIZE="4" COLOR="navy">
				Error: <%= sqle.getMessage() %><BR><BR>
<%
			}catch (Exception e) {out.print("error: " + e); }

		}
	}


%>
</FONT>


<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<p>
</p>

</BODY>
</HTML>