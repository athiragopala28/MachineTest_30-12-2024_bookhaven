package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Bean.BookBean;
import dbconnection.DBConnection;

public class BookDao {

	private Connection getConnection() throws SQLException {
		return DBConnection.getConnection();
	}

	public BookBean getBookById(int id) throws SQLException {
		String query = "SELECT * FROM books WHERE id = ?";
		BookBean book = null;

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				book = new BookBean();
				book.setId(rs.getInt("id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setGenre(rs.getString("genre"));
				book.setYearOfPublication(rs.getInt("year_of_publication"));
			}
		}
		return book;
	}

	public List<BookBean> getAllBooks() throws SQLException {
		List<BookBean> books = new ArrayList<>();
		String query = "SELECT * FROM books";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				BookBean book = new BookBean();
				book.setId(rs.getInt("id"));
				book.setTitle(rs.getString("title"));
				book.setAuthor(rs.getString("author"));
				book.setGenre(rs.getString("genre"));
				book.setYearOfPublication(rs.getInt("year_of_publication"));
				books.add(book);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new SQLException("Error retrieving books from the database", e);
		}
		return books;
	}

	public void addBook(BookBean book) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = getConnection();
			String query = "INSERT INTO books (title, author, genre, year_of_publication) VALUES (?, ?, ?, ?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getAuthor());
			ps.setString(3, book.getGenre());
			ps.setInt(4, book.getYearOfPublication());

			int rowsAffected = ps.executeUpdate();
			System.out.println("Rows affected: " + rowsAffected);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new SQLException("Error adding book to the database", e);
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}

	public void updateBook(BookBean book) throws SQLException {
		String query = "UPDATE books SET title = ?, author = ?, genre = ?, year_of_publication = ? WHERE id = ?";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, book.getTitle());
			pstmt.setString(2, book.getAuthor());
			pstmt.setString(3, book.getGenre());
			pstmt.setInt(4, book.getYearOfPublication());
			pstmt.setInt(5, book.getId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new SQLException("Error updating book", e); 
		}
	}

	public boolean deleteBook(int id) {
		String query = "DELETE FROM books WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, id);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}