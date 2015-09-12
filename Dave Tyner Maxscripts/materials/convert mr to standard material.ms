fn convertArchToStandard mat =
(
	-- Make new Standard mat, with original's diffuse map
	newMat = Standard diffuseMap:mat.mapM0
	newMat.name = mat.name
	newMat.diffuse = mat.diff_color
	showTextureMap newMat on
	newMat.specularLevel = 30
	newMat.glossiness = 20
	return newMat
)

-- Loop through all objects, checking material on each
for obj in geometry do
(
	mat = obj.material

	if (mat != undefined) then 
	(
		if (classof mat == Multimaterial) then 
		(
			-- This is a multi-sub material, so loop through all submaterials
			for i in mat.materialIdList do 
			(
				submat = mat[i]
				if (classof submat == Arch___Design__mi) then 
				(
					mat[i] = convertArchToStandard submat
				)
			)
		)

		else if (classof mat == Arch___Design__mi) then
		(
			-- Regular, non-multi material
			obj.material = convertArchToStandard mat
		)
	)
) -- end for
