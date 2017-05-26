<?php
	$active_page = "rosters";
 ?>
<!DOCTYPE html>
<html>
	<head>
		<?php require_once "../partials/header.php"; ?>
	</head>
	<body>
		<?php require_once "../partials/navbar.php"; ?>
		<div class="container-fluid">
			<div class="row" id="main-body-div">
				<?php require_once "../partials/sidebar.php"; ?>
				<div id="content-div">
					<div class="container-fluid">
						<div class="page-header">
							<h1>Rostering</h1>
						</div>
						<div class="row padded-row">
							<button class="btn btn-primary btn-block">
								<i class="glyphicon glyphicon-plus"></i> New Roster
							</button>
						</div>
						<div class="row padded-row">
							<div class="panel panel-default list-group">
								<div class="list-group-item">
									<a href="#1"><h4>Grounds keeping <span class="label label-default pull-right">12 Members</span></h4></a>
									Church grounds maintenance roster for the week 29/05 to 04/06

								</div>
								<div class="list-group-item">
									<a href="#1"><h4>Readings - 9:30 Service <span class="label label-default pull-right">4 Members</span></h4></a>
									Verse readings for the 9:30am service of 04/06

								</div>
								<div class="list-group-item">
									<a href="#1"><h4>Home Visits <span class="label label-default pull-right">2 Members</span></h4></a>
									Ministry outreach roster 05/06 to 05/07
								</div>
							</div>
						</div>
					</div>
				</div>
				<?php require_once "../partials/tabmenu.php"; ?>
			</div>
		</div>
		<?php require_once "../partials/scripts.php"; ?>
	</body>
</html>
