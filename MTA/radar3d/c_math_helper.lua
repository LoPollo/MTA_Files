--
-- c_math_helper.lua
--

function vec2Angle(x, y) 
	local t = -math.deg(math.atan2(x, y))
	if t < 0 then t = t + 360 end
	return t
end

function getPointFromDistanceRotation(x, y, dist, angle)
	local a = math.rad(90 - angle);
	local dx = math.cos(a) * dist;
	local dy = math.sin(a) * dist;
	return x+dx, y+dy;
end

function crossProduct(vec1, vec2) 
	return Vector3(
		((vec1.y * vec2.z) - (vec1.z * vec2.y)),
	  - ((vec1.x * vec2.z) - (vec1.z * vec2.x)),
		((vec1.x * vec2.y) - (vec1.y * vec2.x)))
end

function createCameraMatrix(fwVec, upVec, pos)
	local zaxis = (fwVec):getNormalized()
	local xaxis = (crossProduct(-upVec, zaxis)):getNormalized()
	local yaxis = crossProduct(xaxis, zaxis)
	elMat:setRight(xaxis)
	elMat:setForward(zaxis)
	elMat:setUp(yaxis)
	return elMat
end

function getScreenFrom3DPosition(posVec, viewProj, screenWH)
	local posTab = {posVec.x, posVec.y, posVec.z, 1}
	local worldViewProjection = matrixVec4MultiplyTab(viewProj, posTab)
	worldViewProjection[1] = worldViewProjection[1] / worldViewProjection[3] 
	worldViewProjection[2] = -worldViewProjection[2] / worldViewProjection[3]
	worldViewProjection[1] = (worldViewProjection[1] + 1) * screenWH.x / 2
	worldViewProjection[2] = (worldViewProjection[2] + 1) * screenWH.y / 2
	return Vector2(worldViewProjection[1], worldViewProjection[2])
end

function createViewMatrixTab(fwVec, upVec, pos)
	local zaxis = (fwVec):getNormalized()
	local xaxis = (crossProduct(-upVec, zaxis)):getNormalized()
	local yaxis = crossProduct(xaxis, zaxis)
	return {
		{ xaxis.x, yaxis.x, zaxis.x, 0 },
		{ xaxis.y, yaxis.y, zaxis.y, 0 },
		{ xaxis.z, yaxis.z, zaxis.z, 0 },
		{-xaxis:dot(pos), -yaxis:dot(pos), -zaxis:dot(pos), 1 }
		}
end

function createProjectionMatrixTab(nearPlane, farPlane, fovHoriz, fovAspect)
	local h, w, Q
	w = 1/math.tan(fovHoriz * 0.5)
	h = w / fovAspect
	Q = farPlane/(farPlane - nearPlane)
	return {
		{w, 0, 0, 0},
		{0, h, 0, 0},
		{0, 0, Q, 1},
		{0, 0, -Q * nearPlane, 0}
	}    
end

function matrixVec4MultiplyTab(mat, vec)
	local vecOut = {}
	vecOut[1] = vec[1] * mat[1][1] + vec[2] * mat[2][1] + vec[3] * mat[3][1] + vec[4] * mat[4][1]
	vecOut[2] = vec[1] * mat[1][2] + vec[2] * mat[2][2] + vec[3] * mat[3][2] + vec[4] * mat[4][2]
	vecOut[3] = vec[1] * mat[1][3] + vec[2] * mat[2][3] + vec[3] * mat[3][3] + vec[4] * mat[4][3]
	vecOut[4] = vec[1] * mat[1][4] + vec[2] * mat[2][4] + vec[3] * mat[3][4] + vec[4] * mat[4][4]
	return vecOut
end

function matrixMultiplyTab(mat1, mat2)
	local matOut = {}
	for i = 1,#mat1 do
		matOut[i] = {}
		for j = 1,#mat2[1] do
			local num = mat1[i][1] * mat2[1][j]
			for n = 2,#mat1[1] do
				num = num + mat1[i][n] * mat2[n][j]
			end
			matOut[i][j] = num
		end
	end
	return matOut
end

function clampWorldPos2Angle(viewPos, bliPos, camFwVec, halfAngle, isBorder)
	local angle2blip = getObiectToCameraAngle(bliPos, viewPos, camFwVec)
	local angle2plane = (angle2blip - math.pi/2)
	if math.abs(angle2plane) < 0.0175 then
		if angle2plane < 0 then
			angle2plane = -0.0175
		else
			angle2plane = 0.0175				
		end
	end
	local planarDist = math.sin(angle2plane) * (viewPos - bliPos).length
	local planarPos = viewPos - camFwVec * planarDist
	local planar2blipVec = (planarPos - bliPos):getNormalized()
	local planarVecLen 
	if isBorder then 
		planarVecLen = math.tan(math.rad(halfAngle)) * planarDist  
	else
		planarVecLen = math.tan(math.min(math.rad(halfAngle), angle2blip)) * planarDist
	end
	return Vector3(planarPos + planar2blipVec * planarVecLen)
end

function getObiectToCameraAngle(elementPos, cameraPos, fwVec)
	local elementDir = (elementPos-cameraPos):getNormalized()
	return math.acos(elementDir:dot(fwVec)/(elementDir.length * fwVec.length))
end

function findEmptyEntry(inTable)
	for index,value in ipairs(inTable) do
		if not value.enabled then
			return index
		end
	end
	return #inTable + 1
end
