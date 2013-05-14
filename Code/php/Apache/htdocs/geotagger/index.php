<?php
/**
 * File to handle all API requests
 * Accepts GET and POST
 *
 * Each request will be identified by operation
 * Response will be JSON data
 
  /**
 * check for POST request
 */

if (!empty($_POST["operation"])) 
{
    // get operation
    $operation = $_POST['operation'];
 
    // include db handler and image server config
    require_once 'dbProcedures.php';
    $db = new dbProcedures();
 
    // response Array
    $response = array("operation" => $operation, "success" => 0, "error" => 0);
 
    // check for operation type
    if ($operation == 'login' || $operation == 'loginById') 
    {
        // Request type is check Login
        $uName = "";
        $id = -1;
        $user = false;
		if ($operation == 'login') 
		{
			$uName = $_POST['username'];
			$password = $_POST['password'];
			// check for user
			$user = $db->login($uName, $password);
		}
        else 
        {
        	$id = $_POST['id'];
        	$password = $_POST['password'];
        	// check for user
        	$user = $db->loginById($id, $password);
        }
		
        if ($user != false) 
        {
            // login success
            // return json with success = 1
            $response["success"] = 1;
            $response["user"]["uID"] = $user["AccountID"];
            $response["user"]["uName"] = $user["Username"];
            $response["user"]["email"] = $user["EmailAddress"];
            $response["user"]["pass"] = $user["Password"];
            $response["user"]["image"] = $user["Image"];
			$response["user"]["description"] = $user["Description"];
            $response["user"]["location"] = $user["Location"];
            $response["user"]["quote"] = $user["Quote"];
			$response["user"]["type"] = $user["Type"];
            $response["user"]["vis"] = $user["Visibility"];
            $response["user"]["createdTimeStamp"] = $user["CreatedDateTime"];
			$response["user"]["rating"] = $user["RatingScore"];
            echo json_encode($response);
        } 
        else 
        {
            // user not found
            // return json with error = 1
            $response["error"] = 1;
            $response["error_msg"] = "Incorrect email or password!";
            echo json_encode($response);
        }
    } //end login
    else if ($operation == 'register') {
        // Request type is Register new user
        $username = $_POST['username'];
        $password = $_POST['password'];
 
        // check if username is already taken
        if ($db->checkUsername($username)) 
        {
            // user exists - error response
            $response["error"] = 2;
            $response["error_msg"] = "Username is already taken";
            echo json_encode($response);
        }
        else
        {
            // store user
            $user = $db->addUser($username, $password);
            if ($user) 
            {
                // user stored successfully
                $response["success"] = 1;
				$response["uID"] = $user["AccountID"];
				$response["user"]["uName"] = $user["Username"];
                echo json_encode($response);
            } 
            else 
            {
                // user failed to store
                $response["error"] = 1;
                $response["error_msg"] = "Error occured in Registartion";
                echo json_encode($response);
            }
        }
    } //end register
    else if ($operation == 'checkUser') 
    {
		$name = $_POST['username'];
		// check if username is already taken
        if ($db->checkUsername($name)) 
        {
            // user exists - error response
            $response["error"] = 2;
            $response["error_msg"] = "Username is already taken";
            echo json_encode($response);
        } 
        else 
        {
            // store user
            echo "User does not exist.";
		}
	} //end checkUser
	//add tag to db
	else if ($operation == 'addTag') 
	{
        $oId = $_POST['oId'];
        $vis = $_POST['vis'];
        $name = $_POST['name'];
        $desc = $_POST['desc'];
        $imgUrl = $_POST['imgUrl'];
        $loc = $_POST['loc'];
        $lat = $_POST['lat'];
        $lon = $_POST['lon'];
        $cat = $_POST['cat'];
 
        // store user
        $success = $db->addTag($oId, $vis, $name, $desc, $imgUrl, $loc, $lat, $lon, $cat);
        if ($success) 
        {
        	// tag stored successfully
        	$response["success"] = 1;
        	$response["tagId"] = mysql_result($success,0);
        	echo json_encode($response);
        }
        else
        {
        	// user failed to store
        	$response["error"] = 1;
        	$response["error_msg"] = "Error adding tag.";
        	echo json_encode($response);
        }     
	}//end add tag
	//upload an image and return the url
	else if ($operation == 'uploadImage')
	{
		$encodedImage = $_POST['imageString'];
		//path to Images base directory
		$imgFolderPath = dirname(__FILE__) . '\Images\\';
		$baseUrl = "http://10.0.2.2/geotagger/images/";
		
		//Organize Image folders by month. 
		$date = getdate();
		//append a 0 if month < 10
		$monStr = "";
		if ($date[mon] < 10) {$monStr = "0$date[mon]";}
		else{$monStr = "$date[mon]";}
		
		//create folder if it doesnt exist
		$folderName = "$monStr$date[year]";
		$folderPath = $imgFolderPath . $folderName . '\\';
		if (! file_exists($folderPath)){mkdir("$folderPath");}
		
		//decode image and save to file
		$fileName = uniqid() . '.jpg';
		$filePath = $folderPath . $fileName;
		
		$imgData=base64_decode($encodedImage);
		header('Content-Type: bitmap; charset=utf-8');
		$file = fopen($filePath, 'wb');
		
		if (fwrite($file, $imgData) != false)
		{
			fclose($file);
			$url = $baseUrl . $folderName . '/' . $fileName;
			// image saved successfully, return url in JSON
        	$response["success"] = 1;
        	$response["url"] = $url;
        	echo json_encode($response);
		}
		else
        {
        	// Error uploading image
        	$response["error"] = 1;
        	$response["error_msg"] = "Error uploading image.";
        	echo json_encode($response);
        }
	}//end save image
	else 
	{
        echo "Invalid Request";
    }
} 
else 
{
    echo "Access Denied";
}
?>