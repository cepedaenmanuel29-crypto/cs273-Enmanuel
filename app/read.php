<?php
$players = [];
$error = false;

try {
    require __DIR__ . "/db.php";

    // Players and Teams JOIN
    $sql = "
        SELECT
            p.PlayerID,
            p.PlayerFirstName,
            p.PlayerLastName,
            p.PlayerDateOfBirth,
            t.TeamName
        FROM players p
        INNER JOIN teams t ON p.TeamID = t.TeamID
        ORDER BY t.TeamName, p.PlayerLastName
    ";

    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $players = $stmt->fetchAll();

} catch (Throwable $e) {
    error_log($e->getMessage());
    $error = true;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Basketball 3v3 - Players</title>
<style>
body {
    font-family: Arial, sans-serif;
    background: #f3f5f9;
    margin: 0;
    padding: 30px;
}
.container {
    max-width: 1100px;
    margin: auto;
    background: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 18px #00000015;
}
h1 { color: #183153; }
p { color: #555; }
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
th {
    background: #183153;
    color: white;
    text-align: left;
}
th, td {
    padding: 12px;
    border-bottom: 1px solid #ddd;
}
tr:nth-child(even) { background: #f1f5fa; }
tr:hover { background: #e5efff; }
.message { padding: 14px; background: #eef3fa; }
</style>
</head>
<body>
<div class="container">
<h1>Basketball 3v3 Tournament Database</h1>
<p>Phase 7A - PHP Read Page</p>
<p>Players and their teams</p>

<?php if ($error): ?>
    <div class="message">Unable to load database records.</div>
<?php elseif (empty($players)): ?>
    <div class="message">No records found</div>
<?php else: ?>
<table>
<thead>
<tr>
<?php foreach (array_keys($players[0]) as $column): ?>
<th><?= htmlspecialchars((string)$column, ENT_QUOTES, 'UTF-8') ?></th>
<?php endforeach; ?>
</tr>
</thead>
<tbody>
<?php foreach ($players as $player): ?>
<tr>
<?php foreach ($player as $value): ?>
<td><?= htmlspecialchars((string)($value ?? ''), ENT_QUOTES, 'UTF-8') ?></td>
<?php endforeach; ?>
</tr>
<?php endforeach; ?>
</tbody>
</table>
<?php endif; ?>
</div>
</body>
</html>

