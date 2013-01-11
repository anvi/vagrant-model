<?php

function checkOci($status)
{
    if (! $status) {
        $ociError = oci_error();
        throw new Exception($ociError['message']);
    }

    return $status;
}

$conf = include 'conf.php';
?>
<html>
<head>
   <title>Kapia Vagrant Box</title>
</head>
<body>
<?php
try {

    echo '<h1>Kapia Vagrant Box Test</h1>'; 
    $db = checkOci(oci_connect($conf['db_user'], $conf['db_pass'], $conf['db_server'], 'UTF-8'));

    $stmt = checkOci(oci_parse($db, 'select * from kua_users where user_login like \'ADMINK%\''));

    oci_execute($stmt);

    checkOci(oci_fetch_all($stmt, $res, 0, 1, OCI_FETCHSTATEMENT_BY_ROW + OCI_ASSOC));

    if (count($res)) {
        echo '<div>Oracle access is ok</div>';
    } else {
        echo '<div>No data found</div>';
    }

} catch (Exception $e) {
    echo $e->getMessage();
    echo '<pre>', $e->getTraceAsString(), '</pre>';
}
?>
</body>
</html>
