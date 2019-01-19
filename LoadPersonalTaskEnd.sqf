//LoadPersonalTaskEnd.sqf
private ["_allDone", "_caller", "_theGroup", "_missionType", "_loot", "_Mission0", "_Mission1", "_Mission2", "_Mission3", "_Mission4", "_Mission5", "_Mission6", "_missionFileName", "_missionLevel", "_newTask", "_groupArray", "_title"];

//[_name,_caller, _theGroup, _missionType, _loot, _missionFileName, _missionLevel, _newTask, _groupArray, _title]
_name = _this select 0;
_caller = _this select 1;
_theGroup = _this select 2;
_missionType = _this select 3;
_loot = _this select 4;
_missionFileName = _this select 5;
_missionLevel = _this select 6;
_newTask = _this select 7;
_groupArray = _this select 8;
_title = _this select 9;

_allDone = 0;
_check1 = 0;
while {_check1<4} do
{
	sleep 15;
	
	//check caller still connected
	_allDone = 1;
	{
		if (name _x == _name) then
		{
			_allDone = 0;
		};
	}forEach (allUnits + allDeadMen);
	if (_allDone==1) then
	{
		_check1 = _check1 + 1;
	}
	else
	{
		_check1 = 0;
	};
	
	//if the leader isnt the caller or there are no units on the mission
	if ((str _caller != str (leader _theGroup)) or ((count units _theGroup) == 0)) then
	{
		_allDone = 1;
		_check1 = _check1 + 1;
	};
	
	//if loot has been destroyed
	if (_missionType < 9 and _missionType > 5) then
	{
		if not(alive _loot) then
		{
			_allDone = 1;
			_check1 = _check1 + 1;
		};
	};
	
	//check if forcibly cancelled
	_Mission0 = ["MissionsInProgress", "MISSIONS", "Mission0", "STRING"] call iniDB_read;
	_Mission1 = ["MissionsInProgress", "MISSIONS", "Mission1", "STRING"] call iniDB_read;
	_Mission2 = ["MissionsInProgress", "MISSIONS", "Mission2", "STRING"] call iniDB_read;
	_Mission3 = ["MissionsInProgress", "MISSIONS", "Mission3", "STRING"] call iniDB_read;
	_Mission4 = ["MissionsInProgress", "MISSIONS", "Mission4", "STRING"] call iniDB_read;
	_Mission5 = ["MissionsInProgress", "MISSIONS", "Mission5", "STRING"] call iniDB_read;
	_Mission6 = ["MissionsInProgress", "MISSIONS", "Mission6", "STRING"] call iniDB_read;
	
	//forced ending by deleting MIP ID
	if not (_Mission0 == _missionFileName or _Mission1 == _missionFileName or _Mission2 == _missionFileName or _Mission3 == _missionFileName or _Mission4 == _missionFileName or _Mission5 == _missionFileName or _Mission6 == _missionFileName) then
	{
		_allDone = 2;
		_check1 = 100;
	};
	
	_taskState = [_missionFileName] call BIS_fnc_taskState;
	if (_taskState == "Succeeded" or _taskState == "Failed") then
	{
		_allDone == 1;
		_check1 = 100;
	};
};
[_missionFileName,_theGroup,_caller,_missionLevel,_newTask,_groupArray,[],"Canceled"] execVM "JobFinished.sqf";
deleteMarker _title;