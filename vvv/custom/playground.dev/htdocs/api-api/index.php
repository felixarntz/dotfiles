<?php

require_once dirname( __FILE__ ) . '/project/vendor/autoload.php';

function p( $data ) {
	echo '<pre>' . print_r( $data, true ) . '</pre>';
}

$my_api = apiapi( 'my-api', true );

?><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<title>API-API Dev</title>
</head>

<body>
	<h1>API-API Dev</h1>
	<?php p( $my_api ); ?>
</body>
</html>
