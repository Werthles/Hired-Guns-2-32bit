//CreateCiv.sqf
//Runs on player
//Called from HireCiv.sqf after interacting with a Civ and can hire
//Creates gear etc for Civ joining player's team

//pvs
params [["_type",0,[0]],["_rank",0,[0]],["_unit",objNull,[objNull]],["_play",objNull,[objNull]]];
private ["_joining"];

//var init
_joining = true;
//_unit = GUITargetObject;

//if variables failed to transmit
if (isNil "_type") then
{
	_unit setVariable["type",floor (random 5.9),true];
	_unit setVariable["rank",floor (random 8.9),true];
	_unit setVariable["town","town1",true];
	_type = _unit getVariable "type";
	_rank = _unit getVariable "rank";
};

//join group
if (_type<6) then
{
	_group1 = createGroup independent;
	
	_pos = getPos _unit;
	deleteVehicle _unit;
	
	_unit = _group1 createUnit ["U_I_C_Soldier_Bandit_5_F",_pos,[],0,"FORM"];
	
	[_unit] joinSilent _group1;
	_unit setSkill (0.46 + (_unit getVariable "rank")/20);

	_group1 setBehaviour "AWARE";
	
	sleep 1;
	
	_play addRating 3000;
	[_unit] join _play;
	_unit allowFleeing 0;
	sleep 2;
	
	deleteGroup _group1;

	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	_unit execVM (format["Civs\CIV%1b%2.sqf",_type,2 min (floor(_rank/3))]);
	//hint (format["Civs\CIV%1b%2.sqf",_type,floor(_rank/3)]);
}
else
{//won't join
	[2,(name _unit)] call Messages;
};