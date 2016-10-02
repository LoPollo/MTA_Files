
addEventHandler('onClientResourceStart', resourceRoot,
function()
	
	outputChatBox("FoNera's RC Stadium Replica", 0, 150, 0)
	outputChatBox("Use /tp for stadium teleport", 150, 0, 0)
	outputChatBox("2811 - ball", 200, 100, 100)
	outputChatBox("2812 - field_goals_shell", 200, 100, 100)
	outputChatBox("2813 - field_floor_element_hive_vinlies", 200, 100, 100)
	outputChatBox("2814 - field_floor", 200, 100, 100)
	outputChatBox("2815 - field_gfx", 200, 100, 100)
	outputChatBox("2816 - field_floor_elements", 200, 100, 100)
	outputChatBox("2817 - field_frames_3_L", 200, 100, 100)
	outputChatBox("2818 - field_frames_3_R", 200, 100, 100)
	outputChatBox("2819 - field_frames", 200, 100, 100)
	outputChatBox("2820 - audience_base", 200, 100, 100)
	outputChatBox("2821 - audience_decors", 200, 100, 100)
	outputChatBox("2822 - audience_statue", 200, 100, 100)
	
	-- Stadium objects --
	local Objects = {
	createObject(2811,5226.7393000,-1686.2832000,129.8608900,0.0000000,0.0000000,0.0000000), --ball
	createObject(2812,5226.6592000,-1685.7334000,136.2734800,0.0000000,0.0000000,0.0000000), --field_goals_shell
	createObject(2813,5226.7129000,-1685.7061000,127.4397900,0.0000000,0.0000000,0.0000000), --field_floor_element_hive_vinlies
	createObject(2814,5226.7764000,-1685.7129000,154.0654000,0.0000000,0.0000000,0.0000000), --field_floor
	createObject(2815,5226.7217000,-1685.6826000,202.7869000,0.0000000,0.0000000,179.9950000), --field_gfx
	createObject(2816,5226.7344000,-1685.7549000,136.2809000,0.0000000,0.0000000,0.0000000), --field_floor_elements
	createObject(2817,5226.7295000,-1603.5332000,136.9323000,0.0000000,0.0000000,0.0000000),--field_frames_3_l
	createObject(2818,5226.7344000,-1769.2920000,136.9330900,0.0000000,0.0000000,270.0000000), --field_frames_3_r
	createObject(2819,5226.7451000,-1685.7529000,134.9792900,0.0000000,0.0000000,0.0000000), --field_frames
	createObject(2820,5255.7275000,-1685.4303000,85.1838800,0.0000000,180.0000000,0.0000000), --audience_base
	createObject(2821,5063.9307000,-1685.0488000,2.6868600,0.0000000,0.0000000,0.0000000), --audience_decors
	createObject(2822,4830.1836000,-1687.9895000,200.4395000,0.0000000,0.0000000,0.0000000) --audience_statue
	}
	
	for index, object in ipairs ( Objects ) do 
    	setElementDoubleSided ( object, true ) 
	end 
	
	local txd1 = engineLoadTXD('files/textures_ball.txd', true)
	engineImportTXD( txd1, 2811 )

	local dff1 = engineLoadDFF('files/ball.dff', 0)
	engineReplaceModel( dff1, 2811 )

	local col1 = engineLoadCOL('files/ball.col')
	engineReplaceCOL( col1, 2811 )

	local txd2 = engineLoadTXD('files/test.txd', true)
	engineImportTXD( txd2, 2812 )
	engineImportTXD( txd2, 2813 )
	engineImportTXD( txd2, 2814 )
	engineImportTXD( txd2, 2815 )
	engineImportTXD( txd2, 2816 )
	engineImportTXD( txd2, 2817 )
	engineImportTXD( txd2, 2818 )
	engineImportTXD( txd2, 2819 )
	engineImportTXD( txd2, 2820 )
	engineImportTXD( txd2, 2821 )
	engineImportTXD( txd2, 2822 )

	local col0 = engineLoadCOL('files/dummy_col.col')
	engineReplaceCOL( col0, 2813 )
	engineReplaceCOL( col0, 2815 )
	engineReplaceCOL( col0, 2817 )
	engineReplaceCOL( col0, 2818 )
	engineReplaceCOL( col0, 2819 )
	engineReplaceCOL( col0, 2820 )
	engineReplaceCOL( col0, 2821 )
	engineReplaceCOL( col0, 2822 )

	local dff2 = engineLoadDFF('files/field_goals_shell.dff', 0)
	engineReplaceModel( dff2, 2812 )

	local col2 = engineLoadCOL('files/field_goals_shell.col')
	engineReplaceCOL( col2, 2812 )

	local dff3 = engineLoadDFF('files/field_floor_element_hive_vinlies.dff', 0)
	engineReplaceModel( dff3, 2813 )

	local dff4 = engineLoadDFF('files/field_floor.dff', 0)
	engineReplaceModel( dff4, 2814 )

	local col4 = engineLoadCOL('files/field_floor.col')
	engineReplaceCOL( col4, 2814 )

	local dff5 = engineLoadDFF('files/field_gfx.dff', 0)
	engineReplaceModel( dff5, 2815 )

	--local col5 = engineLoadCOL('files/field_gfx.col')
	--engineReplaceCOL( col5, 2815 )

	local dff6 = engineLoadDFF('files/field_floor_elements.dff', 0)
	engineReplaceModel( dff6, 2816 )

	local col6 = engineLoadCOL('files/field_floor_elements.col')
	engineReplaceCOL( col6, 2816 )

	local dff7 = engineLoadDFF('files/field_frames_3_L.dff', 0)
	engineReplaceModel( dff7, 2817 )

	--local col7 = engineLoadCOL('files/field_frames_3_L.col')
	--engineReplaceCOL( col7, 2817 )

	local dff8 = engineLoadDFF('files/field_frames_3_R.dff', 0)
	engineReplaceModel( dff8, 2818 )

	--local col8 = engineLoadCOL('files/field_frames_3_R.col')
	--engineReplaceCOL( col8, 2818 )

	local dff9 = engineLoadDFF('files/field_frames.dff', 0)
	engineReplaceModel( dff9, 2819 )

	--local col9 = engineLoadCOL('files/field_frames.col')
	--engineReplaceCOL( col9, 2819 )
	
	local dff10 = engineLoadDFF('files/audience_base.dff', 0)
	engineReplaceModel( dff10, 2820 )

	local dff11 = engineLoadDFF('files/audience_decors.dff', 0)
	engineReplaceModel( dff11, 2821 )

	local dff12 = engineLoadDFF('files/audience_statue.dff', 0)
	engineReplaceModel( dff12, 2822 )

	engineSetModelLODDistance(2811, 10000)
	engineSetModelLODDistance(2812, 10000)
	engineSetModelLODDistance(2813, 10000)
	engineSetModelLODDistance(2814, 10000)
	engineSetModelLODDistance(2815, 10000)
	engineSetModelLODDistance(2816, 10000)
	engineSetModelLODDistance(2817, 10000)
	engineSetModelLODDistance(2818, 10000)
	engineSetModelLODDistance(2819, 10000)
	engineSetModelLODDistance(2820, 10000)
	engineSetModelLODDistance(2821, 10000)
	engineSetModelLODDistance(2822, 10000)

	local CREATE_LOD = {[2811]=true, [2812]=true, [2813]=true, [2815]=true, [2816]=true, [2817]=true, [2818]=true, [2819]=true, [2820]=true, [2821]=true, [2822]=true};
	for _, object in ipairs(getElementsByType("object", resourceRoot)) do
		local model = getElementModel(object);

		if (CREATE_LOD[model]) then
			local x, y, z = getElementPosition(object);
			local rx, ry, rz = getElementRotation(object);
			local LOD = createObject(model, x, y, z, rx, ry, rz, true);

			if (model == 2821) then
				setElementAlpha(LOD, 100);
			end
			if (model == 2822) then
				setElementAlpha(LOD, 100);
			end

			setLowLODElement(object, LOD);
		end
	end

	setFarClipDistance(1000);
	setFogDistance(1);

end
);