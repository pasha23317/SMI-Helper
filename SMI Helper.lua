script_name('SobHelper')
script_author('Pasha')
script_description('Helper')
-- Запуск библиотек
require "lib.moonloader" -- подключаем библиотеку moonloader
local dlstatus = require('moonloader').download_status

local keys = require "vkeys" -- подключаем библиотеку vkeys
local tag = "{FF1493}[SMI Helper] {FFD700}SMI Helper v.0.35 beta запущен" -- при запуске скрипта будет этот текст
local imgui = require "imgui" -- подключаем библиотеку imgui
local encoding = require "encoding" -- подключаем библиотеку encoding
local inicfg = require "inicfg" -- подключаем библиотеку inicfg
local hook = require 'lib.samp.events' -- подключаем библиотеку events
local mem = require("memory") -- подключаем библиотеку memory
local ImVec2 = imgui.ImVec2
main_window_state = imgui.ImBool(false) -- 1 имгуи
local hud_SobHelper = imgui.ImBool(false) -- 2 имгуи

local ID = imgui.ImInt(0) -- текстовое поле
local zader = imgui.ImInt(0) -- текстовое поле
local nickname = imgui.ImBuffer(4096) -- текстовое поле ника
local zaderlekc = imgui.ImInt(0) -- текстовое поле задержки лекций
local nooltext = imgui.ImBuffer(1) -- пустое текстовое поле
local idsob = imgui.ImInt(0)
local TextInChat = imgui.ImBuffer(4096)
local mymsg = {}

-- ДЛЯ ОБНОВЛЕНИЯ СКРИПТА
update_state = false
local script_vers = 2 -- Версия скрипта
local script_vers_text = "1.05" -- Текстовая версия скрипта, для оповещения пользователя

local update_url = "https://raw.githubusercontent.com/pasha23317/SMI-Helper/main/update.ini" -- ссылка на ини файл
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/pasha23317/SMI-Helper/main/SMI%20Helper.lua"
local script_path = thisScript().path
-- КОНЕЦ ПЕРЕМЕННЫХ ОБНОВЛЕНИЯ

local tag = "{FF1493}[SMI Helper] {FFD700}SMI Helper v." .. script_vers_text .. " запущен" -- при запуске скрипта будет этот текст


-- Эфиры
local smi = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local mz = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local as = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local arm = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local tsr = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local pd = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local pravo = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local cb = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local stk = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096

-- Лекции
local lec0 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local lec1 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local lec2 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local lec3 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local lec4 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local lec5 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local lec6 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096
local lec7 = imgui.ImBuffer(4096) -- текстовое поле с ограничением символов в 4096


local selected = 0 -- переменая для меню сверху
local colvo = imgui.ImInt(1) -- кол-во эфиров
local namelekc = imgui.ImBuffer(4096) -- текстовое поле для названия лекций
local titles = {"Эфиры", "Лекции", "Настройки", "Тест"} -- таблица названий окон, зависит от selected
local x, y = getScreenResolution() -- получаем размер экрана
local selectedlist = imgui.ImInt(-1) -- переменная, в которую будет записан индекс выбранного элемента
local selectedlec = imgui.ImInt(-1) -- Переменная лекций
local medcard = false -- состояние показа мед карты
local passport = false -- состояние показа паспорта
local doljnost = "Нет"
encoding.default = "CP1251" -- смена кодировки
u8 = encoding.UTF8
local mainIni = inicfg.load({ -- загрузка файла ini, если такого нет
	sobes = -- название пункта таблицы
	{
		smi = u8"/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лос-Сантос •°•°•°•°•&/news Доброго времени суток уважаемые жители штата.&/news Мы приглашаем вас на собеседование в Радиоцентр СМИ г.Лос-Сантос.&/news Здесь вы будете чувствовать себя уютно, заместители помогут вам во всем.&/news Так же, мы выдаём лучшим сотрудникам дня ежедневные премии от 200.000$.&/news Наш Радиоцентр находится в удобном расположении, рядом с нами находится...&/news ...центральный банк, чуть дальше больница и центральный рынок.&/news При прохождении стажировки мы выдаём премию в размере 100.000$.&/news Так же, на офф.портале штата вы можете найти задания для доп.заработка...&/news ...в которых вы можете дополнительно получить от 600.000$ каждый день!&/news Так же Репортеры у нас могут заработать до 5.000.000$ за проведение эфиров!&/news Чтобы устроится к нам на работу вам нужно иметь паспорт с 3-хлетней пропиской в штате.&/news Мед.карту и конечно же хорошее настроение и желание общаться с сотрудниками.&/news Приглашаем вас в СМИ г.Лос-Сантос, ждём вас в холле радиоцентра!&/news •°•°•°•°• Музыкальная заставка Радиоцентра г.Лос-Сантос •°•°•°•°•",
		mz = u8"/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•&/news Доброго времени суток, уважаемые радиослушатели.&/news Всегда хотели попробовать себя в роли доброго доктора Айболита? Или же...&/news ...хотели помогать тяжело раненным гражданам получить 2 жизнь.&/news Тогда именно для вас сейчас проходит собеседование в больницу г.Лос-Сантос.&/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив.&/news Чтобы пройти собеседование вам нужно проживать 3 года в штате...&/news ... и иметь при себе паспорт,мед карту и пакет лицензий и быть законопослушным.&/news Собеседование проходит в холле больницы города Лос-Сантос.&/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•",
		as = u8"/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•&/news Добрый день штат, говорит радиоцентр г.Лос-Сантос.&/news Ваша мечта обучать людей? Нравится давать людям новые знания?&/news Тогда сейчас ваш шанс! Сейчас проходит собеседование в Автошколу!&/news Вас ждет добрый и позитивный коллектив и добросовестное начальство!&/news Критерии: прописка от 3-х лет,иметь паспорт и мед.карту. Быть в опрятном виде.&/news Собеседование проходит в холле офиса Автошколы.&/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•",
		arm = u8"/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•&/news Добрый день Штат,вещает радиоцентр города Лос-Сантос.&/news Вы всегда хотели служить в лучших войсках штата?&/news Хотите получить высокий чин и отдать долг Штату? Тогда это ваш шанс!&/news Сейчас проходит призыв в войска города Лос-Сантос.&/news При себе иметь пакет документов,паспорт и мед.карту,быть в опрятном виде.&/news Призыв проходит в военкомате города Лос-Сантос.&/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•",
		tsr = u8"/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•&/news Вы всегда мечтали защищать Штат от преступников? Хотите помочь Штату?&/news Тогда именно сейчас и именно для Вас проходит собеседование в Тюрьму Строгого Режима.&/news Только там вас ждет хорошая заработная плата...&/news ...карьерный рост и дружный коллектив.&/news И не забывайте ,по мимо дубинки и оружия вам выдадут новый комплект наручников.&/news Критерии: иметь полный пакет документов, проживать в штате не менее 3-х лет...&/news ...быть законопослушным гражданином и иметь опрятный вид.&/news Собеседование проходит в Военкомате города Лас-Вентурас. Не упустите свой шанс.&/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•",
		pd = u8"/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•&/news Доброго времени суток, уважаемые радиослушатели.&/news Сейчас проходит собеседование в полицейский департамент г.Лос-Сантос.&/news Вас ждет: большая зарплата, ежедневные премии и добросовестный коллектив&/news Чтобы пройти собеседование вам нужно иметь при себе...&/news ..паспорт,мед.карту,военный билет и быть законопослушным гражданином&/news Собеседование проходит в холле полицейского участка г.Лос-Сантос.&/news •°•°•°•°• Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•",
		pravo = u8"/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•&/news Добрый день Штат,вещает радиоцентр города Лос-Сантос .&/news Вы всегда хотели работать с бумагами? Быть приближенным к губернатору?&/news Тогда именно для вас проходит собеседование в Мэрию города Лос Сантос.&/news Отличный карьерный рост,большая зарплата,дружелюбный коллектив.&/news Критерии: иметь пакет документов,паспорт и мед.карту,быть в опрятном виде&/news Также быть законопослушным гражданином.&/news Собеседование проходит в холле Мэрии города г.Лос-Сантос.&/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•",
		cb = u8"/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•&/news Добрый день Штат,вещает радиоцентр города Лос-Сантос.&/news Вы всегда хотели попробовать себя в банковском деле? Или же...&/news ...проводить кучу операций со счетами?&/news Тогда именно для вас сейчас проходит собеседование в Центральный банк.&/news Именно тут, за отчеты, оставленные на портале штата даются премии!&/news Критерии: От 3-х лет в штате, иметь пакет документов, а так же быть...&/news ...законопослушным и быть опрятно одетым.&/news Собеседование проходит в Центральном банке г.Лос-Сантос. Ждем именно вас.&/news •°•°•°•° Музыкальная заставка « Радиоцентра г.Лос-Сантос » •°•°•°•°•",
		stk = u8"/news •°•°•°•° Музыкальная заставка «Радиоцентра г. Лос-Сантос •°•°•°•°•&/news Добрый день Штат, вещает радиоцентр города Лос-Сантос.&/news Вы всегда хотели работать с бумагами? Страховать гражданам штата авто или недвижимость?&/news Тогда именно для вас проходит собеседование в Страховую компанию г.Сан-Фиерро.&/news Вас ждет: отличный карьерный рост, большая зарплата, дружелюбный коллектив.&/news Критерии: иметь пакет документов, паспорт и мед.карту, быть в опрятном виде&/news Также быть законопослушным гражданином.&/news Собеседование проходит в холле Страховой компании г. Сан-Фиерро.&/news •°•°•°•° Музыкальная заставка «Радиоцентра г. Лос-Сантос •°•°•°•°•"
	},
	lekc = 
	{
		lec0 = u8"/rb Уважаемые сотрудники радиоцентра...&/rb Прошу всех зайти в рацию Discord, так-как...&/rb именно за Discord вам выдается большая премия!&/rb Discord Вы можете найти на офф. портале штата.&/rb Для этого зайдите на форум ->Brainburg -> гос.структуры...&/rb -> Средства Массовой Информации -> Спец.рация Discord.&/rb Спасибо за внимание!",
		lec1 = u8"/r Уважаемые сотрудники радиоцентра.&/r Просьба зайти на офф.портал штата.&/rb Там вы увидите новую тему помощи новичкам.&/rb Если Вы что-то не понимаете лучше сначала заглянуть туда.&/rb Спасибо всем за внимание!",
		lec2 = u8"",
		lec3 = u8"",
		lec4 = u8"",
		lec5 = u8"",
		lec6 = u8"",
		lec7 = u8""
	},
	settings = 
	{
		Female = false,
		x = 0,
		y = 0,
		xr = 0,
		yr = 0,
		zader = 0,
		zaderlekc = 0,
		nickname = u8" ",
		hud = true
	}
}, "SobHelper") -- как будет называться файл
local zader = imgui.ImInt(mainIni.settings.zader) -- загружаем переменную из ini
local zaderlekc = imgui.ImInt(mainIni.settings.zaderlekc) -- загружаем переменную из ini
local Female = imgui.ImBool(mainIni.settings.Female) -- загружаем переменную из ini
local nickname = imgui.ImBuffer(mainIni.settings.nickname, 4096) -- загружаем переменную из ini
local hud = imgui.ImBool(mainIni.settings.hud)

-- Эфиры
local smi = imgui.ImBuffer(mainIni.sobes.smi:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local mz = imgui.ImBuffer(mainIni.sobes.mz:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local as = imgui.ImBuffer(mainIni.sobes.as:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local arm = imgui.ImBuffer(mainIni.sobes.arm:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local tsr = imgui.ImBuffer(mainIni.sobes.tsr:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local pd = imgui.ImBuffer(mainIni.sobes.pd:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local pravo = imgui.ImBuffer(mainIni.sobes.pravo:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local cb = imgui.ImBuffer(mainIni.sobes.cb:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local stk = imgui.ImBuffer(mainIni.sobes.stk:gsub("&", "\n"), 4096) -- загружаем переменную из ini

-- Лекции
local lec0 = imgui.ImBuffer(mainIni.lekc.lec0:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local lec1 = imgui.ImBuffer(mainIni.lekc.lec1:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local lec2 = imgui.ImBuffer(mainIni.lekc.lec2:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local lec3 = imgui.ImBuffer(mainIni.lekc.lec3:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local lec4 = imgui.ImBuffer(mainIni.lekc.lec4:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local lec5 = imgui.ImBuffer(mainIni.lekc.lec5:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local lec6 = imgui.ImBuffer(mainIni.lekc.lec6:gsub("&", "\n"), 4096) -- загружаем переменную из ini
local lec7 = imgui.ImBuffer(mainIni.lekc.lec7:gsub("&", "\n"), 4096) -- загружаем переменную из ini

function main() -- главная функция
	if not isSampAvailable or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	repeat
		wait(0)
    until sampIsLocalPlayerSpawned()
	lua_thread.create(function()
		wait(3000)
		sampSendChat('/stats')
	end)
	sampRegisterChatCommand("shelp", cmd_imgui) -- рега команды shelp
	sampRegisterChatCommand("mb", cmd_members) -- рега команды mb
	sampRegisterChatCommand("jp", cmd_jp) -- рега команды jp
	sampRegisterChatCommand("tm", cmd_tm) -- рега команды tm
	sampRegisterChatCommand("invite", cmd_invite) -- рега
	sampRegisterChatCommand("uninvite", cmd_uninvite)
	sampRegisterChatCommand("giverank", cmd_giverank)
	sampRegisterChatCommand("fwarn", cmd_fwarn)
	sampRegisterChatCommand("unfwarn", cmd_unfwarn)
	sampRegisterChatCommand("shr", cmd_shr) -- рега команды shr
	sampRegisterChatCommand("tt", cmd_tt)
	imgui.Process = true -- процесс окна imgui, окна друг от друга не зависят
	sampAddChatMessage(tag, -1) -- отправляем в чат запрузку скрипта
	sobes = nooltext -- присваиваем текстовому полю пустое значение
	lekc = nooltext -- присвоим нулевое значение
	
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path) -- Получаем таблицу ини с гитхаба
			if tonumber(updateIni.info.vers) > script_vers then -- Если версия с гитхаба больше, чем версия в коде скрипта то
				sampAddChatMessage("Есть обновление скрипта. Версия: " .. updateIni.info.vers_text, -1)
				update_state = true
			end
			os.remove(update_path)
		end
	end)
	
	while true do -- пока истина то
		wait(0) -- ждем 0 мсек
		if update_state then -- сли есть обновление и update_state = true, то скачивается файл
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("Скрипт успешно обновлен!", -1)
					thisScript():reload() -- Перезапустит скрипт с новой версией
				end
			end)
			break
		end
		if main_window_state.v == false then -- если главное окно не активно то
			imgui.ShowCursor = false -- показ курсора выключить
		end
		result, ped = getCharPlayerIsTargeting(PLAYER_HANDLE) -- получаем хендл на которого смотрим
        if result then -- если истина
			_, i = sampGetPlayerIdByCharHandle(ped) -- получаем айди персонажа по хендлу
			idsob.v = i -- текстовое поле = айди
		end
		if wasKeyPressed(VK_E) and (main_window_state.v == true ) and not sampIsChatInputActive() then -- если нажата клавиша E и главное акно активно то
			imgui.ShowCursor = false --выключить курсор
			main_window_state.v = false -- выключить главное окно
		end
		if wasKeyPressed(VK_Q) and not sampIsChatInputActive() and not sampIsCursorActive() then -- если нажата клавиша Q и курсор не активен то
			interior = getCharActiveInterior(PLAYER_PED)
			if interior == 18 then
				imgui.ShowCursor = true -- показать курсор
				main_window_state.v = true -- включить главное окно
			end
		end
		local Xp, Yp, Zp = getCharCoordinates(PLAYER_PED) -- получаем наши координаты
		carp = findAllRandomVehiclesInSphere(Xp, Yp, Zp, 2, false, true) -- Проверяем есть ли машина в радиусе 2-х метров
		if wasKeyPressed(VK_L) and not sampIsChatInputActive() and not sampIsCursorActive() and carp == true then -- если нажата клавиша L и курсор не активен то
			sampSendChat("/lock")
		end
		if wasKeyPressed(VK_K) and not sampIsChatInputActive() and not sampIsCursorActive() and isCharInAnyCar(PLAYER_PED) == true then -- если нажата клавиша K и курсор не активен и мы находимся в машине то
			sampSendChat("/key")
		end
		if hud.v == true then
			hud_SobHelper.v = true
		else
			hud_SobHelper.v = false
		end
	end
end
function split(str, delim, plain) -- функция фипа, которая сделала биндер рабочим
    local tokens, pos, plain = {}, 1, not (plain == false)
    repeat
        local npos, epos = string.find(str, delim, pos, plain)
        table.insert(tokens, string.sub(str, pos, npos and npos - 1))
        pos = epos and epos + 1
    until not pos
    return tokens
end
function cmd_tt(arg)
	sampAddChatMessage("Версия - 1.01", -1)
end
function cmd_fwarn(arg)
	if doljnost ~= "Нет" then 
		if arg ~= "" then 
			if (rank >= 9) then
				lua_thread.create(function()
					id, reson = arg:match("(%d+) (.*)")
					nick = sampGetPlayerNickname(id)
					pnickname = nick:gsub("_", " ")
					sampSendChat("/me " .. (Female.v and "взяла " or "взял ") .. "в руки планшет управления составом")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "выбрала" or "выбрал") .. " пункт выговоры")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "выдала сотруднику " or "выдал сотруднику ") .. pnickname .. " выговор")
					wait(1600)
					sampSendChat("/fwarn " .. id .. " " .. reson)
				end)
			elseif rank < 9 then
				sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}У Вас должен быть 9+ ранг для выполнения этой команды!", -1)
			end
		elseif arg == "" then
			sampAddChatMessage("{EB052B}[{ffffff}Ошибка{EB052B}]{ffffff} Используйте: {EB052B}/fwarn [id] [причина]", -1)
		end
	elseif doljnost == "Нет" then
		sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}Вы не авторизованы в скрипте, введите /stats для авторизации!", -1)
	end
end
function cmd_unfwarn(arg)
	if doljnost ~= "Нет" then 
		if arg ~= "" then 
			if (rank >= 9) then
				lua_thread.create(function()
					nick = sampGetPlayerNickname(arg)
					pnickname = nick:gsub("_", " ")
					sampSendChat("/me " .. (Female.v and "взяла " or "взял ") .. "в руки планшет управления составом")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "выбрала" or "выбрал") .. " пункт выговоры")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "сняла сотруднику " or "снял сотруднику ") .. pnickname .. " выговор")
					wait(1600)
					sampSendChat("/unfwarn " .. arg)
				end)
			elseif rank < 9 then
				sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}У Вас должен быть 9+ ранг для выполнения этой команды!", -1)
			end
		elseif arg == "" then
			sampAddChatMessage("{EB052B}[{ffffff}Ошибка{EB052B}]{ffffff} Используйте: {EB052B}/unfwarn [id]", -1)
		end
	elseif doljnost == "Нет" then
		sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}Вы не авторизованы в скрипте, введите /stats для авторизации!", -1)
	end
end
function cmd_giverank(arg)
	if doljnost ~= "Нет" then 
		if arg ~= "" then 
			if (rank >= 9) then
				lua_thread.create(function()
					id, rankup = arg:match("(%d+) (.*)")
					nick = sampGetPlayerNickname(id)
					pnickname = nick:gsub("_", " ")
					sampSendChat("/me " .. (Female.v and "взяла " or "взял ") .. "в руки планшет управления составом")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "выбрала" or "выбрал") .. " пункт повысить")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "изменила сотрудику " or "изменил сотруднику ") .. pnickname .. " должность")
					wait(1600)
					sampSendChat("Поздравляю с новой должностью!")
					wait(1600)
					sampSendChat("/giverank " .. id .. " " .. rankup)
				end)
			elseif rank < 9 then
				sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}У Вас должен быть 9+ ранг для выполнения этой команды!", -1)
			end
		elseif arg == "" then
			sampAddChatMessage("{EB052B}[{ffffff}Ошибка{EB052B}]{ffffff} Используйте: {EB052B}/giverank [id] [rank]", -1)
		end
	elseif doljnost == "Нет" then
		sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}Вы не авторизованы в скрипте, введите /stats для авторизации!", -1)
	end
end
function cmd_uninvite(arg)
	if doljnost ~= "Нет" then 
		if arg ~= "" then 
			if (rank >= 9) then
				lua_thread.create(function()
					id, reson = arg:match("(%d+) (.*)")
					nick = sampGetPlayerNickname(id)
					pnickname = nick:gsub("_", " ")
					sampSendChat("/me " .. (Female.v and "взяла " or "взял ") .. "в руки планшет управления составом")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "выбрала" or "выбрал") .. " пункт уволить")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "уволила " or "уволил ") .. pnickname .. " с организации")
					wait(1600)
					sampSendChat("/do Сотрудник удалён с базы.")
					wait(1600)
					sampSendChat("/uninvite " .. id .. " " .. reson)
				end)
			elseif rank < 9 then
				sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}У Вас должен быть 9+ ранг для выполнения этой команды!", -1)
			end
		elseif arg == "" then
			sampAddChatMessage("{EB052B}[{ffffff}Ошибка{EB052B}]{ffffff} Используйте: {EB052B}/uninvite [id] [причина]", -1)
		end
	elseif doljnost == "Нет" then
		sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}Вы не авторизованы в скрипте, введите /stats для авторизации!", -1)
	end
end
function cmd_invite(arg)
	if doljnost ~= "Нет" then 
		if arg ~= "" then 
			if (rank >= 9) then
				lua_thread.create(function()
					nick = sampGetPlayerNickname(arg)
					pnickname = nick:gsub("_", " ")
					sampSendChat("Вы успешно прошли собеседование!")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "достала" or "достал") .. " планшет управления составом")
					wait(1600)
					sampSendChat("/do Планшет в руке.")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "занесла " or "занёс ") .. pnickname .. " в базу")
					wait(1600)
					sampSendChat("/me " .. (Female.v and "выдала" or "выдал") .. " новую форму и ключи от шкафчика")
					wait(1600)
					sampSendChat("Вот Ваша новая форма и ключи, поздравляю!")
					wait(1600)
					sampSendChat("/invite " .. arg)
				end)
			elseif rank < 9 then
				sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}У Вас должен быть 9+ ранг для выполнения этой команды!", -1)
			end
		elseif arg == "" then
			sampAddChatMessage("{EB052B}[{ffffff}Ошибка{EB052B}]{ffffff} Используйте: {EB052B}/invite [id]", -1)
		end
	elseif doljnost == "Нет" then
		sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}Вы не авторизованы в скрипте, введите /stats для авторизации!", -1)
	end
end
function cmd_imgui(arg) -- если введена команда shelp
	main_window_state.v = not main_window_state.v -- включаем главное окно
	imgui.ShowCursor = true
end
function cmd_members(arg)
	sampSendChat("/members")
end
function cmd_jp(arg)
	sampSendChat("/jobprogress")
end
function cmd_tm(arg)
	sampSendChat("/time")
end
function cmd_op(arg)
	pnickname = sampGetPlayerNickname(ID.v)
end
function cmd_shr(arg)
	lua_thread.create(function()
		sampSendChat("/me отобрал энергетик у Райана")
		wait(1600)
		sampSendChat("/do Энергетик в руке.")
		wait(1600)
		sampSendChat("/me подарил энергетик Райану")
		wait(1600)
		sampSendChat("/todo Это тебе*подарив пустую банку")
	end)
end
function imgui.OnDrawFrame()
	BlueTheme()
	if hud_SobHelper.v then
		imgui.ShowCursor = main_window_state.v
		apply_castom_style()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.settings.x, mainIni.settings.y), imgui.Cond.FirstUseEver)
		imgui.Begin(u8("SobHelper"), hud_SobHelper, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings)
		imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"SMI Helper").x) / 2);
		imgui.Text(u8"SMI Helper")
		imgui.Separator()
		_, idp = sampGetPlayerIdByCharHandle(PLAYER_PED)
		imgui.Text(u8"Ваш ID:" .. idp)
		health = getCharHealth(PLAYER_PED)
		imgui.Text(u8"Ваше здоровье: " .. health)
		armour = getCharArmour(PLAYER_PED)
		if armour > 0 then
			imgui.Text(u8"Ваша броня: " .. armour)
		end
		usecar = isCharInAnyCar(PLAYER_PED)
		if usecar == true then
			car = storeCarCharIsInNoSave(PLAYER_PED)
			healthcar = getCarHealth(car)
			imgui.Text(u8"Состояние машины: " .. healthcar)
		end
		t=(os.date("%H",os.time())..':'..os.date("%M",os.time()).. ':'..os.date("%S", os.time()))
		d = (os.date("%d",os.time())..' '..os.date("%B",os.time()))
		imgui.Text(u8"Время: " .. t)
		imgui.Text(u8"Дата: " .. d)
		local pos = imgui.GetWindowPos()
		if (mainIni.settings.x ~= pos.x) and (mainIni.settings.y ~= pos.y) then -- если переменная zader не равна переменной в ini, то перезапись
			mainIni.settings.x, mainIni.settings.y = pos.x, pos.y
			inicfg.save(mainIni, 'SobHelper.ini') -- сохранение в конфиге
		end
		if not imgui.ShowCursor then
			imgui.SetMouseCursor(-1)
		end
		imgui.End()
	else
		hud_SobHelper.v = false
	end
	
	if main_window_state.v then
		BlueTheme()
		imgui.SetNextWindowPos(imgui.ImVec2(mainIni.settings.xr, mainIni.settings.yr), imgui.Cond.Appearing)
		imgui.Begin(u8(selected == 0 and "Собеседование" or titles[selected]), main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.MenuBar + imgui.WindowFlags.AlwaysAutoResize) -- новое окно с заголовком 'My window'
		imgui.BeginMenuBar()
			if imgui.MenuItem(u8'Собеседование') then
				selected = 0
			end
			if imgui.MenuItem(u8'Эфиры') then
				selected = 1
			end
			if imgui.MenuItem(u8'Лекции') then
				selected = 2
			end
			if imgui.MenuItem(u8'Настройки') then
				selected = 3
			end
			if imgui.MenuItem(u8'Тест') then
				selected = 4
			end
		imgui.EndMenuBar()
		local posr = imgui.GetWindowPos()
		if (mainIni.settings.xr ~= posr.x) and (mainIni.settings.yr ~= posr.y) then -- если переменная zader не равна переменной в ini, то перезапись
			mainIni.settings.xr, mainIni.settings.yr = posr.x, posr.y
			inicfg.save(mainIni, 'SobHelper.ini') -- сохранение в конфиге
		end
		if selected == 0 then
			imgui.SetCursorPosY(49)
			imgui.PushItemWidth(100)
			imgui.Text(u8"ID: ")
			imgui.SameLine()
			imgui.InputInt(u8"", idsob, 0, 0)
			imgui.SameLine()
			imgui.SetCursorPosY(49)
			imgui.SetCursorPosX(130)
			if sobesplayer == false then
				mymsg = {}
				passport = false
				medcard = false
				nameplayer, lvl, zakonka, narko = nil
			end
			if imgui.Button(u8"Начать", imgui.ImVec2(75, 18)) then
				sobesplayer = true
				nick = sampGetPlayerNickname(idsob.v)
				lua_thread.create(function()
					table.insert(mymsg, u8("{7AED07}Вы: {FFFFFF}Приветствие"))
					sampSendChat("Здравствуйте, я " .. doljnost .. " " .. u8:decode(nickname.v) .. " , вы на собеседование?")
					wait(1650)
					table.insert(mymsg, u8("{7AED07}Вы: {FFFFFF}Попросили документы"))
					sampSendChat("Хорошо, покажите ваши документы, такие как, паспорт, мед.карта")
					doki = string.format("/b Соблюдая правила РП с /me и /do, %s%s ", " /showpass " .. idp, " /showmc " .. idp);
					wait(1000)
					sampSendChat(doki)
				end)
			end
			imgui.SameLine()
			imgui.SetCursorPosX(210)
			imgui.BeginChild('textframe', imgui.ImVec2(450, 371), true)
			imgui.SetCursorPosX((450 - imgui.CalcTextSize(u8"Чат").x) / 2)
			imgui.Text(u8"Чат")
			imgui.SetCursorPosX(10)
			imgui.SetCursorPosY(20)
			imgui.BeginChild('textframe1', imgui.ImVec2(430, 320), true)
			for i = 1, #mymsg do
				if i >= 17 then
					imgui.SetScrollHere()
				end
				imgui.TextColoredRGB(u8:decode(mymsg[i]))
			end
			imgui.EndChild()
			imgui.TextColored(imgui.ImVec4(1, 0.92, 0.02, 1), u8'Вы: ')
			imgui.SameLine()
			imgui.NewInputText('', TextInChat, 338, u8'Введите сообщение тут', 2)
			imgui.SameLine()
			imgui.SetCursorPosX(375)
			if imgui.Button(u8"Отправить") then 
				sampSendChat(u8:decode(TextInChat.v))
				TextInChat.v = ""
			end
			imgui.EndChild()
			imgui.SetCursorPosY(70)
			imgui.BeginChild('info', imgui.ImVec2(200, 110), true)
			imgui.SetCursorPosY(10)
			imgui.SetCursorPosX((200 - imgui.CalcTextSize(u8"Информация о игроке").x) / 2)
			imgui.Text(u8"Информация о игроке")
			imgui.Separator()
			imgui.Text(u8"Имя: ")
			imgui.SameLine()
			if nameplayer == nil then
				imgui.TextColored(imgui.ImVec4(0.87, 0.06, 0.06, 1), u8'Нет')
			else
				imgui.Text(nameplayer)
			end
			imgui.Text(u8"Лет в штате: ")
			imgui.SameLine()
			if lvl == nil then
				imgui.TextColored(imgui.ImVec4(0.87, 0.06, 0.06, 1), u8'Нет')
			else
				if lvl < 3 then
					imgui.TextColored(imgui.ImVec4(0.87, 0.06, 0.06, 1), lvl .. u8"/3")
				else
					imgui.TextColored(imgui.ImVec4(0.17, 0.96, 0.01, 1), lvl .. u8"/3")
				end
			end
			imgui.Text(u8"Законопослушность: ")
			imgui.SameLine()
			if zakonka == nil then
				imgui.TextColored(imgui.ImVec4(0.87, 0.06, 0.06, 1), u8'Нет')
			else
				if zakonka < 35 then
					imgui.TextColored(imgui.ImVec4(0.87, 0.06, 0.06, 1), zakonka .. u8"/35")
				else
					imgui.TextColored(imgui.ImVec4(0.17, 0.96, 0.01, 1), zakonka .. u8"/35")
				end
			end
			imgui.Text(u8"Наркозависимость: ")
			imgui.SameLine()
			if narko == nil then
				imgui.TextColored(imgui.ImVec4(0.87, 0.06, 0.06, 1), u8'Нет')
			else
				if narko > 100 then
					imgui.TextColored(imgui.ImVec4(0.87, 0.06, 0.06, 1), narko .. u8"/100")
				else
					imgui.TextColored(imgui.ImVec4(0.17, 0.96, 0.01, 1), narko .. u8"/100")
				end
			end
			imgui.EndChild()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.FrameBg]               = ImVec4(0.00, 0.00, 0.00, 0.00);
			imgui.BeginChild('left pane', imgui.ImVec2(200, 105), true)
			imgui.SetCursorPosX((200 - imgui.CalcTextSize(u8"Отказы").x) / 2)
			imgui.Text(u8"Отказы")
			imgui.Separator()
			local badplayer = imgui.ImInt(-1)
			imgui.PushItemWidth(118)
			imgui.SetCursorPosX((200 - imgui.CalcTextSize(u8"Наркозависимость").x) / 2)
			if imgui.ListBox('##listboxx', badplayer, {u8'нонРП ник)', u8'Нет паспорта', u8'Нет мед карты', u8"Наркозависимость"}, 4) then
				if badplayer.v == 0 then
					sampSendChat("К сожалению вы нам не подходите, у вас опечатка в паспорте")
					lua_thread.create(function()
						wait(1650)
						sampSendChat("/b у Вас нонРП ник, смените его в настройках.")
						sobesplayer = false
					end)
				elseif badplayer.v == 1 then
					sampSendChat("Если у вас нет паспорта, то Вы можете получить его в Мэрии")
					lua_thread.create(function()
						wait(1650)
						sampSendChat("/b /gps -> Важные места -> [LS] Мэрия")
						sobesplayer = false
					end)
				elseif badplayer.v == 2 then
					sampSendChat("Если у Вас нет мед.карты, то вы можете получить ее в больнице")
					lua_thread.create(function()
						wait(1650)
						sampSendChat("/b /gps -> Важные места -> [LS] Больница")
						sobesplayer = false
					end)
				elseif badplayer.v == 3 then
					sampSendChat("Вы наркозависимы, вылечитесь от наркозависимости в больнице")
					lua_thread.create(function()
						wait(1650)
						sampSendChat("/b /gps -> Важные места -> [LS] Больница")
						wait(1650)
						sampSendChat("/b Нужно менее 100 наркозависимости.")
						sobesplayer = false
					end)
				end
			end
			imgui.PopItemWidth()
			imgui.EndChild()
			if imgui.Button(u8"Расскажите о себе", imgui.ImVec2(200, 20)) then
				sampSendChat('Хорошо, сейчас я вам задам несколько вопросов')
				lua_thread.create(function()
					wait(1650)
					sampSendChat('Расскажите о себе.')
					table.insert(mymsg, u8("{7AED07}Вопрос: {FFFFFF}Расскажите о себе."))
				end)
			end
			if imgui.Button(u8"Почему мы?", imgui.ImVec2(200, 20)) then
				sampSendChat("Почему вы выбрали именно наше СМИ?")
				table.insert(mymsg, u8("{7AED07}Вопрос: {FFFFFF}Почему вы выбрали именно наше СМИ?"))
			end
			if imgui.Button(u8"Что такое СМИ?", imgui.ImVec2(200, 20)) then
				sampSendChat('Расшифруйте аббревиатуру "СМИ"')
				table.insert(mymsg, u8('{7AED07}Вопрос: {FFFFFF}Расшифруйте аббревиатуру "СМИ"'))
			end
			if imgui.Button(u8"Есть ли опыт работы?", imgui.ImVec2(200, 20)) then
				sampSendChat('Имеете ли опыт в данной сфере?')
				table.insert(mymsg, u8('{7AED07}Вопрос: {FFFFFF}Имеете ли опыт в данной сфере?'))
			end
			if imgui.Button(u8"Принять в СМИ", imgui.ImVec2(200, 20)) then
				if doljnost ~= "Нет" then
					if rank < 9 then
						_, idp = sampGetPlayerIdByCharHandle(PLAYER_PED)
						sampSendChat("Поздравляю, вы прошли собеседование!")
						lua_thread.create(function()
							nick = sampGetPlayerNickname(idsob.v)
							pnickname = nick:gsub("_", " ")
							wait(1650)
							playergood = pnickname .. " прошел(а) собеседование"
							sampSendChat("/r " .. playergood)
							wait(1650)
							sampSendChat("Ожидайте заместителей или директора.")
							sobesplayer = false
						end)
					end
					if rank >= 9 then
						_, idp = sampGetPlayerIdByCharHandle(PLAYER_PED)
						lua_thread.create(function()
							nick = sampGetPlayerNickname(idsob.v)
							pnickname = nick:gsub("_", " ")
							sampSendChat("Вы успешно прошли собеседование!")
							wait(1600)
							sampSendChat("/me " .. (Female.v and "достала" or "достал") .. " планшет управления составом")
							wait(1600)
							sampSendChat("/do Планшет в руке.")
							wait(1600)
							sampSendChat("/me " .. (Female.v and "занесла " or "занёс ") .. pnickname .. " в базу")
							wait(1600)
							sampSendChat("/me " .. (Female.v and "выдала" or "выдал") .. " новую форму и ключи от шкафчика")
							wait(1600)
							sampSendChat("Вот Ваша новая форма и ключи, поздравляю!")
							wait(1600)
							sampSendChat("/invite " .. idsob.v)
							sobesplayer = false
						end)
					end
				elseif doljnost == "Нет" then
					sampAddChatMessage("{EB052B}[Ошибка выполнения сценария] {02B4F5}Вы не авторизованы в скрипте, введите /stats для авторизации!", -1)
				end
			end
		end
		if selected == 1 then
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			imgui.BeginChild('gg', imgui.ImVec2(55, 195), true)
			imgui.TextColored(imgui.ImVec4(1.00, 0.50, 0.37, 0.83), u8'Собесы')
			imgui.Separator()
			imgui.PushItemWidth(55)
			colors[clr.Header]                 = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]               = ImVec4(0.00, 0.00, 0.00, 0.00);
			if imgui.ListBox('##listbox', selectedlist, {u8'СМИ', u8'МЗ', u8'AS', u8'ЛСА', u8'ТСР', u8'ПД', u8'Право', u8'ЦБ', u8'СТК'}, 9) then
				if selectedlist.v == 0 then
					sobes = smi
				elseif selectedlist.v == 1 then
					sobes = mz
				elseif selectedlist.v == 2 then
					sobes = as
				elseif selectedlist.v == 3 then
					sobes = arm
				elseif selectedlist.v == 4 then
					sobes = tsr
				elseif selectedlist.v == 5 then
					sobes = pd
				elseif selectedlist.v == 6 then
					sobes = pravo
				elseif selectedlist.v == 7 then
					sobes = cb
				elseif selectedlist.v == 8 then
					sobes = stk
				end
			end
			imgui.EndChild()
			colors[clr.FrameBg]              = ImVec4(0.11, 0.11, 0.11, 1.00)
			imgui.SameLine()
			imgui.BeginChild('ggs', imgui.ImVec2(350, 195), true)
			imgui.InputTextMultiline("##sobes", sobes, imgui.ImVec2(-0.1, 188))
			imgui.EndChild()
			imgui.Text(u8("Введите задержку(сек): "))
			imgui.PushItemWidth(80)
			imgui.SameLine()
			imgui.InputInt("##zader", zader, 0, 0)
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.07, 0.65, 0.87, 1), u8'По стандарту - 6 секунд')
			imgui.Text(u8("Введите кол-во эфиров: "))
			imgui.PushItemWidth(79)
			imgui.SameLine()
			imgui.InputInt("##colvo", colvo, 0, 0)
			if colvo.v == 0 then
				colvo.v = 1
			end
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.89, 0.05, 0.19, 1), u8'Минимум 1 эфир(beta)')
			if imgui.Button(u8"Запустить собеседование", imgui.ImVec2(-0.1, 20)) then
				offzader = 1
				lua_thread.create(function()
					for i = 1, colvo.v do
						local strings = split(u8:decode(sobes.v), '\n', false)
						for i,g in ipairs(strings) do
							if offzader == 1 then
								wait(0)
								offzader = 0
							else
								wait(zader.v*1000)
							end
							sampSendChat(g)
						end
						wait(1300)
						sampSendChat("/time")
						wait(1300)
						setVirtualKeyDown(119, true) -- нажать клавишу F8(Скриншот)
						wait(10) -- ждать 10 мсек
						setVirtualKeyDown(119, false) -- отжать клавишу F8
						allzader = zader.v*1000 -- переменная для вычитания погрешности
						allzader = 30000 - allzader -- вместо 30000 переменная кулдауна между эфирами
						sampAddChatMessage("Проведен(о) {00E8A6}" .. i .. " {FFFFFF}эфир(ов) из {00E8A6}" .. colvo.v, -1)
						wait(allzader)
					end
				end)
			end
			if (mainIni.sobes.smi ~= smi.v:gsub("\n", "&")) or (mainIni.sobes.mz ~= mz.v:gsub("\n", "&")) or (mainIni.sobes.as ~= as.v:gsub("\n", "&")) or (mainIni.sobes.arm ~= arm.v:gsub("\n", "&")) or (mainIni.sobes.tsr ~= tsr.v:gsub("\n", "&")) or (mainIni.sobes.pd ~= pd.v:gsub("\n", "&")) or (mainIni.sobes.pravo ~= pravo.v:gsub("\n", "&")) or (mainIni.sobes.cb ~= cb.v:gsub("\n", "&")) or (mainIni.settings.zader ~= zader.v) or (mainIni.sobes.stk ~= stk.v) then
				mainIni.sobes.smi = smi.v:gsub("\n", "&")
				mainIni.sobes.mz = mz.v:gsub("\n", "&")
				mainIni.sobes.as = as.v:gsub("\n", "&")
				mainIni.sobes.arm = arm.v:gsub("\n", "&")
				mainIni.sobes.tsr = tsr.v:gsub("\n", "&")
				mainIni.sobes.pd = pd.v:gsub("\n", "&")
				mainIni.sobes.pravo = pravo.v:gsub("\n", "&")
				mainIni.sobes.cb = cb.v:gsub("\n", "&")
				mainIni.sobes.stk = stk.v:gsub("\n", "&")
				mainIni.settings.zader = zader.v
				inicfg.save(mainIni, 'SobHelper.ini')
			end
		end
		if selected == 2 then
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			imgui.BeginChild('ggvp', imgui.ImVec2(55, 180), true)
			imgui.TextColored(imgui.ImVec4(0.00, 1.00, 0.67, 0.62), u8'Лекции')
			imgui.Separator()
			imgui.PushItemWidth(55)
			colors[clr.Header]                 = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]               = ImVec4(0.00, 0.00, 0.00, 0.00)
			if imgui.ListBox('##listlec', selectedlec, {u8'Лекц0', u8'Лекц1', u8'Лекц2', u8'Лекц3', u8'Лекц4', u8'Лекц5', u8'Лекц6', u8'Лекц7'}, 8) then
				if selectedlec.v == 0 then
					lekc = lec0
				elseif selectedlec.v == 1 then
					lekc = lec1
				elseif selectedlec.v == 2 then
					lekc = lec2
				elseif selectedlec.v == 3 then
					lekc = lec3
				elseif selectedlec.v == 4 then
					lekc = lec4
				elseif selectedlec.v == 5 then
					lekc = lec5
				elseif selectedlec.v == 6 then
					lekc = lec6
				elseif selectedlec.v == 7 then
					lekc = lec7
				end
			end
			imgui.EndChild()
			colors[clr.FrameBg]              = ImVec4(0.11, 0.11, 0.11, 1.00)
			colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
			imgui.SameLine()
			imgui.BeginChild('ggg', imgui.ImVec2(350, 180), true)
			imgui.InputTextMultiline("##lec", lekc, imgui.ImVec2(-0.1, 173))
			imgui.EndChild()
			imgui.Text(u8"Введите название лекции: ")
			imgui.SameLine()
			imgui.PushItemWidth(50)
			imgui.InputText("", namelekc)
			imgui.Text(u8("Введите задержку(сек): "))
			imgui.PushItemWidth(50)
			imgui.SameLine()
			imgui.InputInt("##zaderlekc", zaderlekc, 0, 0)
			if (mainIni.lekc.lec0 ~= lec0.v:gsub("\n", "&")) or (mainIni.lekc.lec1 ~= lec1.v:gsub("\n", "&")) or (mainIni.lekc.lec2 ~= lec2.v:gsub("\n", "&")) or (mainIni.lekc.lec3 ~= lec3.v:gsub("\n", "&")) or (mainIni.lekc.lec4 ~= lec4.v:gsub("\n", "&")) or (mainIni.lekc.lec5 ~= lec5.v:gsub("\n", "&")) or (mainIni.lekc.lec6 ~= lec6.v:gsub("\n", "&")) or (mainIni.lekc.lec7 ~= lec7.v:gsub("\n", "&")) then
				mainIni.lekc.lec0 = lec0.v:gsub("\n", "&")
				mainIni.lekc.lec1 = lec1.v:gsub("\n", "&")
				mainIni.lekc.lec2 = lec2.v:gsub("\n", "&")
				mainIni.lekc.lec3 = lec3.v:gsub("\n", "&")
				mainIni.lekc.lec4 = lec4.v:gsub("\n", "&")
				mainIni.lekc.lec5 = lec5.v:gsub("\n", "&")
				mainIni.lekc.lec6 = lec6.v:gsub("\n", "&")
				mainIni.lekc.lec7 = lec7.v:gsub("\n", "&")
				inicfg.save(mainIni, 'SobHelper.ini') 
			end
			imgui.SameLine()
			if imgui.Button(u8"Начать лекцию", imgui.ImVec2(-0.1, 20)) then
				lua_thread.create(function()
					local strings = split(u8:decode(lekc.v), '\n', false)
					for i,g in ipairs(strings) do
						sampSendChat(g)
						wait(zaderlekc.v*1000)
					end
				end)
			end
			if (mainIni.settings.zaderlekc ~= zaderlekc.v) then -- если переменная zader не равна переменной в ini, то перезапись
				mainIni.settings.zaderlekc = zaderlekc.v
				inicfg.save(mainIni, 'SobHelper.ini') -- сохранение переменной в ini
			end
		end
		if selected == 3 then
			if imgui.CollapsingHeader(u8'Информация о вас') then
				if doljnost ~= "Нет" then
					imgui.Text(u8("Должность: " .. doljnost .. "[" .. rank .. "]"))
				else
					imgui.TextColored(imgui.ImVec4(0.89, 0.05, 0.19, 1), u8'Скрипт не авторизован!\nВведите /stats чтобы предотвратить краши')
				end
				imgui.TextColored(imgui.ImVec4(0.08, 0.92, 0.88, 1), u8"Ваш ник(Рус): ")
				imgui.SameLine()
				imgui.PushItemWidth(140)
				imgui.InputText("", nickname)
			end
			if imgui.CollapsingHeader(u8'Настройки') then
				imgui.Checkbox(u8"Женские отыгровки",Female)
				imgui.Checkbox(u8"Худ",hud)
			end
			if (mainIni.settings.Female ~= Female.v) or (mainIni.settings.nickname ~= nickname.v) or (mainIni.settings.hud ~= hud.v) then 
				mainIni.settings.Female = Female.v
				mainIni.settings.hud = hud.v
				mainIni.settings.nickname = nickname.v
				inicfg.save(mainIni, 'SobHelper.ini')
			end
			if imgui.Button(u8"Перезагрузить", imgui.ImVec2(295, 20)) then
				thisScript():reload()
			end
		end
		if selected == 4 then
			imgui.Text(u8"Хуест")
		end
		imgui.End()
	end
end
function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end
function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val)
    if #val.v == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
    end
    imgui.PopItemWidth()
    return result
end
function hook.onShowDialog(dialogId, style, title, button1, button2, text) -- Хукаем текст с диалога
	if sobesplayer == true then -- если собеседование начато
		if title == "{BFBBBA}Паспорт" then -- если название диалога = паспорт
			nameplayer = text:match("Имя: %{FFD700%}(%w+_%w+)...\n") -- поиск текста в паспорте
			if nick == nameplayer then
				lvl = text:match("Лет в штате: %{FFD700%}(%d+)\n") -- поиск текста в паспорте
				zakonka = text:match("Законопослушность: %{.+%}(%d+)/%d+\n") -- поиск текста в паспорте
				lvl = tonumber(lvl) -- делаем переменную lvl в числовую
				zakonka = tonumber(zakonka) -- делаем переменную zakonka в числовую
				blacklist = text:match("Состоит в ЧС %{.+%}(.+)\n") -- поиск нахождения в ЧС студии в паспорте
				if blacklist == "TV студия" then -- если найден текст TV студия то
					lua_thread.create(function() -- поток функции для изспользования wait()
						sampSendChat("Вы находитесь в черном списке закона") -- послать сообщение в чат
						wait(1650) -- ждем 1.65 сек
						sampSendChat("/b У вас ЧС TV студии") -- послать сообщение в чат
					end)
				end
				if zakonka >= 35 and (lvl >= 3) and not (blacklist == "TV студия") then
					lua_thread.create(function() -- поток функции для изспользования wait()
						nick = sampGetPlayerNickname(idsob.v)
						pnickname = nick:gsub("_", " ")
						wait(400)
						sampSendChat("/me " .. (Female.v and "взяла" or "взял") .. " паспорт " .. pnickname) -- послать сообщение в чат
						wait(1650) -- ждем 1.65 сек
						sampSendChat("/do Паспорт в порядке.") -- послать сообщение в чат
						wait(1650) -- ждем 1.65 сек
						sampSendChat("/me " .. (Female.v and "отдала" or "отдал").. " паспорт обратно") -- послать сообщение в чат
						wait(1650) -- ждем 1.65 сек
						if medcard == false then -- если показ мед.карты еще не был, то
							sampSendChat("Хорошо, теперь покажите мед.карту") -- послать сообщение в чат
						end
					end)
					passport = true
					return false
				end
				if lvl < 3 and not (blacklist == "TV студия") then
					sampSendChat("Вы мало проживаете в штате")
					lua_thread.create(function()
					wait(1650)
					sampSendChat("/b Нужнен 3 уровень")
					wait(1650)
					end)
				end
				if zakonka < 35 and not (blacklist == "TV студия") then
					sampSendChat("Вы незакопослушный гражданин.")
					lua_thread.create(function()
					wait(1650)
					sampSendChat("/b Нужно 35 законопослушности.")
					wait(1650)
					end)
				end
			else
				table.insert(mymsg, u8("{7AED07}Информация: {FFFFFF}Отклонен паспорт другого игрока"))
				nameplayer = nil
				return false
			end
		end
		if title == "{BFBBBA}Мед. карта" then
			nameplayer = text:match("%{FFFFFF%}Имя: (%w+_%w+)")
			if nick == nameplayer then
			narko = text:match ("%{CEAD2A%}Наркозависимость: (%d+)")
			narko = tonumber(narko)
				lua_thread.create(function()
					nick = sampGetPlayerNickname(idsob.v)
					pnickname = nick:gsub("_", " ")
					wait(400)
					sampSendChat("/me " .. (Female.v and "взяла" or "взял") .. " мед.карту ".. pnickname)
					wait(1650)
					sampSendChat("/do Мед.карта в порядке")
					wait(1650)
					sampSendChat("/me " .. (Female.v and "отдала" or "отдал").. " мед.карту обратно")
					wait(1650)
					if passport == false then
						sampSendChat("Хорошо, теперь покажите паспорт.")
					end
				end)
				medcard = true
				if narko > 100 then
					table.insert(mymsg, u8("{7AED07}Информация: {FFFFFF}У игрока {E30B0B}высокая {FFFFFF}наркозависимость"))
				end
				return false
			else
				table.insert(mymsg, u8("{7AED07}Информация: {FFFFFF}Отклонена мед.карта другого игрока"))
				nameplayer = nil
				return false
			end
		end
	end
	if title == "{BFBBBA}Основная статистика" then
		if (doljnost == "Нет") then 
			org = text:match("{FFFFFF}Организация: {B83434}%[(.-)%]")
			if org ~= "Не имеется" then
				doljnost, rank = text:match("{FFFFFF}Должность: {B83434}(.+)%((%d+)%)\n")
				rank = tonumber(rank)
				sampAddChatMessage("Вы авторизовались как {FF4500}" .. doljnost, -1)
				return false
			else
				sampAddChatMessage("Вы не в орагнизации {FF4500}Авторизация невозможна", -1)
				doljnost = "Не определена"
				rank = 0
				return false
			end
		end
	end
end
function hook.onServerMessage(color, text)
	if text:find("Лидер (%a+_%a+) повысил до (%d+) ранга") then
		doljnost = "Нет"
		sampSendChat("/stats")
	end
	if sobesplayer == true then
		if text:find(nick .. "%[%d+%] говорит:(.+)") then
			mynick, yourmsg = text:match("(%w+_%w+)%[%d+%] .+:%{B7AFAF%} (.+)")
			yourmsg = "{07B0ED}" .. nick .. "{FFFFFF}: " .. yourmsg
			table.insert(mymsg, u8(yourmsg))
		elseif text:find(nick .. "%[%d+%] (.+)") then
			mynick, yourmsgme = text:match("(%w+_%w+)%[%d+%] (.+)")
			yourmsgme = "{07B0ED}" .. nick .. ": {FC30E8}[/me]: " .. yourmsgme
			table.insert(mymsg, u8(yourmsgme))
		elseif text:find(" (.+) - |  " .. nick .. "%[%d+%]") then
			yourmsgdo, mynick = text:match(" (.+).--.+|.+(%w+_%w+)%[%d+%]")
			yourmsgdo = "{07B0ED}" .. nick .. ": {123DF2}[/do]: " .. yourmsgdo
			table.insert(mymsg, u8(yourmsgdo))
		end
	end
end
function BlueTheme()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowRounding = 4
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 1
	style.ItemSpacing = imgui.ImVec2(3, 4)
	style.ScrollbarSize = 7
	style.ScrollbarRounding = 0
	style.GrabMinSize = 10
	style.GrabRounding = 8
	style.WindowPadding = imgui.ImVec2(5, 3)
	style.FramePadding = imgui.ImVec2(2, 2)
	style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)

	colors[clr.Text]                 = ImVec4(0.92, 0.92, 0.92, 1.00)
	colors[clr.TextDisabled]         = ImVec4(0.44, 0.44, 0.44, 1.00)
	colors[clr.WindowBg]             = ImVec4(0.06, 0.06, 0.06, 1.00)
	colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.Border]               = ImVec4(0.51, 0.36, 0.15, 1.00)
	colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg]              = ImVec4(0.11, 0.11, 0.11, 1.00)
	colors[clr.FrameBgHovered]       = ImVec4(0.51, 0.36, 0.15, 1.00)
	colors[clr.FrameBgActive]        = ImVec4(0.78, 0.55, 0.21, 1.00)
	colors[clr.TitleBg]              = ImVec4(0.51, 0.36, 0.15, 1.00)
	colors[clr.TitleBgActive]        = ImVec4(0.91, 0.64, 0.13, 1.00)
	colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.MenuBarBg]            = ImVec4(0.11, 0.11, 0.11, 1.00)
	colors[clr.ScrollbarBg]          = ImVec4(0.06, 0.06, 0.06, 0.53)
	colors[clr.ScrollbarGrab]        = ImVec4(0.21, 0.21, 0.21, 1.00)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.47, 0.47, 0.47, 1.00)
	colors[clr.ScrollbarGrabActive]  = ImVec4(0.81, 0.83, 0.81, 1.00)
	colors[clr.CheckMark]            = ImVec4(0.78, 0.55, 0.21, 1.00)
	colors[clr.SliderGrab]           = ImVec4(0.91, 0.64, 0.13, 1.00)
	colors[clr.SliderGrabActive]     = ImVec4(0.91, 0.64, 0.13, 1.00)
	colors[clr.Button]               = ImVec4(0.51, 0.36, 0.15, 1.00)
	colors[clr.ButtonHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
	colors[clr.ButtonActive]         = ImVec4(0.78, 0.55, 0.21, 1.00)
	colors[clr.Header]               = ImVec4(0.51, 0.36, 0.15, 1.00)
	colors[clr.HeaderHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
	colors[clr.HeaderActive]         = ImVec4(0.93, 0.65, 0.14, 1.00)
	colors[clr.Separator]            = ImVec4(0.21, 0.21, 0.21, 1.00)
	colors[clr.SeparatorHovered]     = ImVec4(0.91, 0.64, 0.13, 1.00)
	colors[clr.SeparatorActive]      = ImVec4(0.78, 0.55, 0.21, 1.00)
	colors[clr.ResizeGrip]           = ImVec4(0.21, 0.21, 0.21, 1.00)
	colors[clr.ResizeGripHovered]    = ImVec4(0.91, 0.64, 0.13, 1.00)
	colors[clr.ResizeGripActive]     = ImVec4(0.78, 0.55, 0.21, 1.00)
	colors[clr.CloseButton]          = ImVec4(0.47, 0.47, 0.47, 1.00)
	colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end
function apply_castom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    colors[clr.WindowBg] = ImVec4(0, 0, 0, 0.25)
end