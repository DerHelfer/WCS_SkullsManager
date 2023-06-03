#include "..\..\WCS\include\wcs.inc"
#pragma newdecls required
#pragma semicolon 1
#pragma tabsize 4

public Plugin myinfo =
{
	name = "[WC] Skulls Manager",
	author = "Der Helfer",
	description = "Skulls management",
	version = "1.6.0",
	url = "https://github.com/DerHelfer/WCS_SkullsManager"
};

/*
изменяет количество черепов игрока
@param userid индекс игрока на сервере
@param type режим изменения, где
+ '=' - установить
+ '+' - добавить
+ '-' - вычесть
@param amount количество черепов
*/
bool ChangeSkulls(const int userid, const char type, const int amount)
{
	switch (type)
	{
		case '=':
		{
			if (WCS_SetSkulls(userid, amount))
			{
				PrintToChat(userid, "[Skulls] Администратор установил вам %d череп(а/ов)", amount);
			}
			else
			{
				return false;
			}
		}
		case '+':
		{}
		case '-':
		{}
	}

	return true;
}

public void OnPluginStart()
{
	RegConsoleCmd("wcs_setskulls", SetSkulls_Callback, "Устанавливает игроку определенное количество черепов");
}

/* wcs_setskulls <#userid> <amount> */
Action SetSkulls_Callback(int client, int args)
{
	// проверка на WCS админа
	if (WCS_GetWcsAdmin(client))

	// проверка на все аргументы
	if (args < 3)
	{
		ReplyToCommand(client, "Usage: wcs_setskulls <#userid> <amount>");
	}

	// получаем индекс цели и количество черепов
	char buffer[32];
	GetCmdArg(1, buffer, sizeof(buffer));
	int target = GetClientOfUserId(StringToInt(buffer));
	GetCmdArg(2, buffer, sizeof(buffer));
	int skulls = StringToInt(buffer);

	// изменяем черепа цели и оповещаем об этом
	if (ChangeSkulls(target, '=', skulls))
	{
		ReplyToCommand(client, "[Skulls] Игроку %n установлено %d череп(а/ов)", target, skulls);
	}

	return Plugin_Handled;
}