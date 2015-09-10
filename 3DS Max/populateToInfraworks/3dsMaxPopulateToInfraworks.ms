	try (destroyDialog Infraworks)catch()
Rollout Infraworks "Infraworks Character Exporter"
(
	
	fn moveroot com target = (
	
		local p = com
	--theFoot = $Female023LFoot
	--dist = p.pos[3] - theFoot.pos[3] + .1
	local dist = .85
	--local target = groundObject
	local r1 = ray p [0,0,-1] 
	local ir = intersectRay target r1
	if ir != undefined then  (
		local pos = [p[1],p[2],(ir.position[3]+dist)]
	)
	--format "%\n" "I should be animating frames now"
	if ir != undefined then return (ir.position[3]+dist)
	--format "IR is %\n" ir
	return false
)
	fn animateframes obj = (
		if obj == undefined then return false
		local ks = obj.pos.controller.keys
					for k = 1 to ks.count do(
						if (k>1)==true and (k<ks.count)==true then (
							pk = obj.pos.controller.z_position.keys[k-1].value
							nk = obj.pos.controller.z_position.keys[k+1].value
							ck = obj.pos.controller.z_position.keys[k].value
							if ((ck+pk) > (pk+nk)) == true then local kz = pk
							else kz = pk
						) else (
							local kz = obj.pos.controller.z_position.keys[k].value
						)
						local kx = obj.pos.controller.x_position.keys[k].value
						local ky = obj.pos.controller.y_position.keys[k].value
						--kz += 3.3 --distance from hip to ankle
						local targ = getnodebyname(Infraworks.btn_pick.text)
						if targ != undefined then (
							local z = moveroot [kx,ky,kz] targ
						)
						if z == false then continue
						if (obj.pos.controller.z_position.controller.keys[k]) != undefined then (
							obj.pos.controller.z_position.controller.keys[k].value = (z + .02)
							--format "END:%\n" z
						)
					)
	)
	
fn getchildren obj = (q

	local crn = obj.children
	for c = 1 to crn.count do(
		append arr crn[c]
		getchildren crn[c]
	)
	
	
)
--hi
fn getMesh obj = (
		local theName = filterstring obj.name "Female"
		if matchpattern obj.name pattern:"*Female*" == true then local g = "f"
		else local g = "m"
		local part = ""
		case of(
			(matchpattern obj.name pattern:"*RUpperArm"):part = g + "_Bip001 R UpperArm001"
			(matchpattern obj.name pattern:"*RClavicle"):part = g + "_Bip001 R Clavicle001"
			(matchpattern obj.name pattern:"*LHand"):part = g + "_Bip001 L Hand001"
			(matchpattern obj.name pattern:"*LForeArm"):part = g + "_Bip001 L Forearm001"
			(matchpattern obj.name pattern:"*RForeArm"):part = g + "_Bip001 R Forearm001"
			(matchpattern obj.name pattern:"*RHand"):part = g + "_Bip001 R Hand001"
			(matchpattern obj.name pattern:"*LThigh"):part = g + "_Bip001 L Thigh001"
			(matchpattern obj.name pattern:"*LCalf"):part = g + "_Bip001 L Calf001"
			(matchpattern obj.name pattern:"*LFoot"):part = g + "_Bip001 L Foot001"
			(matchpattern obj.name pattern:"*RThigh"):part = g + "_Bip001 R Thigh001"
			(matchpattern obj.name pattern:"*RCalf"):part = g + "_Bip001 R Calf001"
			(matchpattern obj.name pattern:"*RFoot"):part = g + "_Bip001 R Foot001"
			(matchpattern obj.name pattern:"*LUpperArm"):part = g + "_Bip001 L UpperArm001"
			(matchpattern obj.name pattern:"*LClavicle"):part = g + "_Bip001 L Clavicle001"
			(matchpattern obj.name pattern:"*Head"):part = g + "_Bip001 Head001"
			(matchpattern obj.name pattern:"*Neck"):part = g + "_Bip001 Neck001"
			(matchpattern obj.name pattern:"*Spine4"):part = g + "_Bip001 Spine004"
			(matchpattern obj.name pattern:"*Spine2"):part = g + "_Bip001 Spine006"
			(matchpattern obj.name pattern:"*Spine1"):part = g + "_Bip001 Spine007"
			(matchpattern obj.name pattern:"*Spine3"):part = g + "_Bip001 Spine005"
			(matchpattern obj.name pattern:"*Pelvis"):part = g + "_Bip001 Pelvis001"
		)
		if part != "" then return snapshot (getnodebyname part)
)



fn cleanit = (
	delarr = #()
		for i in objects where i.isfrozen == false do append delarr i
delete delarr
		gc()
)
fn replacegeometry = (
		local t = 1
		local delarr = #()
		for i in objects where i.modifiers.count == 1 and i.modifiers[1].name == "Skin" do append delarr i
		delete delarr
		delarr = #()
		for i in objects where classof i == Dummy do append delarr i
		for i in objects where classof i == Point do append delarr i
	--disableSceneRedraw()
	local p=point name:"root" size:.25
	local thebones = for c in objects where classof c == BoneGeometry do append delarr c
	local objs = for o in objects where matchpattern o.name pattern:"*COM1" collect o
	local objArr = #()
	
	for r in objs do(
		local modelno = substring r.name 1 ((r.name).count-4)
		--format "m:%\n" modelno
		local arr = for o in objects where matchpattern o.name pattern:(modelno+"*") collect o
		append objArr arr
		arr = #()
		--format "%\n" objarr
	)
		
		for o = 1 to objarr.count do	
		(
			local objArray = objarr[o]
			
			for n = 1 to objArray.count do (
				--format "ObjArray:\t%\n" objArray[n]

				local c = objArray[n]
				local root = matchpattern c.name pattern:"*COM1"
				local bb = c.max-c.min
				local b = getMesh c
				if b == undefined and root == false then continue --cone radius1:.05 radius2:.03 height:c.length
				else if b == undefined and root == true then (
					animateframes c
					continue
				)
				local pointBone = point size:.2 box:on pos:c.pos 
				pointBone.ishidden=true
				pointBone.transform = c.transform
				b.transform = c.transform
				c.rotation.controller = euler_xyz()
				b.parent = pointBone
				/*
				local bonePosKeys = c.pos.controller.keys
					for k = 1 to bonePosKeys.count do(
						addnewkey pointBone k
						pointBone.pos.controller.x_position.keys[k].value = c.pos[1]
						pointBone.pos.controller.y_position.keys[k].value = c.pos[2]
						pointBone.pos.controller.z_position.keys[k].value = c.pos[3]
						
						pointBone.rotation.controller.x_rotation.keys[k].value =  c.rotation.controller.x_rotation.keys[k].value
						pointBone.rotation.controller.y_rotation.keys[k].value = c.rotation.controller.y_rotation.keys[k].value
						pointBone.rotation.controller.z_rotation.keys[k].value = c.rotation.controller.z_rotation.keys[k].value
					)
				*/
				--in coordsys local rotate b 90 [0,1,0]
				
				
				local end = animationrange.end
				for t = 1 to end do (
					--slidertime = t
					with animate on (
							at time t pointBone.transform = c.transform
					)
				)
				
				
			)
		
		)
		
	--enableSceneRedraw()
	delete delarr
	--delete objs
)


group "Setup" (
			checkbox chk_export "Export" align:#left
			edittext txt_ext "Extension" text:"dae" align:#left width:105
			--edittext txt_suf "Sufffix: *" text:"" tooltip:"Put your suffix here" align:#left width:105
			edittext txt_dir "Directory" align:#left across:2 width:400 height:24
			button btn_browse "..." align:#right width:20 
)	
group "Go?"
		(
			pickbutton btn_pick "Pick terrain object" align:#left
			button btn_unfreezeTerrain "Unfreeze/Freeze Terrain" align:#left
			button btn_go "GO" align:#left
		)
group "Cleanup"
		(
			label lbl_clean "Cleaning will delete all animated characters as well as some meshes" align:#left
			button btn_clean "Clean Scene" align:#left
		)
	
	on btn_unfreezeTerrain pressed do(
		local t = getnodebyname(btn_pick.text)
		print t
		if t != undefined then (
			if t.isfrozen == true then t.isfrozen = false
			else t.isfrozen = true
		)
	)
	
	on btn_pick picked pickedObj do (
		global groundObject = pickedObj
		btn_pick.text = pickedObj.name
		groundObject.isfrozen = true
		local lm = layermanager
		for x = 1 to lm.count-1 do(
			local lay = lm.getlayer x
			if lay.name == "terrain" then lay.addnode pickedObj
		)
	)
			on btn_browse pressed do
		(
			local fpath = getSavePath initialDir:@"C:\" caption:"Select any file in the source directory:" 
			--shellLaunch "explorer.exe" (getdir #scene)
			if fpath != undefined then
			(
			--local extension = txt_ext.text
			--local pfix = if txt_pre.text == "" then pfix = "*" else pfix = txt_pre.text 
			local thepath = fpath
			--local dcount = (for f in getfiles (thepath) collect f).count
			txt_dir.text = thepath + "\\PopToAIW_" + (random 1 10000) as string + ".dae"
			/*
				if dcount > 0 then 
				(
					lblNumFiles.text = dcount as string + " files will be imported"
					txt_dir.text = fpath + "\\" + pfix + "." + extension 
				)
				*/
			)
			--btnUpdate.enabled = true
		)
	on btn_clean pressed do (
		cleanit()
	)
	
		on btn_go pressed do (
		clearlistener()
		local t = getnodebyname(Infraworks.btn_pick.text)
		if t != undefined then (
			--if t.isfrozen == false then t.isfrozen = true
		)
		replacegeometry()
		if chk_export.checked == true then (
			local bips = for o in objects where o.isfrozen == false and matchpattern o.name pattern:"*_Bip*" collect o
			select bips
			local filename = substituteString txt_dir.text "\\" "/"
			exportFile fileName #noPrompt selectedOnly:True
		)
		gc()
		--enableSceneRedraw()
	)

)
createDialog Infraworks 460 350
--InfraChar=newrolloutfloater "PolyForm Infraworks Character Exporter" 250 125
--addrollout Infraworks InfraChar  rolledUp:false