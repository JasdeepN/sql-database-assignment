// <PublicDomain>
/*\
|*| This file depends on:
|*|  * Java 1.7
|*|  * PostgreSQL 9.3
|*|  * The included postgresql-9.3-1104.jdbc41.jar
|*|  * Hard work to meet the project requirements!
|*| 
|*|=============================================================================
|*| To compile me, run the following:
|*|
|*|   % javac MyProject.java
|*| 
|*| To run me, run the following:
|*|
|*|   % java -cp .:postgresql-9.3-1104.jdbc41.jar MyProject
|*| 
|*| To get full marks, when I run your program it must:
|*|  * Insert one new record into each relation(table)
|*|     * It MAY detect and delete the record it intends to insert if it exists
|*|     * If you wish to delete the record, your program MUST NOT error if the 
|*|       record does not yet exist 
|*|  * Run 4 select queries (2 from lab 6 & 2 from lab 7)
|*|     * It MUST pass the parameters to your query as a variable (these
|*|       parameters are the values that were in italics in the lab documents)
|*|     * using string concatenation in your query will result in a 0 for your
|*|       program in project part 2 (I will explain this next week)
|*|     * You MUST display your results as fancy tables (variable spaces to pad
|*|       out columns and increase readability)
|*|  * Your program MUST handle every exception (eg. If I run your code and your
|*|    database does not exist, it MUST NOT panic, produce a trace, or crash)  
|*| 
|*| Good luck!
\*/

import java.sql.*;

public class MyProject {
	public static void main(String[] args) {
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

	// You will need to change me...
		String uri = "jdbc:postgresql://localhost:5432/movie";
		String user = "movie";
		String password = "password";

		//Recycle these for print staments
		String name = "";
		String lastname = "";
		String movie_name = "";
		int eyecount;

		try {
		// Open the connection to the database
			con = DriverManager.getConnection(uri, user, password);

		// Create our select queries
			String qry = "SELECT * FROM \"Directors\" WHERE \"Surname\" = ? OR \"Year_of_birth\" = ?";
			String qry1 = "SELECT \"First_name\", \"Surname\", \"Budget\" AS USD, \"Budget\"*1.33 AS CAD,\"Budget\"*122.74 AS jpy, \"Budget\"*65.56 AS rub, \"Budget\"*0.94 AS eur, \"Budget\"*1.02 AS chf FROM \"Actors\" JOIN \"Movie Actors\" USING (\"ActorID\") JOIN \"Movies\" USING (\"MovieID\") WHERE \"Budget\" > ?";
			String qry2 = "SELECT * FROM \"Movies\" JOIN \"Movie Actors\" using (\"MovieID\") JOIN \"Actors\" USING (\"ActorID\") WHERE \"Actors\".\"First_name\" = ? AND \"Actors\".\"Surname\" = ?";
			String qry3 = "SELECT \"Movie_title\" FROM \"Movies\" JOIN \"Movie Directors\" using (\"MovieID\") JOIN \"Directors\" using (\"DirectorID\") where \"First_name\" = ? AND \"Surname\" = ?";
			String qry4 = "SELECT COUNT (\"Actors\".\"Eye_colour\") FROM \"Actors\" WHERE \"Eye_colour\" = ?";

		// Invert our variables (We'll pretend these aren't just static values and instead variable)
			//SEARCH VARIABLES
			int qryDOB = 1942;
			String qryName = "Wachowski";
			int qry1Budget = 17000000;
			String qry2Name = "Halle";
			String qry2Lastname = "Berry";
			String qry3Name = "Peter";
			String qry3Lastname = "Jackson";
			String qry4EyeColour = "Green";

		// First, load the statement
			pst = con.prepareStatement(qry);
			PreparedStatement pst1 = con.prepareStatement(qry1);
			PreparedStatement pst2 = con.prepareStatement(qry2);
			PreparedStatement pst3 = con.prepareStatement(qry3);
			PreparedStatement pst4 = con.prepareStatement(qry4);

		// Then populate the "?"s
		// ALWAYS, ALWAYS, ALWAYS use preprepared statements (a.k.a. parameterized queries)
		// Seriously....
		// No, I'm not joking....
		// Yes, this really is as important as I'm making it!
		// No, doing it a 'simpler' way is not more elegant.
		// No, you can't just create some sanitization function....
		// Did you know PostgreSQL treats $$this$$ the exact same as "this"?
		// Didn't think so. Seriously, don't try to invert your own sanitizer.
		// A determined hacker WILL find your mistakes given enough time and determination.
		// They then MAY responsibly disclose it to you (thank them profusely and fix it IMMEDIATELY)
		// Or, they MAY steal your database and use it for any number of purposes...

		//SEARCHS
		pst.setInt(2, qryDOB); // Note: We dictate that the value MUST be an Int. If not, it will throw an error and stop.
		pst.setString(1, qryName); // Again, this will ensure than quotes in the string are sanitized for us.
		pst1.setInt(1, qry1Budget);
		pst2.setString(1, qry2Name);
		pst2.setString(2, qry2Lastname);
		pst3.setString(1, qry3Name);
		pst3.setString(2, qry3Lastname);
		pst4.setString(1, qry4EyeColour);

		rs = pst.executeQuery();

		// If we got a record back
		//  Test Query ===============================================
		//System.out.println("\n"+rs.getStatement());
		System.out.println("=======================================================");
		System.out.format("%1s%31s%23s", "|", "TEST QUERY", "|");
		System.out.println("\n=======================================================");
		System.out.format("%1s%15s%15s%18s%6s", "|", "Director ID", "Last Name", "First Name", "|");
		System.out.print("\n-------------------------------------------------------");

		while(rs.next() == true){
			int num = rs.getInt("DirectorID");
			name = rs.getString("First_name");
			lastname = rs.getString("Surname");

			System.out.format("\n%1s%9s%21s%16s%8s", "|", num, lastname, name, "|");
		}
		System.out.print("\n-------------------------------------------------------");

		//  QUERY 1 ====================================================

		System.out.println("\n\n=======================================================");
		System.out.format("%1s%29s%25s", "|", "QUERY 1", "|");
		System.out.println("\n=======================================================");
		rs = pst1.executeQuery();
		//System.out.println("QUERY: " + rs.getStatement() + "\nRESULTS:");
		System.out.format("%1s%15s%15s%16s%8s", "|", "First Name", "Last Name", "Budget", "|");
		System.out.print("\n-------------------------------------------------------");

		while(rs.next()) {
			name = rs.getString("First_name");
			lastname = rs.getString("Surname");
			int bud = rs.getInt("usd");
			System.out.format("\n%1s%14s%16s%17s%7s", "|", name, lastname, bud, "|");
		}
		System.out.println("\n-------------------------------------------------------");

		//  QUERY 2 ====================================================

		System.out.println("\n=======================================================");
		System.out.format("%1s%29s%25s", "|", "QUERY 2", "|");
		System.out.println("\n=======================================================");
		rs = pst2.executeQuery();
		// System.out.println("QUERY: " + rs.getStatement() + "\nRESULTS:");
		System.out.format("%1s%11s%13s%21s%9s", "|", "First Name", "Last Name", "Movie Title", "|");
		System.out.print("\n-------------------------------------------------------");

		while(rs.next()) {
			name = rs.getString("First_name");
			lastname = rs.getString("Surname");
			movie_name = rs.getString("Movie_title");
			System.out.format("\n%1s%8s%14s%30s%2s", "|", name, lastname, movie_name, "|");
		}
		System.out.println("\n-------------------------------------------------------");

		//  QUERY 3 ====================================================

		System.out.println("\n=======================================================");
		System.out.format("%1s%29s%25s", "|", "QUERY 3", "|");
		System.out.println("\n=======================================================");
		rs = pst3.executeQuery();
		System.out.format("%1s%31s%23s", "|", "Movie Title", "|");
		System.out.print("\n-------------------------------------------------------");

		// System.out.println("QUERY: " + rs.getStatement() + "\nRESULTS:");
		while(rs.next()) {
			movie_name = rs.getString("Movie_title");
			int x = movie_name.length();
			System.out.format("\n%1s%47s%7s", "|", movie_name, "|");
		}
		System.out.println("\n-------------------------------------------------------");

		//  QUERY 4 ====================================================

		System.out.println("\n=======================================================");
		System.out.format("%1s%29s%25s", "|", "QUERY 4", "|");
		System.out.println("\n=======================================================");
		rs = pst4.executeQuery();
		// System.out.println("QUERY: " + rs.getStatement() + "\nRESULTS:");
		System.out.format("%1s%9s%45s", "|", "Count", "|");
		System.out.print("\n-------------------------------------------------------");

		while(rs.next()) {
			eyecount = rs.getInt("count");
			System.out.format("\n%1s%8s%46s", "|", eyecount, "|");
		}		
		System.out.println("\n-------------------------------------------------------");
		System.out.println("\nEND OF SEARCH QUERIES");

		// INSERT START ================================================
		// Create insert queries
		String insQryMovie = "INSERT INTO \"Movies\" VALUES (?,?,?,?,?,?)";
		String insQryGenre = "INSERT INTO \"Genres\" VALUES (?, ?)";
		String insQryHasGenre = "INSERT INTO \"Has Genres\" VALUES (?, ?)";
		String insQryCountry = "INSERT INTO \"Countries\" VALUES (?, ?)";
		String insQryStates = "INSERT INTO \"States\" VALUES (?, ?, ?)";
		String insQryCities = "INSERT INTO \"Cities\" VALUES (?, ?, ?)";
		String insQryActors = "INSERT INTO \"Actors\" VALUES (?, ?, ?, ?, ?)";
		String insQryMovieActors = "INSERT INTO \"Movie Actors\" VALUES (?, ?)";
		String insQryDirectors = "INSERT INTO \"Directors\" VALUES (?, ?, ?, ?, ?)";
		String insQryMovieDirectors = "INSERT INTO \"Movie Directors\" VALUES (?, ?)";
		String insQryTVShows = "INSERT INTO \"Television Shows\" VALUES (?, ?, ?, ?, ?)";
		String insQryTVActors = "INSERT INTO \"Television Actors\" VALUES (?, ?)";
		String insQrySoundtracks = "INSERT INTO \"Soundtracks\" VALUES (?, ?, ?)";

	//EMPTY INSERT VARIABLES
		int int1, int2, int3;
		double fl1;
		String str1, str2, str3; 
		java.sql.Date date; 

		//Prepared Statements
		PreparedStatement insPst1 = con.prepareStatement(insQryMovie);
		PreparedStatement insPst2 = con.prepareStatement(insQryGenre);
		PreparedStatement insPst3 = con.prepareStatement(insQryHasGenre);
		PreparedStatement insPst4 = con.prepareStatement(insQryCountry);
		PreparedStatement insPst5 = con.prepareStatement(insQryStates);
		PreparedStatement insPst6 = con.prepareStatement(insQryCities);
		PreparedStatement insPst7 = con.prepareStatement(insQryActors);
		PreparedStatement insPst8 = con.prepareStatement(insQryMovieActors);
		PreparedStatement insPst9 = con.prepareStatement(insQryDirectors);
		PreparedStatement insPst10 = con.prepareStatement(insQryMovieDirectors);
		PreparedStatement insPst11 = con.prepareStatement(insQryTVShows);
		PreparedStatement insPst12 = con.prepareStatement(insQryTVActors);
		PreparedStatement insPst13 = con.prepareStatement(insQrySoundtracks);

		// INSERT 1 -- MOVIE TABLE ========================================
		int1 = 11; //movieid
		str1 = "new movie"; //title
		date = java.sql.Date.valueOf("2015-11-26"); //date in yyyy-mm-dd
		int2 = 500000; //budget
		fl1 = 5.2; //rating
		int3 = 2531469; // gross
		//fill in ?
		insPst1.setInt(1, int1); //movieid
		insPst1.setString(2, str1); //movie_title
		insPst1.setDate(3, date); //date
		insPst1.setInt(4, int2); //budget
		insPst1.setDouble(5, fl1); //rating
		insPst1.setInt(6, int3); //gross
		
		try{
			insPst1.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 2 -- GENRES TABLE ======================================
		int1 = 12; //genreID
		str1 = "Romance"; //Genre name
		//fill in the ?
		insPst2.setInt(1, int1);
		insPst2.setString(2, str1);

		try{
			insPst2.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 3 -- Has Genres ========================================
		int1 = 11; // new genre id
		int2 = 11; // movie id to link genre
		//fill in the ?
		insPst3.setInt(1, int1);
		insPst3.setInt(2, int2);

		try{
			insPst3.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 4 -- Countries ========================================
		int1 = 13; // country id
		str1 = "Switzerland"; //country name
		//fill in the ?
		insPst4.setInt(1, int1);
		insPst4.setString(2, str1);

		try{
			insPst4.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 5 -- States ============================================
		int1 = 13; //country id 
		int2 = 13; //state id 
		str1 = "Zurich"; //new state
		//fill in the ?
		insPst5.setInt(1, int1);
		insPst5.setInt(2, int2);
		insPst5.setString(3, str1);

		try{
			insPst5.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 6 -- Cities ============================================
		int1 = 13; //state id 
		int2 = 13; //city id 
		str1 = "Geniva"; //new city
		//fill in the ?
		insPst6.setInt(1, int1);
		insPst6.setInt(2, int2);
		insPst6.setString(3, str1);

		try{
			insPst6.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 7 -- Actors ============================================
		int1 = 11; //actor id 
		int2 = 13; //city id 
		str1 = "New"; //first name
		str2 = "Actors"; //last name
		date = java.sql.Date.valueOf("2015-11-26"); //date
		//fill in the ?
		insPst7.setInt(1, int1);
		insPst7.setInt(2, int2);
		insPst7.setString(3, str1);
		insPst7.setDate(4, date);
		insPst7.setString(5, str2);

		try{
			insPst7.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 8 -- Movie Actors ======================================
		int1 = 11; //actor id
		int2 = 7; //movie id
		//fill in the ?
		insPst8.setInt(1, int1);
		insPst8.setInt(2, int2);

		try{
			insPst8.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 9 -- Directors ==========================================
		int1 = 11; //director id
		int2 = 4; //city id (where they were born)
		str1 = "Director"; //first name
		int3 = 2015; //year born
		str2 = "X"; //last name
		//fill in the ?
		insPst9.setInt(1, int1);
		insPst9.setInt(2, int2);
		insPst9.setString(3, str1);
		insPst9.setInt(4, int3);
		insPst9.setString(5, str2);

		try{
			insPst9.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 10 -- Movie Directors ===================================
		int1 = 11; //actor id
		int2 = 7; //movie id
		//fill in the ?
		insPst10.setInt(1, int1);
		insPst10.setInt(2, int2);

		try{
			insPst10.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 11 -- Television Shows =================================
		int1 = 11; //show id
		str1 = "New Show"; //show name
		str2 = "Description"; //description
		int2 = 2015; //year of release
		fl1 = 10.0; //rating

		insPst11.setInt(1, int1);
		insPst11.setString(2, str1);
		insPst11.setString(3, str2);
		insPst11.setInt(4, int2);
		insPst11.setDouble(5, fl1);

		try{
			insPst11.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 12 -- Television Actors =================================
		int1 = 11; //actor id
		int2 = 7; //show id
		//fill in the ?
		insPst12.setInt(1, int1);
		insPst12.setInt(2, int2);

		try{
			insPst12.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

		// INSERT 13 -- SoundTrack ========================================
		int1 = 11; //composer id
		int2 = 7; //movie  id
		str1 = "new composer"; //Composer Name
		//fill in the ?
		insPst13.setInt(1, int1);
		insPst13.setInt(2, int2);
		insPst13.setString(3, str1);

		try{
			insPst13.executeUpdate(); 
			System.out.println("INSERT SUCCESFUL");
		}catch(Exception e){
			System.err.println("error delete dupliacte");
		}

			/*\
			|*| A ResultSet object maintains a cursor pointing to its current row
			|*| of data. Initially the cursor is positioned before the first row.
			|*| The next() method moves the cursor to the next row. If there are no
			|*| rows left, the method returns false. The getString() method
			|*| retrieves the value of a specified column. The first column has
			|*| index 1.
			\*/

	} catch (SQLException ex) { // We MUST catch the error!
		System.out.println("error "+ex.getMessage());

	} finally { // We SHOULD close our connection when we're done
	try {
			if (rs != null) { // In
				rs.close();
			}

			if (pst != null) { // Reverse
				pst.close();
			}

			if (con != null) { // Order
				con.close();
			}

		} catch (SQLException ex) { // Again, we MUST catch the errors!
			System.out.println(ex.getMessage());
		}
	}
}}
// </PublicDomain>
