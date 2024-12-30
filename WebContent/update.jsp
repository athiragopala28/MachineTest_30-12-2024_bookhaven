<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Bean.BookBean"%>
<%@ page import="Dao.BookDao"%>

<%
	int bookId = Integer.parseInt(request.getParameter("id"));
	String title = request.getParameter("title");
	String author = request.getParameter("author");
	String genre = request.getParameter("genre");
	int year = Integer.parseInt(request.getParameter("year"));

	BookDao bookDao = new BookDao();
	BookBean book = new BookBean();

	book.setId(bookId);
	book.setTitle(title);
	book.setAuthor(author);
	book.setGenre(genre);
	book.setYearOfPublication(year);

	try {
		bookDao.updateBook(book); // Assuming updateBook method exists in BookDao
		response.sendRedirect("view.jsp"); // Redirect to the view page after successful update
	} catch (SQLException e) {
		e.printStackTrace();
		out.print("<script type='text/javascript'>");
		out.print("alert('An error occurred while updating the book details.');");
		out.print("window.location.href = 'edit.jsp?id=" + bookId + "';");
		out.print("</script>");
	}
%>
