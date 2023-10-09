package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Bb0DAO {
	
	private Connection conn;
	private ResultSet rs;

	//DB Info
	public Bb0DAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");		
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//Get Date
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB error
	}
	//Get Next Number
	public int getNext() {
		String SQL = "SELECT bb0_ID FROM BB0 ORDER BY bb0_ID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // Case : First Content
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB error
	}
	// Write
	public int write(String bb0_Title, String userID, String bb0_Content) {
		String SQL = "INSERT INTO BB0 VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bb0_Title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bb0_Content);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB error
	}
	//Get Content List	
	public ArrayList<Bb0> getList(int pageNumber){
		String SQL = "SELECT * FROM BB0 WHERE bb0_ID < ? AND bb0_Available = 1 ORDER BY bb0_ID DESC LIMIT 10";
		ArrayList<Bb0> list = new ArrayList<Bb0>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bb0 bb0 = new Bb0();
				bb0.setBb0_ID(rs.getInt(1));
				bb0.setBb0_Title(rs.getString(2));
				bb0.setUserID(rs.getString(3));
				bb0.setBb0_Date(rs.getString(4));
				bb0.setBb0_Content(rs.getString(5));
				bb0.setBb0_Available(rs.getInt(6));
				list.add(bb0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	//Next Page Setting
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BB0 WHERE bb0_ID < ? AND bb0_Available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; 
	}
	
	public Bb0 getBb0(int bb0_ID) {
		String SQL = "SELECT * FROM BB0 WHERE bb0_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bb0_ID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bb0 bb0 = new Bb0();
				bb0.setBb0_ID(rs.getInt(1));
				bb0.setBb0_Title(rs.getString(2));
				bb0.setUserID(rs.getString(3));
				bb0.setBb0_Date(rs.getString(4));
				bb0.setBb0_Content(rs.getString(5));
				bb0.setBb0_Available(rs.getInt(6));
				return bb0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int update(int Bb0_ID, String Bb0_Title, String Bb0_Content) {
		String SQL = "UPDATE BB0 SET bb0_Title = ?, bb0_Content = ? WHERE bb0_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Bb0_Title);
			pstmt.setString(2, Bb0_Content);
			pstmt.setInt(3, Bb0_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB Error
	}
	
	public int delete(int Bb0_ID) {
		String SQL = "UPDATE BB0 SET bb0_Available = 0 WHERE bb0_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Bb0_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB Error
	}

}
