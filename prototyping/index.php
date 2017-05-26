<?php
	$active_page = "dashboard";
 ?>
<!DOCTYPE html>
<html>
	<head>
		<?php require_once "/partials/header.php"; ?>
	</head>
	<body>
		<?php require_once "/partials/navbar.php"; ?>
		<div class="container-fluid">
			<div class="row" id="main-body-div">
				<?php require_once "/partials/sidebar.php"; ?>
				<div id="content-div">
					<div class="container-fluid">
						<div class="page-header">
							<h1>St Mark's Anglican Church</h1>
						</div>
						<?php require_once "/partials/cards.php"; ?>
						<div class="row padded-row">
							<h2>Notifications (2)</h2>
							<div class="panel panel-default">
								<div class="list-group">
									<div class="list-group-item">
										<div class="notification-body">
											<h4>Member Approvals</h4>
											<p>There are new member applications</p>
										</div>
										<button class="btn btn-primary pull-right">View</button>
									</div>
									<div class="list-group-item">
										<div class="notification-body">
											<h4>Extended Absence</h4>
											<p>[User Name] has been absent for the last 3 services</p>
										</div>
										<button class="btn btn-primary pull-right">View</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<?php require_once "/partials/tabmenu.php"; ?>
			</div>
		</div>
		<?php require_once "/partials/scripts.php"; ?>
	</body>
</html>
