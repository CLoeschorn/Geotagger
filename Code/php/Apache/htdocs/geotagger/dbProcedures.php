<?php
 
class dbProcedures 
{
 
    private $db;
	//Connect to db
    function __construct() 
    {
        require_once 'dbConnect.php';
        $this->db = new dbConnect();
        $this->db->connect();
    }
 
	//Add new user to database
    public function addUser($username, $pass) 
    {
        $result = mysql_query("Insert into Accounts(Username, Password, Type, Visibility,CreatedDateTime) VALUES('$username', '$pass', 1, 1, now())");
        // check success
        if ($result) 
        {
            //return user account
            $uid = mysql_insert_id(); // last inserted id
            $result = mysql_query("SELECT * FROM Accounts WHERE AccountID = '$uid'");
            return mysql_fetch_array($result);
        } 
        else 
        {
            return false;
        }
    }
 
    /**
     * Get user by email and password
     */
    public function login($username, $password) 
    {
        $result = mysql_query("SELECT * FROM Accounts WHERE Username = '$username'") or die(mysql_error());
        // check for result
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) 
        {
            $result = mysql_fetch_array($result);
            $storedPass = $result['Password'];
            // if passwords match, return account object
            if ($password == $storedPass) 
            {
                return $result;
            }
            else 
            {
				//incorrect password
				return false;
			}
        } 
        else 
        {
            // user not found
            return false;
        }
    }
 
    /**
     * Get user by ID
     */
    public function loginById($id, $password) 
    {
    	$result = mysql_query("SELECT * FROM Accounts WHERE AccountID = '$id'") or die(mysql_error());
    	// check for result
    	$no_of_rows = mysql_num_rows($result);
    	if ($no_of_rows > 0) {
    		$result = mysql_fetch_array($result);
    		$storedPass = $result['Password'];
    		// if passwords match, return account object
    		if ($password == $storedPass) 
    		{
    			return $result;
    		}
    		else 
    		{
    			//incorrect password
    			return false;
    		}
    	} 
    	else 
    	{
    		// user not found
    		return false;
    	}
    }
    /**
     * Check if username already exists
     */
    public function checkUsername($uName) 
    {
        $result = mysql_query("SELECT Username from Accounts WHERE Username = '$uName'");
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) 
        {
            // uname taken
            return true;
        } 
        else 
        {
            // uname not taken
            return false;
        }
    }
    /**
     * Add tag to database. Will return true if the add was successful.
     */
    public function addTag($oId, $vis, $name, $desc, $imgUrl, $loc, $lat, $lon, $cat)
    {
    	$result = mysql_query("Select AddTag($oId, \"$name\", $vis, \"$desc\", \"$imgUrl\", \"$loc\", $lat, $lon, \"$cat\")");
		//$result = mysql_query("Insert into Tags(ownerID, Visibility, Name, Description, ImageUrl, Location, Latitude, 
		//Longitude, CreatedDateTime, Category)
		//	Values($oId, $vis, \"$name\", \"$desc\", \"$imgUrl\", \"$loc\",$lat, $lon, now(), \"$cat\");");
    	return $result;
    }

 
}
 
?>