//Fatigue.sqf
private["_val"];
_val = _this select 0;
if (isPlayer player) then
{
	if (_val==0) then
	{
		player enableFatigue false;
	}
	else
	{
		player enableFatigue true;
	};
};