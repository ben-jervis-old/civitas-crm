<?php
	$active_page = "members";
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
							<h1>Member Database</h1>
						</div>
						<div class="row bounded-row">
							<div class="col-md-1 visible-xs-block">
								<button class="btn btn-primary btn-block">
									<i class="glyphicon glyphicon-plus"></i> New Member
								</button>
								<br>
							</div>
							<div class="col-md-4">
								<div class="input-group">
									<input type="text" name="user-search" value="" class="form-control" placeholder="Search">
									<span class="input-group-btn">
										<button class="btn btn-default">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</span>
								</div>
							</div>
							<div class="col-md-1 col-md-offset-7 hidden-xs">
								<button class="btn btn-primary pull-right">
									<i class="glyphicon glyphicon-plus"></i> New Member
								</button>
							</div>
						</div>
							<div class="list-group row ">
								<?php
									foreach(range(1, 15) as $index) {
										echo "<div class=\"col-md-3\">";
										echo "<div class=\"list-group-item\">";
										echo "	<h4>";
										echo "		<a href=\"#$index\">Test Member $index</a>";
										echo "		<a href=\"#Show\"><i class=\"glyphicon glyphicon-picture pull-right\"></i></a>";
										echo "	</h4>";
										echo "</div>";
										echo "</div>";
									}
								 ?>
							</div>
					</div>
				</div>
				<?php require_once "../partials/tabmenu.php"; ?>
			</div>
		</div>
		<?php require_once "../partials/scripts.php"; ?>
	</body>
</html>
