<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Bean.BookBean"%>
<%@ page import="Dao.BookDao"%>

<%
	int bookId = Integer.parseInt(request.getParameter("id"));
	BookDao bookDao = new BookDao();
	BookBean book = null;

	try {
		book = bookDao.getBookById(bookId); 
	} catch (SQLException e) {
		e.printStackTrace();
		out.print("<script type='text/javascript'>");
		out.print("alert('An error occurred while fetching the book details.');");
		out.print("window.location.href = 'view.jsp';");
		out.print("</script>");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Book</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: gray;
	margin: 0;
}

.container {
	margin-top: 2rem;
}

.form-container {
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 1rem;
}

h1 {
	color: #5bc0de;
}
</style>
</head>
<body>
	<div class="container">
		<div class="form-container">
			<h1>Edit Book</h1>
			<form action="update.jsp" method="POST">
				<input type="hidden" name="id" value="<%=book.getId()%>">
				<div class="mb-3">
					<label for="title" class="form-label">Title</label> <input
						type="text" class="form-control" id="title" name="title"
						value="<%=book.getTitle()%>" required>
				</div>
				<div class="mb-3">
					<label for="author" class="form-label">Author</label> <input
						type="text" class="form-control" id="author" name="author"
						value="<%=book.getAuthor()%>" required>
				</div>
				<div class="mb-3">
					<label for="genre" class="form-label">Genre</label> <input
						type="text" class="form-control" id="genre" name="genre"
						value="<%=book.getGenre()%>" required>
				</div>
				<div class="mb-3">
					<label for="year" class="form-label">Year of Publication</label> <input
						type="number" class="form-control" id="year" name="year"
						value="<%=book.getYearOfPublication()%>" required>
				</div>
				<button type="submit" class="btn btn-success">Update Book</button>
				<a href="view.jsp" class="btn btn-secondary">Cancel</a>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
