

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Serv
 */
@WebServlet("/Serv")
public class Serv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final String db_url = "jdbc:hsqldb:hsql://localhost/xdb";
	private static final String db_user = "sa";
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Serv() {
        super();
        // TODO Auto-generated constructor stub
        try {
        	loadDriver();
        } catch (Exception e) {
        	e.printStackTrace();
        }
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	       
			Statement stmt;
	        ResultSet rs;
	        ArrayList<String[]> l = new ArrayList<String[]>();
	        Connection conn;
	        
	        try {
	            conn = DriverManager.getConnection(db_url, db_user, null);
	        	stmt = conn.createStatement();
	            rs = stmt.executeQuery("SELECT * FROM accounts");
	            while (rs.next()) {
	            	String[] row = new String[3];
	            	row[0] = rs.getString("firstname");
	            	row[1] = rs.getString("lastname");
	            	row[2] = rs.getString("email");
	            	l.add(row);
	            }
	            rs.close();
	            stmt.close();
	            conn.close();
	            request.setAttribute("list", l);
	            request.getRequestDispatcher("list.jsp").forward(request, response);
	        } catch (Exception e) {
	        	response.sendRedirect("error.html");
	        }
		}

		
		private void loadDriver() {
	        try {
	                // Load the database driver
	                Class.forName("org.hsqldb.jdbcDriver");
	        } catch (Exception e) {
	                e.printStackTrace();
	                return;
	        }
		}
}
