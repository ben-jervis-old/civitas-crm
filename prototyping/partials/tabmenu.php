<div id="tab-menu" class="visible-xs-block">
	<table>
		<td class="<?php if(!strcmp($active_page, "dashboard")) echo "active"; ?>">
			<a href="/demopage">
				<i class="glyphicon glyphicon-dashboard"></i>
				<small>Dashboard</small>
			</a>
		</td>
		<td class="<?php if(!strcmp($active_page, "members")) echo "active"; ?>">
			<a href="/demopage/members">
				<i class="glyphicon glyphicon-user"></i>
				<small>Members</small>
			</a>
		</td>
		<td class="<?php if(!strcmp($active_page, "rosters")) echo "active"; ?>">
			<a href="/demopage/rosters">
				<i class="glyphicon glyphicon-calendar"></i>
				<small>Rostering</small>
			</a>
		</td>
		<td>
			<a href="#Link4">
				<i class="glyphicon glyphicon-check"></i>
				<small>Attendance</small>
			</a>
		</td>
		<td>
			<a href="#Link5">
				<i class="glyphicon glyphicon-envelope"></i>
				<small>Contact</small>
			</a>
		</td>
	</table>
</div>
