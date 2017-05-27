<div id="sidebar" class="hidden-xs">
	<div id="user-info-card">
		<img src="/demopage/usericon.png" height="50" width="50" class="pull-right">
		<div >
			<h4><a href="#Profile">User Name</a></h4>
			<a href="#Settings">
				My Account
			</a>
		</div>
	</div>
	<ul class="list-group sidebar-list">
		<a href="/demopage" class="">
			<li class="sidebar-list-item <?php if(!strcmp($active_page, "dashboard")) echo "active"; ?>">
				Dashboard
				<i class="glyphicon glyphicon-dashboard pull-right"></i>
			</li>
		</a>
		<a href="/demopage/members">
			<li class="sidebar-list-item <?php if(!strcmp($active_page, "members")) echo "active"; ?>">
				Members
				<i class="glyphicon glyphicon-user pull-right"></i>
			</li>
		</a>
		<a href="/demopage/rosters">
			<li class="sidebar-list-item <?php if(!strcmp($active_page, "rosters")) echo "active"; ?>">
				Rosters
				<i class="glyphicon glyphicon-calendar pull-right"></i>
			</li>
		</a>
		<a href="/demopage/groups">
			<li class="sidebar-list-item <?php if(!strcmp($active_page, "groups")) echo "active"; ?>">
				Groups
				<i class="glyphicon glyphicon-list pull-right"></i>
			</li>
		</a>
		<a href="#Link4">
			<li class="sidebar-list-item">
				Attendance
				<i class="glyphicon glyphicon-check pull-right"></i>
			</li>
		</a>
		<a href="#Link5">
			<li class="sidebar-list-item">
				Contact
				<i class="glyphicon glyphicon-envelope pull-right"></i>
			</li>
		</a>
	</ul>
</div>
